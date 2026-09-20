package com.skeetpro.model;

import java.io.Serializable;

public class RigaCarrello implements Serializable {
    private static final long serialVersionUID = 1L;
    private String idProdotto; 
    private String tipo;       
    private String nome;
    private double prezzoUnitario;
    private int quantita;      
    private int durata;

    public RigaCarrello() {}

    public RigaCarrello(String idProdotto, String tipo, String nome, double prezzoUnitario, int quantita, int durata) {
        this.idProdotto = idProdotto;
        this.tipo = tipo;
        this.nome = nome;
        this.prezzoUnitario = prezzoUnitario;
        this.quantita = quantita;
        this.durata = durata;
    }

    public String getIdProdotto() { return idProdotto; }
    public void setIdProdotto(String idProdotto) { this.idProdotto = idProdotto; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public double getPrezzoUnitario() { return prezzoUnitario; }
    public void setPrezzoUnitario(double prezzoUnitario) { this.prezzoUnitario = prezzoUnitario; }

    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }

    public int getDurata() { return durata; }
    public void setDurata(int durata) { this.durata = durata; }
    public double getTotaleRiga() {
        if ("Arma".equalsIgnoreCase(tipo) || "Sessione".equalsIgnoreCase(tipo)) {
            return prezzoUnitario * durata * quantita; 
        } else {
            return prezzoUnitario * quantita;
        }
    }
}
