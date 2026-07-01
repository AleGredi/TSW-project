package com.skeetpro.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.skeetpro.dao.CampoDAO;
import com.skeetpro.model.Campo;
import com.skeetpro.util.DataSourceProvider;

public class CampoDAOImpl implements CampoDAO {

    @Override
    public List<Campo> findAll() {
        List<Campo> campi = new ArrayList<>();
        String sql = "SELECT * FROM Campo";
        
        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                Campo c = new Campo();
                c.setId(rs.getInt("ID"));
                c.setDisciplina(rs.getString("Disciplina"));
                campi.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campi;
    }

    @Override
    public Campo findById(int id) {
        String sql = "SELECT * FROM Campo WHERE ID = ?";
        Campo c = null;
        
        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    c = new Campo();
                    c.setId(rs.getInt("ID"));
                    c.setDisciplina(rs.getString("Disciplina"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }
}
