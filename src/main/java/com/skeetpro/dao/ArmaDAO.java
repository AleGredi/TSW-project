package com.skeetpro.dao;

import java.util.List;
import com.skeetpro.model.Arma;

public interface ArmaDAO {
    List<Arma> findAllAttive();
}
