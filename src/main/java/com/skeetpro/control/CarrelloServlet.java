package com.skeetpro.control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.skeetpro.model.Carrello;
import com.skeetpro.model.RigaCarrello;

@WebServlet("/carrello/*")
public class CarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession();
        

        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello);
        }

        String action = request.getParameter("action");
        if ("/add".equals(pathInfo) || "add".equalsIgnoreCase(action)) {
            String idProdotto = request.getParameter("idProdotto");
            String tipo = request.getParameter("tipo");
            String nome = request.getParameter("nome");
            double prezzo = Double.parseDouble(request.getParameter("prezzo"));
            int quantita = Integer.parseInt(request.getParameter("quantita"));
            
            String durataStr = request.getParameter("durata");
            int durata = (durataStr != null && !durataStr.isEmpty()) ? Integer.parseInt(durataStr) : 0;

            carrello.addRiga(new RigaCarrello(idProdotto, tipo, nome, prezzo, quantita, durata));
            
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"success\", \"totaleArticoli\":" + carrello.getNumeroArticoli() + "}");
        
        } else if ("/update".equals(pathInfo) || "update".equalsIgnoreCase(action)) {
            String idProdotto = request.getParameter("idProdotto");
            String tipo = request.getParameter("tipo");
            int quantita = Integer.parseInt(request.getParameter("quantita"));
            
            if (quantita <= 0) {
                carrello.removeRiga(idProdotto, tipo);
            } else {
                carrello.setQuantita(idProdotto, tipo, quantita);
            }
            
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"success\", \"nuovoTotale\":" + carrello.getTotale() + "}");
        
        } else if ("/remove".equals(pathInfo) || "remove".equalsIgnoreCase(action)) {
            String idProdotto = request.getParameter("idProdotto");
            String tipo = request.getParameter("tipo");
            
            carrello.removeRiga(idProdotto, tipo);
            
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"success\", \"nuovoTotale\":" + carrello.getTotale() + "}");
        
        } else if ("/clear".equals(pathInfo) || "/svuota".equals(pathInfo) || "clear".equalsIgnoreCase(action) || "svuota".equalsIgnoreCase(action)) {
            carrello.svuota();
            
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"success\", \"nuovoTotale\":0.0, \"totaleArticoli\":0}");
        
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Azione carrello non valida");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        String action = request.getParameter("action");

        if ("/clear".equals(pathInfo) || "/svuota".equals(pathInfo) || "clear".equalsIgnoreCase(action) || "svuota".equalsIgnoreCase(action)) {
            HttpSession session = request.getSession();
            Carrello carrello = (Carrello) session.getAttribute("carrello");
            if (carrello != null) {
                carrello.svuota();
            }
            response.sendRedirect(request.getContextPath() + "/carrello");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/view/carrello.jsp").forward(request, response);
    }
}
