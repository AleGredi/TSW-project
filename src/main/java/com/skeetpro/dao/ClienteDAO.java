package com.skeetpro.dao;

import com.skeetpro.model.Cliente;

public interface ClienteDAO {
    
    Cliente doLogin(String email, String password);
    
    boolean save(Cliente cliente);
    
    java.time.LocalDate getPortoArmiScadenza(String cf);
    
    java.util.List<com.skeetpro.model.ClienteAdminDTO> findAllForAdmin();
    void updateStatoSocio(String cf, String nuovoStato);
    void updatePortoArmi(String cf, String numLicenza, java.sql.Date scadenza);
}
