package com.skeetpro.control;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.skeetpro.dao.ClienteDAO;
import com.skeetpro.dao.OrdineDAO;
import com.skeetpro.dao.impl.ClienteDAOImpl;
import com.skeetpro.dao.impl.OrdineDAOImpl;
import com.skeetpro.model.Carrello;
import com.skeetpro.model.Cliente;
import com.skeetpro.model.Ordine;
import com.skeetpro.model.RigaCarrello;
import com.skeetpro.model.RigaOrdine;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    
    private OrdineDAO ordineDAO;
    private ClienteDAO clienteDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.ordineDAO = new OrdineDAOImpl();
        this.clienteDAO = new ClienteDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cliente utente = (Cliente) session.getAttribute("utente");
        
        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null || carrello.getRighe().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carrello");
            return;
        }

        java.time.LocalDate scadenza = clienteDAO.getPortoArmiScadenza(utente.getCf());
        boolean hasValidPortoArmi = scadenza != null && scadenza.isAfter(java.time.LocalDate.now());

        for (RigaCarrello rc : carrello.getRighe()) {
            if ("Arma".equalsIgnoreCase(rc.getTipo()) || "Munizione".equalsIgnoreCase(rc.getTipo())) {
                if (!"Socio".equalsIgnoreCase(utente.getTipoCliente()) || !hasValidPortoArmi) {
                    session.setAttribute("erroreCarrello", "Per noleggiare armi o acquistare munizioni è necessario essere Soci con Porto d'Armi in corso di validità.");
                    response.sendRedirect(request.getContextPath() + "/carrello");
                    return;
                }
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cliente utente = (Cliente) session.getAttribute("utente");
        
        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if (utente instanceof com.skeetpro.model.Socio) {
            com.skeetpro.model.Socio socio = (com.skeetpro.model.Socio) utente;
            if ("Sospeso".equalsIgnoreCase(socio.getStato()) || "Scaduto".equalsIgnoreCase(socio.getStato())) {
                session.setAttribute("erroreCarrello", "Il tuo account risulta " + socio.getStato() + ". Non puoi effettuare ordini.");
                response.sendRedirect(request.getContextPath() + "/carrello");
                return;
            }
        }

        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null || carrello.getRighe().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carrello");
            return;
        }

        java.time.LocalDate scadenza = clienteDAO.getPortoArmiScadenza(utente.getCf());
        boolean hasValidPortoArmi = scadenza != null && scadenza.isAfter(java.time.LocalDate.now());
        boolean expiresSoon = hasValidPortoArmi && scadenza.isBefore(java.time.LocalDate.now().plusDays(30));

        for (RigaCarrello rc : carrello.getRighe()) {
            if ("Arma".equalsIgnoreCase(rc.getTipo()) || "Munizione".equalsIgnoreCase(rc.getTipo())) {
                if (!"Socio".equalsIgnoreCase(utente.getTipoCliente()) || !hasValidPortoArmi) {
                    session.setAttribute("erroreCarrello", "Per noleggiare armi o acquistare munizioni è necessario essere Soci con Porto d'Armi in corso di validità.");
                    response.sendRedirect(request.getContextPath() + "/carrello");
                    return;
                }
            }
        }

        Ordine ordine = new Ordine();
        ordine.setClienteCF(utente.getCf());
        
        for (RigaCarrello rc : carrello.getRighe()) {
            RigaOrdine ro = new RigaOrdine();
            ro.setIdProdotto(rc.getIdProdotto());
            ro.setTipoProdotto(rc.getTipo());
            ro.setPrezzo(rc.getPrezzoUnitario());
            ro.setQuantita(rc.getQuantita());
            ro.setDurata(rc.getDurata());
            ordine.addRiga(ro);
        }

        try {
            ordineDAO.salvaOrdine(ordine);
            session.removeAttribute("carrello");
            
            String msg = "Ordine confermato con successo (Codice: " + ordine.getCodice() + ").";
            if (expiresSoon) {
                msg += " ATTENZIONE: Il tuo Porto d'Armi scadrà tra meno di 30 giorni (" + scadenza + "). Ricordati di rinnovarlo!";
            }
            session.setAttribute("successMessage", msg);
            
            response.sendRedirect(request.getContextPath() + "/home");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("erroreCarrello", "Si è verificato un errore durante il checkout: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/carrello");
        }
    }
}
