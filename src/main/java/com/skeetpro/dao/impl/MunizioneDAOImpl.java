package com.skeetpro.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.skeetpro.dao.MunizioneDAO;
import com.skeetpro.model.Munizione;
import com.skeetpro.util.DataSourceProvider;

public class MunizioneDAOImpl implements MunizioneDAO {

    @Override
    public List<Munizione> findAllAttive(String search) {
        List<Munizione> munizioni = new ArrayList<>();
        String query = "SELECT * FROM Munizioni WHERE Attiva = true";
        boolean hasSearch = (search != null && !search.trim().isEmpty());
        
        if (hasSearch) {
            query += " AND (LOWER(Marca) LIKE ? OR LOWER(Calibro) LIKE ?)";
        }
        
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            if (hasSearch) {
                String term = "%" + search.trim().toLowerCase() + "%";
                ps.setString(1, term);
                ps.setString(2, term);
            }
            
            try (ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Munizione m = new Munizione();
                m.setLotto(rs.getString("Lotto"));
                m.setCalibro(rs.getString("Calibro"));
                m.setMarca(rs.getString("Marca"));
                m.setDescrizione(rs.getString("Descrizione"));
                m.setPrezzo(rs.getDouble("Prezzo"));
                m.setAttiva(rs.getBoolean("Attiva"));
                munizioni.add(m);
            }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return munizioni;
    }
    @Override
    public List<Munizione> findAll() {
        List<Munizione> munizioni = new ArrayList<>();
        String query = "SELECT * FROM Munizioni";
        
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Munizione m = new Munizione();
                m.setLotto(rs.getString("Lotto"));
                m.setCalibro(rs.getString("Calibro"));
                m.setMarca(rs.getString("Marca"));
                m.setDescrizione(rs.getString("Descrizione"));
                m.setPrezzo(rs.getDouble("Prezzo"));
                m.setAttiva(rs.getBoolean("Attiva"));
                munizioni.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return munizioni;
    }

    @Override
    public void save(Munizione m) {
        String sql = "INSERT INTO Munizioni (Lotto, Calibro, Marca, Descrizione, Prezzo, Attiva) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getLotto());
            ps.setString(2, m.getCalibro());
            ps.setString(3, m.getMarca());
            ps.setString(4, m.getDescrizione());
            ps.setDouble(5, m.getPrezzo());
            ps.setBoolean(6, m.isAttiva());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore in save Munizione", e);
        }
    }

    @Override
    public void update(Munizione m) {
        String sql = "UPDATE Munizioni SET Calibro=?, Marca=?, Descrizione=?, Prezzo=?, Attiva=? WHERE Lotto=?";
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getCalibro());
            ps.setString(2, m.getMarca());
            ps.setString(3, m.getDescrizione());
            ps.setDouble(4, m.getPrezzo());
            ps.setBoolean(5, m.isAttiva());
            ps.setString(6, m.getLotto());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore in update Munizione", e);
        }
    }

    @Override
    public void softDelete(String lotto) {
        setStatoAttiva(lotto, false);
    }
    
    @Override
    public void riattiva(String lotto) {
        setStatoAttiva(lotto, true);
    }
    
    private void setStatoAttiva(String lotto, boolean attiva) {
        String sql = "UPDATE Munizioni SET Attiva=? WHERE Lotto=?";
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, attiva);
            ps.setString(2, lotto);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore cambio stato Munizione", e);
        }
    }

    @Override
    public byte[] getFoto(String lotto) {
        String sql = "SELECT Foto FROM Munizioni WHERE Lotto = ?";
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, lotto);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getBytes("Foto");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
