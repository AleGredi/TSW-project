package com.skeetpro.dao;

import com.skeetpro.model.Cliente;

public interface ClienteDAO {
    
    Cliente doLogin(String email, String password);
    
    boolean save(Cliente cliente);
    
    java.time.LocalDate getPortoArmiScadenza(String cf);
}
