package com.skeetpro.model;

public class RigaOrdine {
    private int ordineCodice;
    private String idProdotto;
    private String tipoProdotto;
    private double prezzo;
    private int quantita;
    private int durata;

    public RigaOrdine() {}

    public int getOrdineCodice() { return ordineCodice; }
    public void setOrdineCodice(int ordineCodice) { this.ordineCodice = ordineCodice; }

    public String getIdProdotto() { return idProdotto; }
    public void setIdProdotto(String idProdotto) { this.idProdotto = idProdotto; }

    public String getTipoProdotto() { return tipoProdotto; }
    public void setTipoProdotto(String tipoProdotto) { this.tipoProdotto = tipoProdotto; }

    public double getPrezzo() { return prezzo; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }

    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }

    public int getDurata() { return durata; }
    public void setDurata(int durata) { this.durata = durata; }
}
