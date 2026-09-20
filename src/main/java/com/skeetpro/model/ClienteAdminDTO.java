package com.skeetpro.model;

import java.io.Serializable;
import java.time.LocalDate;

public class ClienteAdminDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private String cf;
    private String nome;
    private String cognome;
    private String email;
    private String tipoCliente;
    
    private String statoSocio;
    private String nTessera;
    
    private String numLicenza;
    private LocalDate scadenzaPortoArmi;

    public String getCf() { return cf; }
    public void setCf(String cf) { this.cf = cf; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getCognome() { return cognome; }
    public void setCognome(String cognome) { this.cognome = cognome; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getTipoCliente() { return tipoCliente; }
    public void setTipoCliente(String tipoCliente) { this.tipoCliente = tipoCliente; }

    public String getStatoSocio() { return statoSocio; }
    public void setStatoSocio(String statoSocio) { this.statoSocio = statoSocio; }

    public String getnTessera() { return nTessera; }
    public void setnTessera(String nTessera) { this.nTessera = nTessera; }

    public String getNumLicenza() { return numLicenza; }
    public void setNumLicenza(String numLicenza) { this.numLicenza = numLicenza; }

    public LocalDate getScadenzaPortoArmi() { return scadenzaPortoArmi; }
    public void setScadenzaPortoArmi(LocalDate scadenzaPortoArmi) { this.scadenzaPortoArmi = scadenzaPortoArmi; }
    
    public String getScadenzaPortoArmiFormatted() {
        if (scadenzaPortoArmi == null) return "";
        return scadenzaPortoArmi.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
    
    public boolean isPortoArmiInScadenza() {
        if (scadenzaPortoArmi == null) return false;
        LocalDate oggi = LocalDate.now();
        LocalDate limite = oggi.plusDays(30);
        return scadenzaPortoArmi.isBefore(limite) && !scadenzaPortoArmi.isBefore(oggi);
    }
    
    public boolean isPortoArmiScaduto() {
        if (scadenzaPortoArmi == null) return false;
        return scadenzaPortoArmi.isBefore(LocalDate.now());
    }
}
