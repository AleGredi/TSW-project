package com.skeetpro.model;

public class Munizione {
    private String lotto;
    private String calibro;
    private String marca;
    private String descrizione;
    private double prezzo;
    private boolean attiva;

    public Munizione() {}

    public Munizione(String lotto, String calibro, String marca, String descrizione, double prezzo, boolean attiva) {
        this.lotto = lotto;
        this.calibro = calibro;
        this.marca = marca;
        this.descrizione = descrizione;
        this.prezzo = prezzo;
        this.attiva = attiva;
    }

    public String getLotto() { return lotto; }
    public void setLotto(String lotto) { this.lotto = lotto; }
    public String getCalibro() { return calibro; }
    public void setCalibro(String calibro) { this.calibro = calibro; }
    public String getMarca() { return marca; }
    public void setMarca(String marca) { this.marca = marca; }
    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }
    public double getPrezzo() { return prezzo; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }
    public boolean isAttiva() { return attiva; }
    public void setAttiva(boolean attiva) { this.attiva = attiva; }
}
