package com.skeetpro.dao;

import com.skeetpro.model.Cliente;

public interface ClienteDAO {
    
    // Metodo per il login: cerca un cliente nel DB tramite email e password.
    // Ritorna l'oggetto Cliente se trovato, altrimenti ritorna null.
    Cliente doLogin(String email, String password);
    
}
