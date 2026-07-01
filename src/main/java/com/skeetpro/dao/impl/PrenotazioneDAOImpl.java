package com.skeetpro.dao.impl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import com.skeetpro.dao.PrenotazioneDAO;
import com.skeetpro.model.Prenotazione;
import com.skeetpro.util.DataSourceProvider;

public class PrenotazioneDAOImpl implements PrenotazioneDAO {

    @Override
    public void save(Prenotazione p) {
        String sql = "INSERT INTO Prenotazione (Data, FasciaOraria, CampoID, ClienteCF) VALUES (?, ?, ?, ?)";
        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
             
            ps.setDate(1, p.getData());
            ps.setTime(2, p.getFasciaOraria());
            ps.setInt(3, p.getCampoId());
            ps.setString(4, p.getClienteCf());
            
            ps.executeUpdate();
            
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    p.setCodice(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore nel salvataggio della prenotazione", e);
        }
    }

    @Override
    public boolean isSlotAvailable(int campoId, Date data, Time fasciaOraria) {
        String sql = "SELECT COUNT(*) FROM Prenotazione WHERE CampoID = ? AND Data = ? AND FasciaOraria = ?";
        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setInt(1, campoId);
            ps.setDate(2, data);
            ps.setTime(3, fasciaOraria);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Prenotazione> findByCliente(String clienteCf) {
        List<Prenotazione> list = new ArrayList<>();
        String sql = "SELECT * FROM Prenotazione WHERE ClienteCF = ? ORDER BY Data DESC, FasciaOraria DESC";
        
        try (Connection con = DataSourceProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setString(1, clienteCf);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prenotazione p = new Prenotazione();
                    p.setCodice(rs.getInt("Codice"));
                    p.setData(rs.getDate("Data"));
                    p.setFasciaOraria(rs.getTime("FasciaOraria"));
                    p.setCampoId(rs.getInt("CampoID"));
                    p.setClienteCf(rs.getString("ClienteCF"));
                    list.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
