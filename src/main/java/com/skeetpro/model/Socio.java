package com.skeetpro.model;

import java.time.LocalDate;

public class Socio extends Cliente {
    private static final long serialVersionUID = 1L;

    private String numeroTessera;
    private LocalDate dataIscrizione;
    private String stato;

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
    public String getStato() {
        return stato;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }
}
