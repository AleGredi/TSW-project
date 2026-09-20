package com.skeetpro.dao;

import com.skeetpro.model.Ordine;

public interface OrdineDAO {
    void salvaOrdine(Ordine ordine) throws Exception;
    java.util.List<com.skeetpro.model.OrdineAdminDTO> findAllForAdmin();
    java.util.List<com.skeetpro.model.OrdineAdminDTO> findOrdiniFiltrati(String dataDa, String dataA, String cliente);
    void updateStato(int codice, String nuovoStato);
    java.util.List<Ordine> getOrdiniByCliente(String cf) throws Exception;
}
