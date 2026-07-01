package com.skeetpro.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Ordine {
    private int codice;
    private Timestamp data;
    private String stato;
    private String clienteCF;
    private List<RigaOrdine> righe;

    public Ordine() {
        this.righe = new ArrayList<>();
    }

    public int getCodice() { return codice; }
    public void setCodice(int codice) { this.codice = codice; }

    public Timestamp getData() { return data; }
    public void setData(Timestamp data) { this.data = data; }

    public String getStato() { return stato; }
    public void setStato(String stato) { this.stato = stato; }

    public String getClienteCF() { return clienteCF; }
    public void setClienteCF(String clienteCF) { this.clienteCF = clienteCF; }

    public List<RigaOrdine> getRighe() { return righe; }
    public void setRighe(List<RigaOrdine> righe) { this.righe = righe; }
    
    public void addRiga(RigaOrdine riga) {
        this.righe.add(riga);
    }
}
