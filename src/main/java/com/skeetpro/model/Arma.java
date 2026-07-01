package com.skeetpro.model;

public class Arma {
    private String matricola;
    private String modello;
    private String calibro;
    private String descrizione;
    private double prezzoNoleggio;
    private boolean attiva;

    public Arma() {}

    public Arma(String matricola, String modello, String calibro, String descrizione, double prezzoNoleggio, boolean attiva) {
        this.matricola = matricola;
        this.modello = modello;
        this.calibro = calibro;
        this.descrizione = descrizione;
        this.prezzoNoleggio = prezzoNoleggio;
        this.attiva = attiva;
    }

    public String getMatricola() { return matricola; }
    public void setMatricola(String matricola) { this.matricola = matricola; }
    public String getModello() { return modello; }
    public void setModello(String modello) { this.modello = modello; }
    public String getCalibro() { return calibro; }
    public void setCalibro(String calibro) { this.calibro = calibro; }
    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }
    public double getPrezzoNoleggio() { return prezzoNoleggio; }
    public void setPrezzoNoleggio(double prezzoNoleggio) { this.prezzoNoleggio = prezzoNoleggio; }
    public boolean isAttiva() { return attiva; }
    public void setAttiva(boolean attiva) { this.attiva = attiva; }
}
