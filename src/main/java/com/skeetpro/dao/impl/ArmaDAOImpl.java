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
    public List<Arma> findAllAttive() {
        List<Arma> armi = new ArrayList<>();
        String query = "SELECT * FROM Arma WHERE Attiva = true";
        
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
}
