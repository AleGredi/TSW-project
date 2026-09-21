package com.skeetpro.control;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.skeetpro.dao.OrdineDAO;
import com.skeetpro.dao.impl.OrdineDAOImpl;
import com.skeetpro.dao.PrenotazioneDAO;
import com.skeetpro.dao.impl.PrenotazioneDAOImpl;
import com.skeetpro.model.Cliente;
import com.skeetpro.model.Ordine;
import com.skeetpro.model.Prenotazione;
import com.skeetpro.model.RigaOrdine;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/storico")
public class StoricoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrdineDAO ordineDAO;
    private PrenotazioneDAO prenotazioneDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.ordineDAO = new OrdineDAOImpl();
        this.prenotazioneDAO = new PrenotazioneDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cliente utente = (Cliente) session.getAttribute("utente");
        String tipo = request.getParameter("tipo");
        if (tipo == null) tipo = "noleggi";

        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        try {
            int pageSize = 10;
            int total = 0;
            int totalPages = 1;

            if ("campi".equals(tipo)) {
                List<Prenotazione> tuttePrenotazioni = prenotazioneDAO.findByCliente(utente.getCf());
                total = tuttePrenotazioni.size();
                totalPages = (int) Math.ceil((double) total / pageSize);
                if (totalPages == 0) totalPages = 1;
                if (page > totalPages) page = totalPages;
                if (page < 1) page = 1;

                int start = (page - 1) * pageSize;
                int end = Math.min(start + pageSize, total);
                
                List<Prenotazione> paginatedPrenotazioni = tuttePrenotazioni.subList(start, end);
                request.setAttribute("prenotazioniPagina", paginatedPrenotazioni);
            } else {
                List<Ordine> tutti = ordineDAO.getOrdiniByCliente(utente.getCf());
                List<Ordine> filtrati = new ArrayList<>();
                
                for (Ordine o : tutti) {
                    boolean match = false;
                    for (RigaOrdine r : o.getRighe()) {
                        if ("noleggi".equals(tipo) && "Arma".equalsIgnoreCase(r.getTipoProdotto())) {
                            match = true;
                            break;
                        }
                        if ("acquisti".equals(tipo) && "Munizione".equalsIgnoreCase(r.getTipoProdotto())) {
                            match = true;
                            break;
                        }
                    }
                    if (match) {
                        filtrati.add(o);
                    }
                }

                total = filtrati.size();
                totalPages = (int) Math.ceil((double) total / pageSize);
                if (totalPages == 0) totalPages = 1;
                if (page > totalPages) page = totalPages;
                if (page < 1) page = 1;

                int start = (page - 1) * pageSize;
                int end = Math.min(start + pageSize, total);
                
                List<Ordine> paginatedList = filtrati.subList(start, end);
                request.setAttribute("ordiniPagina", paginatedList);
            }

            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("tipoStorico", tipo);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore nel caricamento dello storico: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/view/storico.jsp").forward(request, response);
    }
}
