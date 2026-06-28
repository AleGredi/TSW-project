package com.skeetpro.model;

import java.time.LocalDate;

public class Socio extends Cliente {

    private String numeroTessera;
    private LocalDate dataIscrizione;

    public Socio() {
        super();
    }

    public Socio(String cf, String nome, String cognome, String email, String password, String tipoCliente, String numeroTessera, LocalDate dataIscrizione) {
        super(cf, nome, cognome, email, password, tipoCliente);
        this.numeroTessera = numeroTessera;
        this.dataIscrizione = dataIscrizione;
    }

    public String getNumeroTessera() {
        return numeroTessera;
    }

    public void setNumeroTessera(String numeroTessera) {
        this.numeroTessera = numeroTessera;
    }

    public LocalDate getDataIscrizione() {
        return dataIscrizione;
    }

    public void setDataIscrizione(LocalDate dataIscrizione) {
        this.dataIscrizione = dataIscrizione;
    }
}
