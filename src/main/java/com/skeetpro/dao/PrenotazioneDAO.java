package com.skeetpro.dao;

import java.sql.Date;
import java.sql.Time;
import java.util.List;
import com.skeetpro.model.Prenotazione;

public interface PrenotazioneDAO {
    void save(Prenotazione p);
    boolean isSlotAvailable(int campoId, Date data, Time fasciaOraria);
    List<Prenotazione> findByCliente(String clienteCf);
}
