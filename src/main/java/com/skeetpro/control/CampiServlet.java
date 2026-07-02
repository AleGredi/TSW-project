package com.skeetpro.control;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import com.skeetpro.dao.CampoDAO;
import com.skeetpro.dao.PrenotazioneDAO;
import com.skeetpro.dao.impl.CampoDAOImpl;
import com.skeetpro.dao.impl.PrenotazioneDAOImpl;
import com.skeetpro.model.Campo;
import com.skeetpro.model.Cliente;
import com.skeetpro.model.Prenotazione;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/campi")
public class CampiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private CampoDAO campoDAO;
    private PrenotazioneDAO prenotazioneDAO;

    public void init() {
        campoDAO = new CampoDAOImpl();
        prenotazioneDAO = new PrenotazioneDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("checkSlot".equals(action)) {
            checkSlotAvailability(request, response);
            return;
        }

        List<Campo> campi = campoDAO.findAll();
        request.setAttribute("campi", campi);
        
        request.getRequestDispatcher("/WEB-INF/views/campi.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cliente utente = (Cliente) session.getAttribute("utente");
        
        try {
            int campoId = Integer.parseInt(request.getParameter("campoId"));
            Date data = Date.valueOf(request.getParameter("data"));
            String timeStr = request.getParameter("fasciaOraria");
            if (timeStr.length() == 5) timeStr += ":00";
            Time fasciaOraria = Time.valueOf(timeStr);

            if (!prenotazioneDAO.isSlotAvailable(campoId, data, fasciaOraria)) {
                request.setAttribute("errore", "Lo slot selezionato non è più disponibile.");
                doGet(request, response); 
                return;
            }

            Prenotazione p = new Prenotazione();
            p.setCampoId(campoId);
            p.setData(data);
            p.setFasciaOraria(fasciaOraria);
            p.setClienteCf(utente.getCf());

            prenotazioneDAO.save(p);

            request.getSession().setAttribute("messaggioSuccesso", "Prenotazione effettuata con successo!");
            response.sendRedirect(request.getContextPath() + "/campi");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errore", "Dati inseriti non validi.");
            doGet(request, response);
        }
    }

    private void checkSlotAvailability(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            int campoId = Integer.parseInt(request.getParameter("campoId"));
            Date data = Date.valueOf(request.getParameter("data"));
            String timeStr = request.getParameter("fasciaOraria");
            if (timeStr.length() == 5) timeStr += ":00";
            Time fasciaOraria = Time.valueOf(timeStr);

            boolean disponibile = prenotazioneDAO.isSlotAvailable(campoId, data, fasciaOraria);
            response.getWriter().write("{\"disponibile\": " + disponibile + "}");
        } catch (Exception e) {
            response.getWriter().write("{\"disponibile\": false, \"errore\": \"Dati non validi\"}");
        }
    }
}
