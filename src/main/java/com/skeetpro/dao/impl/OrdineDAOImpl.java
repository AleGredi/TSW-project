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
        String sqlRiga = "INSERT INTO RigaOrdine (OrdineCodice, IDProdotto, TipoProdotto, Prezzo, Quantita, Durata) VALUES (?, ?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement psOrdine = null;
        PreparedStatement psRiga = null;
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
                
                psRiga = conn.prepareStatement(sqlRiga);
                for (RigaOrdine riga : ordine.getRighe()) {
                    psRiga.setInt(1, idOrdine);
                    psRiga.setString(2, riga.getIdProdotto());
                    psRiga.setString(3, riga.getTipoProdotto());
                    psRiga.setDouble(4, riga.getPrezzo());
                    psRiga.setInt(5, riga.getQuantita());
                    psRiga.setInt(6, riga.getDurata());
                    psRiga.addBatch();
                }
                
                psRiga.executeBatch();
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
            if (psRiga != null) try { psRiga.close(); } catch(Exception e) {}
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
        java.util.List<com.skeetpro.model.OrdineAdminDTO> ordini = new java.util.ArrayList<>();
        String sql = "SELECT o.Codice, o.Data, o.Stato, o.ClienteCF, c.Nome, c.Cognome, " +
                     "SUM(r.Prezzo * r.Quantita * COALESCE(r.Durata, 1)) as Totale " +
                     "FROM Ordine o " +
                     "JOIN Cliente c ON o.ClienteCF = c.CF " +
                     "LEFT JOIN RigaOrdine r ON o.Codice = r.OrdineCodice " +
                     "GROUP BY o.Codice " +
                     "ORDER BY o.Data DESC";
                     
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                com.skeetpro.model.OrdineAdminDTO dto = new com.skeetpro.model.OrdineAdminDTO();
                dto.setCodice(rs.getInt("Codice"));
                dto.setData(rs.getTimestamp("Data"));
                dto.setStato(rs.getString("Stato"));
                dto.setClienteCF(rs.getString("ClienteCF"));
                dto.setClienteNome(rs.getString("Nome"));
                dto.setClienteCognome(rs.getString("Cognome"));
                dto.setTotale(rs.getDouble("Totale"));
                
                ordini.add(dto);
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
        String sqlRiga = "SELECT * FROM RigaOrdine WHERE OrdineCodice = ?";

        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement psOrdine = conn.prepareStatement(sqlOrdine);
             PreparedStatement psRiga = conn.prepareStatement(sqlRiga)) {

            psOrdine.setString(1, cf);
            try (ResultSet rsOrdine = psOrdine.executeQuery()) {
                while (rsOrdine.next()) {
                    Ordine ordine = new Ordine();
                    ordine.setCodice(rsOrdine.getInt("Codice"));
                    ordine.setData(rsOrdine.getTimestamp("Data"));
                    ordine.setStato(rsOrdine.getString("Stato"));
                    ordine.setClienteCF(rsOrdine.getString("ClienteCF"));

                    psRiga.setInt(1, ordine.getCodice());
                    try (ResultSet rsRiga = psRiga.executeQuery()) {
                        while (rsRiga.next()) {
                            RigaOrdine ro = new RigaOrdine();
                            ro.setIdProdotto(rsRiga.getString("IDProdotto"));
                            ro.setTipoProdotto(rsRiga.getString("TipoProdotto"));
                            ro.setPrezzo(rsRiga.getDouble("Prezzo"));
                            ro.setQuantita(rsRiga.getInt("Quantita"));
                            ro.setDurata(rsRiga.getInt("Durata"));
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
