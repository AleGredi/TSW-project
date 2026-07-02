package com.skeetpro.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.skeetpro.dao.AdminDAO;
import com.skeetpro.model.Admin;
import com.skeetpro.util.DataSourceProvider;

public class AdminDAOImpl implements AdminDAO {

    @Override
    public Admin login(String username, String password) {
        Admin admin = null;
        String query = "SELECT * FROM Admin WHERE Username = ? AND Password = ?";
        
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setString(1, username);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    admin = new Admin();
                    admin.setUsername(rs.getString("Username"));
                    admin.setPassword(rs.getString("Password"));
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore DB login Admin: " + e.getMessage(), e);
        }
        
        return admin;
    }
}
