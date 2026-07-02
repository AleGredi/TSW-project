package com.skeetpro.control;

import java.io.IOException;
import java.util.List;

import com.skeetpro.dao.ClienteDAO;
import com.skeetpro.dao.OrdineDAO;
import com.skeetpro.dao.PrenotazioneDAO;
import com.skeetpro.dao.impl.ClienteDAOImpl;
import com.skeetpro.dao.impl.OrdineDAOImpl;
import com.skeetpro.dao.impl.PrenotazioneDAOImpl;
import com.skeetpro.model.Cliente;
import com.skeetpro.model.Ordine;
import com.skeetpro.model.Prenotazione;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profilo")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private PrenotazioneDAO prenotazioneDAO;
    private OrdineDAO ordineDAO;
    private ClienteDAO clienteDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.prenotazioneDAO = new PrenotazioneDAOImpl();
        this.ordineDAO = new OrdineDAOImpl();
        this.clienteDAO = new ClienteDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cliente utente = (Cliente) session.getAttribute("utente");

        try {
            if ("Socio".equalsIgnoreCase(utente.getTipoCliente())) {
                java.time.LocalDate scadenza = clienteDAO.getPortoArmiScadenza(utente.getCf());
                if (scadenza != null) {
                    java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    request.setAttribute("scadenzaPortoArmi", scadenza.format(formatter));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore nel caricamento dei dati del profilo: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }
}
