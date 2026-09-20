package com.skeetpro.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;

import com.skeetpro.dao.OrdineDAO;
import com.skeetpro.model.Ordine;
import com.skeetpro.model.RigaOrdine;
import com.skeetpro.util.DataSourceProvider;

public class OrdineDAOImpl implements OrdineDAO {

    @Override
    public void salvaOrdine(Ordine ordine) throws Exception {
        String sqlOrdine = "INSERT INTO Ordine (Data, Stato, ClienteCF) VALUES (?, ?, ?)";
        String sqlArma = "INSERT INTO NoleggioArma (OrdineCodice, ArmaMatricola, Prezzo, Quantita, Durata) VALUES (?, ?, ?, ?, ?)";
        String sqlMun = "INSERT INTO AcquistoMunizione (OrdineCodice, MunizioniLotto, Prezzo, Quantita) VALUES (?, ?, ?, ?)";
        String sqlSess = "INSERT INTO PagamentoSessione (OrdineCodice, SessioneID, Prezzo, Quantita) VALUES (?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement psOrdine = null;
        PreparedStatement psArma = null;
        PreparedStatement psMun = null;
        PreparedStatement psSess = null;
        ResultSet rs = null;
        
        try {
            conn = DataSourceProvider.getConnection();
            conn.setAutoCommit(false); 
            
            psOrdine = conn.prepareStatement(sqlOrdine, Statement.RETURN_GENERATED_KEYS);
            psOrdine.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            psOrdine.setString(2, "Da Ritirare");
            psOrdine.setString(3, ordine.getClienteCF());
            
            int affectedRows = psOrdine.executeUpdate();
            if (affectedRows == 0) {
                throw new Exception("Creazione ordine fallita.");
            }
            
            rs = psOrdine.getGeneratedKeys();
            if (rs.next()) {
                int idOrdine = rs.getInt(1);
                ordine.setCodice(idOrdine);
                
                psArma = conn.prepareStatement(sqlArma);
                psMun = conn.prepareStatement(sqlMun);
                psSess = conn.prepareStatement(sqlSess);
                
                boolean hasArma = false, hasMun = false, hasSess = false;
                
                for (RigaOrdine riga : ordine.getRighe()) {
                    if ("Arma".equals(riga.getTipoProdotto())) {
                        psArma.setInt(1, idOrdine);
                        psArma.setString(2, riga.getIdProdotto());
                        psArma.setDouble(3, riga.getPrezzo());
                        psArma.setInt(4, riga.getQuantita());
                        psArma.setInt(5, riga.getDurata());
                        psArma.addBatch();
                        hasArma = true;
                    } else if ("Munizione".equals(riga.getTipoProdotto())) {
                        psMun.setInt(1, idOrdine);
                        psMun.setString(2, riga.getIdProdotto());
                        psMun.setDouble(3, riga.getPrezzo());
                        psMun.setInt(4, riga.getQuantita());
                        psMun.addBatch();
                        hasMun = true;
                    } else if ("Sessione".equals(riga.getTipoProdotto())) {
                        psSess.setInt(1, idOrdine);
                        psSess.setInt(2, Integer.parseInt(riga.getIdProdotto()));
                        psSess.setDouble(3, riga.getPrezzo());
                        psSess.setInt(4, riga.getQuantita());
                        psSess.addBatch();
                        hasSess = true;
                    }
                }
                
                if (hasArma) psArma.executeBatch();
                if (hasMun) psMun.executeBatch();
                if (hasSess) psSess.executeBatch();
            } else {
                throw new Exception("Nessun ID generato per l'ordine.");
            }
            
            conn.commit();
            
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (Exception re) {
                    re.printStackTrace();
                }
            }
            throw e;
        } finally {
            if (rs != null) try { rs.close(); } catch(Exception e) {}
            if (psArma != null) try { psArma.close(); } catch(Exception e) {}
            if (psMun != null) try { psMun.close(); } catch(Exception e) {}
            if (psSess != null) try { psSess.close(); } catch(Exception e) {}
            if (psOrdine != null) try { psOrdine.close(); } catch(Exception e) {}
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch(Exception e) {}
            }
        }
    }
    @Override
    public java.util.List<com.skeetpro.model.OrdineAdminDTO> findAllForAdmin() {
        return findOrdiniFiltrati(null, null, null);
    }

    @Override
    public java.util.List<com.skeetpro.model.OrdineAdminDTO> findOrdiniFiltrati(String dataDa, String dataA, String cliente) {
        java.util.List<com.skeetpro.model.OrdineAdminDTO> ordini = new java.util.ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT o.Codice, o.Data, o.Stato, o.ClienteCF, c.Nome, c.Cognome, " +
            "COALESCE(SUM(r.TotaleRiga), 0) as Totale " +
            "FROM Ordine o " +
            "JOIN Cliente c ON o.ClienteCF = c.CF " +
            "LEFT JOIN (" +
            "    SELECT OrdineCodice, Prezzo * Quantita * Durata as TotaleRiga FROM NoleggioArma " +
            "    UNION ALL " +
            "    SELECT OrdineCodice, Prezzo * Quantita as TotaleRiga FROM AcquistoMunizione " +
            "    UNION ALL " +
            "    SELECT OrdineCodice, Prezzo * Quantita as TotaleRiga FROM PagamentoSessione" +
            ") r ON o.Codice = r.OrdineCodice " +
            "WHERE 1=1 "
        );

        java.util.List<String> params = new java.util.ArrayList<>();
        if (dataDa != null && !dataDa.trim().isEmpty()) {
            sql.append("AND DATE(o.Data) >= ? ");
            params.add(dataDa.trim());
        }
        if (dataA != null && !dataA.trim().isEmpty()) {
            sql.append("AND DATE(o.Data) <= ? ");
            params.add(dataA.trim());
        }
        if (cliente != null && !cliente.trim().isEmpty()) {
            sql.append("AND (LOWER(o.ClienteCF) LIKE ? OR LOWER(c.Cognome) LIKE ? OR LOWER(c.Nome) LIKE ? " +
                       "OR LOWER(CONCAT(c.Nome, ' ', c.Cognome)) LIKE ? OR LOWER(CONCAT(c.Cognome, ' ', c.Nome)) LIKE ?) ");
            String term = "%" + cliente.trim().replaceAll("\\s+", " ").toLowerCase() + "%";
            params.add(term);
            params.add(term);
            params.add(term);
            params.add(term);
            params.add(term);
        }

        sql.append("GROUP BY o.Codice ORDER BY o.Data DESC");

        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    com.skeetpro.model.OrdineAdminDTO dto = new com.skeetpro.model.OrdineAdminDTO();
                    dto.setCodice(rs.getInt("Codice"));
                    dto.setData(rs.getTimestamp("Data"));
                    dto.setStato(rs.getString("Stato"));
                    dto.setClienteCF(rs.getString("ClienteCF"));
                    dto.setClienteNome(rs.getString("Nome"));
                    dto.setClienteCognome(rs.getString("Cognome"));
                    dto.setTotale(rs.getDouble("Totale"));
                    dto.setRighe(new java.util.ArrayList<>());
                    ordini.add(dto);
                }
            }

            String sqlArma = "SELECT * FROM NoleggioArma WHERE OrdineCodice = ?";
            String sqlMun = "SELECT * FROM AcquistoMunizione WHERE OrdineCodice = ?";
            String sqlSess = "SELECT * FROM PagamentoSessione WHERE OrdineCodice = ?";
            try (PreparedStatement psArma = conn.prepareStatement(sqlArma);
                 PreparedStatement psMun = conn.prepareStatement(sqlMun);
                 PreparedStatement psSess = conn.prepareStatement(sqlSess)) {
                for (com.skeetpro.model.OrdineAdminDTO dto : ordini) {
                    java.util.List<RigaOrdine> righe = new java.util.ArrayList<>();
                    psArma.setInt(1, dto.getCodice());
                    try (ResultSet rsArma = psArma.executeQuery()) {
                        while (rsArma.next()) {
                            RigaOrdine ro = new RigaOrdine();
                            ro.setIdProdotto(rsArma.getString("ArmaMatricola"));
                            ro.setTipoProdotto("Arma");
                            ro.setPrezzo(rsArma.getDouble("Prezzo"));
                            ro.setQuantita(rsArma.getInt("Quantita"));
                            ro.setDurata(rsArma.getInt("Durata"));
                            righe.add(ro);
                        }
                    }
                    psMun.setInt(1, dto.getCodice());
                    try (ResultSet rsMun = psMun.executeQuery()) {
                        while (rsMun.next()) {
                            RigaOrdine ro = new RigaOrdine();
                            ro.setIdProdotto(rsMun.getString("MunizioniLotto"));
                            ro.setTipoProdotto("Munizione");
                            ro.setPrezzo(rsMun.getDouble("Prezzo"));
                            ro.setQuantita(rsMun.getInt("Quantita"));
                            righe.add(ro);
                        }
                    }
                    psSess.setInt(1, dto.getCodice());
                    try (ResultSet rsSess = psSess.executeQuery()) {
                        while (rsSess.next()) {
                            RigaOrdine ro = new RigaOrdine();
                            ro.setIdProdotto(String.valueOf(rsSess.getInt("SessioneID")));
                            ro.setTipoProdotto("Sessione");
                            ro.setPrezzo(rsSess.getDouble("Prezzo"));
                            ro.setQuantita(rsSess.getInt("Quantita"));
                            righe.add(ro);
                        }
                    }
                    dto.setRighe(righe);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ordini;
    }

    @Override
    public void updateStato(int codice, String nuovoStato) {
        String sql = "UPDATE Ordine SET Stato = ? WHERE Codice = ?";
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nuovoStato);
            ps.setInt(2, codice);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public java.util.List<Ordine> getOrdiniByCliente(String cf) throws Exception {
        java.util.List<Ordine> ordini = new java.util.ArrayList<>();
        String sqlOrdine = "SELECT * FROM Ordine WHERE ClienteCF = ? ORDER BY Data DESC";
        String sqlArma = "SELECT * FROM NoleggioArma WHERE OrdineCodice = ?";
        String sqlMun = "SELECT * FROM AcquistoMunizione WHERE OrdineCodice = ?";
        String sqlSess = "SELECT * FROM PagamentoSessione WHERE OrdineCodice = ?";

        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement psOrdine = conn.prepareStatement(sqlOrdine);
             PreparedStatement psArma = conn.prepareStatement(sqlArma);
             PreparedStatement psMun = conn.prepareStatement(sqlMun);
             PreparedStatement psSess = conn.prepareStatement(sqlSess)) {

            psOrdine.setString(1, cf);
            try (ResultSet rsOrdine = psOrdine.executeQuery()) {
                while (rsOrdine.next()) {
                    Ordine ordine = new Ordine();
                    ordine.setCodice(rsOrdine.getInt("Codice"));
                    ordine.setData(rsOrdine.getTimestamp("Data"));
                    ordine.setStato(rsOrdine.getString("Stato"));
                    ordine.setClienteCF(rsOrdine.getString("ClienteCF"));

                    // Load Armi
                    psArma.setInt(1, ordine.getCodice());
                    try (ResultSet rsArma = psArma.executeQuery()) {
                        while (rsArma.next()) {
                            RigaOrdine ro = new RigaOrdine();
                            ro.setIdProdotto(rsArma.getString("ArmaMatricola"));
                            ro.setTipoProdotto("Arma");
                            ro.setPrezzo(rsArma.getDouble("Prezzo"));
                            ro.setQuantita(rsArma.getInt("Quantita"));
                            ro.setDurata(rsArma.getInt("Durata"));
                            ordine.addRiga(ro);
                        }
                    }

                    // Load Munizioni
                    psMun.setInt(1, ordine.getCodice());
                    try (ResultSet rsMun = psMun.executeQuery()) {
                        while (rsMun.next()) {
                            RigaOrdine ro = new RigaOrdine();
                            ro.setIdProdotto(rsMun.getString("MunizioniLotto"));
                            ro.setTipoProdotto("Munizione");
                            ro.setPrezzo(rsMun.getDouble("Prezzo"));
                            ro.setQuantita(rsMun.getInt("Quantita"));
                            ordine.addRiga(ro);
                        }
                    }

                    // Load Sessioni
                    psSess.setInt(1, ordine.getCodice());
                    try (ResultSet rsSess = psSess.executeQuery()) {
                        while (rsSess.next()) {
                            RigaOrdine ro = new RigaOrdine();
                            ro.setIdProdotto(String.valueOf(rsSess.getInt("SessioneID")));
                            ro.setTipoProdotto("Sessione");
                            ro.setPrezzo(rsSess.getDouble("Prezzo"));
                            ro.setQuantita(rsSess.getInt("Quantita"));
                            ordine.addRiga(ro);
                        }
                    }

                    ordini.add(ordine);
                }
            }
        }
        return ordini;
    }
}
