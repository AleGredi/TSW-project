package com.skeetpro.dao;

import java.util.List;
import com.skeetpro.model.Campo;

public interface CampoDAO {
    List<Campo> findAll();
    Campo findById(int id);
}
