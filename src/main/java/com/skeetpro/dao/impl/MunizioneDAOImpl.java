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
    public List<Munizione> findAllAttive() {
        List<Munizione> munizioni = new ArrayList<>();
        String query = "SELECT * FROM Munizioni WHERE Attiva = true";
        
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
}
