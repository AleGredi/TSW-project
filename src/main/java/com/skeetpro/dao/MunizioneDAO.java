package com.skeetpro.dao;

import java.util.List;
import com.skeetpro.model.Munizione;

public interface MunizioneDAO {
    List<Munizione> findAllAttive();
}
