package com.skeetpro.dao;

import java.util.List;
import com.skeetpro.model.Arma;

public interface ArmaDAO {
    List<Arma> findAllAttive();
    List<Arma> findAll();
    void save(Arma arma);
    void update(Arma arma);
    void softDelete(String matricola);
    void riattiva(String matricola);
}
