package com.skeetpro.dao;

import java.util.List;
import com.skeetpro.model.Munizione;

public interface MunizioneDAO {
    List<Munizione> findAllAttive(String search);
    List<Munizione> findAll();
    void save(Munizione munizione);
    void update(Munizione munizione);
    void softDelete(String lotto);
    void riattiva(String lotto);
}
