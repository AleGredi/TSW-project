package com.skeetpro.model;

public class Temporaneo extends Cliente {
    private static final long serialVersionUID = 1L;

    public Temporaneo() {
        super();
    }

    public Temporaneo(String cf, String nome, String cognome, String email, String password, String tipoCliente) {
        super(cf, nome, cognome, email, password, tipoCliente);
    }
}
