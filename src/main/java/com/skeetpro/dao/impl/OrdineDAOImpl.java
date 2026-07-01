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
}
