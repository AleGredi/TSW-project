package com.skeetpro.model;

import java.util.ArrayList;
import java.util.List;

public class Carrello {
    
    private List<RigaCarrello> righe;

    public Carrello() {
        this.righe = new ArrayList<>();
    }

    public List<RigaCarrello> getRighe() {
        return righe;
    }

    public void addRiga(RigaCarrello nuovaRiga) {

        for (RigaCarrello r : righe) {
            if (r.getIdProdotto().equals(nuovaRiga.getIdProdotto()) && r.getTipo().equals(nuovaRiga.getTipo())) {
                r.setQuantita(r.getQuantita() + nuovaRiga.getQuantita());
                if(nuovaRiga.getDurata() > 0) {
                    r.setDurata(r.getDurata() + nuovaRiga.getDurata());
                }
                return;
            }
        }

        righe.add(nuovaRiga);
    }

    public void removeRiga(String idProdotto, String tipo) {
        righe.removeIf(r -> r.getIdProdotto().equals(idProdotto) && r.getTipo().equals(tipo));
    }

    public void setQuantita(String idProdotto, String tipo, int quantita) {
        for (RigaCarrello r : righe) {
            if (r.getIdProdotto().equals(idProdotto) && r.getTipo().equals(tipo)) {
                r.setQuantita(quantita);
                break;
            }
        }
    }

    public void svuota() {
        righe.clear();
    }

    public double getTotale() {
        double totale = 0;
        for (RigaCarrello r : righe) {
            totale += r.getTotaleRiga();
        }
        return totale;
    }
    
    public int getNumeroArticoli() {
        int tot = 0;
        for (RigaCarrello r : righe) {
            tot += r.getQuantita();
        }
        return tot;
    }
}
