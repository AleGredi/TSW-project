package com.skeetpro.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.skeetpro.dao.ArmaDAO;
import com.skeetpro.model.Arma;
import com.skeetpro.util.DataSourceProvider;

public class ArmaDAOImpl implements ArmaDAO {

    @Override
    public List<Arma> findAllAttive(String search) {
        List<Arma> armi = new ArrayList<>();
        String query = "SELECT * FROM Arma WHERE Attiva = true";
        boolean hasSearch = (search != null && !search.trim().isEmpty());
        
        if (hasSearch) {
            query += " AND (LOWER(Modello) LIKE ? OR LOWER(Calibro) LIKE ?)";
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
                Arma arma = new Arma();
                arma.setMatricola(rs.getString("Matricola"));
                arma.setModello(rs.getString("Modello"));
                arma.setCalibro(rs.getString("Calibro"));
                arma.setDescrizione(rs.getString("Descrizione"));
                arma.setPrezzoNoleggio(rs.getDouble("PrezzoNoleggio"));
                arma.setAttiva(rs.getBoolean("Attiva"));
                armi.add(arma);
            }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return armi;
    }
    @Override
    public List<Arma> findAll() {
        List<Arma> armi = new ArrayList<>();
        String query = "SELECT * FROM Arma";
        
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Arma arma = new Arma();
                arma.setMatricola(rs.getString("Matricola"));
                arma.setModello(rs.getString("Modello"));
                arma.setCalibro(rs.getString("Calibro"));
                arma.setDescrizione(rs.getString("Descrizione"));
                arma.setPrezzoNoleggio(rs.getDouble("PrezzoNoleggio"));
                arma.setAttiva(rs.getBoolean("Attiva"));
                armi.add(arma);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return armi;
    }

    @Override
    public void save(Arma arma) {
        String sql = "INSERT INTO Arma (Matricola, Modello, Calibro, Descrizione, PrezzoNoleggio, Attiva) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, arma.getMatricola());
            ps.setString(2, arma.getModello());
            ps.setString(3, arma.getCalibro());
            ps.setString(4, arma.getDescrizione());
            ps.setDouble(5, arma.getPrezzoNoleggio());
            ps.setBoolean(6, arma.isAttiva());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore in save Arma", e);
        }
    }

    @Override
    public void update(Arma arma) {
        String sql = "UPDATE Arma SET Modello=?, Calibro=?, Descrizione=?, PrezzoNoleggio=?, Attiva=? WHERE Matricola=?";
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, arma.getModello());
            ps.setString(2, arma.getCalibro());
            ps.setString(3, arma.getDescrizione());
            ps.setDouble(4, arma.getPrezzoNoleggio());
            ps.setBoolean(5, arma.isAttiva());
            ps.setString(6, arma.getMatricola());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore in update Arma", e);
        }
    }

    @Override
    public void softDelete(String matricola) {
        setStatoAttiva(matricola, false);
    }
    
    @Override
    public void riattiva(String matricola) {
        setStatoAttiva(matricola, true);
    }
    
    private void setStatoAttiva(String matricola, boolean attiva) {
        String sql = "UPDATE Arma SET Attiva=? WHERE Matricola=?";
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, attiva);
            ps.setString(2, matricola);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore cambio stato Arma", e);
        }
    }

    @Override
    public byte[] getFoto(String matricola) {
        String sql = "SELECT Foto FROM Arma WHERE Matricola = ?";
        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, matricola);
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
