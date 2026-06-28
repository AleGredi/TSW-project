package com.skeetpro.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.skeetpro.dao.ClienteDAO;
import com.skeetpro.model.Cliente;
import com.skeetpro.util.DBConnection;

public class ClienteDAOImpl implements ClienteDAO {

    @Override
    public Cliente doLogin(String email, String password) {
        Cliente cliente = null;
        
        // Uso rigorosamente il PreparedStatement con i placeholder '?' per evitare la SQL Injection
        String query = "SELECT * FROM Cliente WHERE Email = ? AND Password = ?";
        
        // Apre la connessione e prepara lo statement
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            // Sostituiamo i parametri '?' 
            ps.setString(1, email);
            ps.setString(2, password);
            
            // Eseguiamo la query
            try (ResultSet rs = ps.executeQuery()) {
                
                if (rs.next()) {
                    // Creiamo il JavaBean Cliente e lo "riempiamo" con i dati appena letti dalla tabella.
                    cliente = new Cliente();
                    cliente.setCf(rs.getString("CF"));
                    cliente.setNome(rs.getString("Nome"));
                    cliente.setCognome(rs.getString("Cognome"));
                    cliente.setEmail(rs.getString("Email"));
                    cliente.setPassword(rs.getString("Password"));
                    cliente.setTipoCliente(rs.getString("TipoCliente"));
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Ritorna l'oggetto se le credenziali erano giuste, oppure null se la query non ha trovato nulla
        return cliente;
    }
}
