package com.skeetpro.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

import com.skeetpro.dao.ClienteDAO;
import com.skeetpro.model.Cliente;
import com.skeetpro.model.Socio;
import com.skeetpro.model.Temporaneo;
import com.skeetpro.util.DataSourceProvider;

public class ClienteDAOImpl implements ClienteDAO {

    @Override
    public Cliente doLogin(String email, String password) {
        Cliente cliente = null;
        
        String query = "SELECT c.*, s.N_Tessera, s.DataIscr FROM Cliente c LEFT JOIN Socio s ON c.CF = s.CF WHERE c.Email = ? AND c.Password = ?";
        
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setString(1, email);
            ps.setString(2, password);
            
            // Eseguiamo la query
            try (ResultSet rs = ps.executeQuery()) {
                
                if (rs.next()) {
                    String tipoCliente = rs.getString("TipoCliente");
                    
                    if ("Socio".equalsIgnoreCase(tipoCliente)) {
                        Socio socio = new Socio();
                        socio.setCf(rs.getString("CF"));
                        socio.setNome(rs.getString("Nome"));
                        socio.setCognome(rs.getString("Cognome"));
                        socio.setEmail(rs.getString("Email"));
                        socio.setPassword(rs.getString("Password"));
                        socio.setTipoCliente(tipoCliente);
                        
                        // Campi specifici
                        socio.setNumeroTessera(rs.getString("N_Tessera"));
                        Date dataIscr = rs.getDate("DataIscr");
                        if (dataIscr != null) {
                            socio.setDataIscrizione(dataIscr.toLocalDate());
                        }
                        
                        cliente = socio;
                    } else {
                        Temporaneo temp = new Temporaneo();
                        temp.setCf(rs.getString("CF"));
                        temp.setNome(rs.getString("Nome"));
                        temp.setCognome(rs.getString("Cognome"));
                        temp.setEmail(rs.getString("Email"));
                        temp.setPassword(rs.getString("Password"));
                        temp.setTipoCliente(tipoCliente);
                        
                        cliente = temp;
                    }
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore SQL/DB: " + e.getMessage(), e);
        }
        
        // Ritorna l'oggetto se le credenziali erano giuste, oppure null se la query non ha trovato nulla
        return cliente;
    }

    @Override
    public boolean save(Cliente cliente) {
        String queryCliente = "INSERT INTO Cliente (CF, Nome, Cognome, Email, Password, TipoCliente) VALUES (?, ?, ?, ?, ?, ?)";
        String querySocio = "INSERT INTO Socio (CF, DataIscr, N_Tessera, Stato) VALUES (?, ?, ?, 'Attivo')";
        
        Connection conn = null;
        try {
            conn = DataSourceProvider.getConnection();
            // Disabilito l'autocommit per gestire la transazione (Cliente + eventuale Socio)
            conn.setAutoCommit(false);
            
            // 1. Inserimento nella tabella padre Cliente
            try (PreparedStatement psCliente = conn.prepareStatement(queryCliente)) {
                psCliente.setString(1, cliente.getCf());
                psCliente.setString(2, cliente.getNome());
                psCliente.setString(3, cliente.getCognome());
                psCliente.setString(4, cliente.getEmail());
                psCliente.setString(5, cliente.getPassword());
                psCliente.setString(6, cliente.getTipoCliente());
                psCliente.executeUpdate();
            }
            
            // 2. Se è un Socio, inserisco anche nella tabella figlia Socio
            if (cliente instanceof Socio) {
                Socio socio = (Socio) cliente;
                try (PreparedStatement psSocio = conn.prepareStatement(querySocio)) {
                    psSocio.setString(1, socio.getCf());
                    psSocio.setDate(2, Date.valueOf(socio.getDataIscrizione()));
                    psSocio.setString(3, socio.getNumeroTessera());
                    psSocio.executeUpdate();
                }
            }
            
            // Confermo la transazione
            conn.commit();
            return true;
            
        } catch (SQLException e) {
            // In caso di errore, annullo tutto
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            // Ripristino l'autocommit e chiudo la connessione
            if (conn != null) {
                try { 
                    conn.setAutoCommit(true); 
                    conn.close(); 
                } catch (SQLException ex) { 
                    ex.printStackTrace(); 
                }
            }
        }
    }
}
