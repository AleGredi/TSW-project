package com.skeetpro.model;

import java.sql.Date;
import java.sql.Time;

public class Prenotazione {
    private int codice;
    private Date data;
    private Time fasciaOraria;
    private int campoId;
    private String clienteCf;

    public Prenotazione() {}

    public int getCodice() { return codice; }
    public void setCodice(int codice) { this.codice = codice; }
    
    public Date getData() { return data; }
    public void setData(Date data) { this.data = data; }
    
    public Time getFasciaOraria() { return fasciaOraria; }
    public void setFasciaOraria(Time fasciaOraria) { this.fasciaOraria = fasciaOraria; }
    
    public int getCampoId() { return campoId; }
    public void setCampoId(int campoId) { this.campoId = campoId; }
    
    public String getClienteCf() { return clienteCf; }
    public void setClienteCf(String clienteCf) { this.clienteCf = clienteCf; }
}
