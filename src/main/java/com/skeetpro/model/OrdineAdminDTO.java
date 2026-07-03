package com.skeetpro.model;

import java.sql.Timestamp;
import java.util.List;

public class OrdineAdminDTO {
    private int codice;
    private Timestamp data;
    private String stato;
    
    private String clienteCF;
    private String clienteNome;
    private String clienteCognome;
    
    private double totale;
    
    private List<RigaOrdine> righe;

    public int getCodice() { return codice; }
    public void setCodice(int codice) { this.codice = codice; }

    public Timestamp getData() { return data; }
    public void setData(Timestamp data) { this.data = data; }

    public String getStato() { return stato; }
    public void setStato(String stato) { this.stato = stato; }

    public String getClienteCF() { return clienteCF; }
    public void setClienteCF(String clienteCF) { this.clienteCF = clienteCF; }

    public String getClienteNome() { return clienteNome; }
    public void setClienteNome(String clienteNome) { this.clienteNome = clienteNome; }

    public String getClienteCognome() { return clienteCognome; }
    public void setClienteCognome(String clienteCognome) { this.clienteCognome = clienteCognome; }

    public double getTotale() { return totale; }
    public void setTotale(double totale) { this.totale = totale; }

    public List<RigaOrdine> getRighe() { return righe; }
    public void setRighe(List<RigaOrdine> righe) { this.righe = righe; }
}
