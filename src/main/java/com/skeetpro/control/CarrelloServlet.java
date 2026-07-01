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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession();
        

        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello);
        }

        if ("/add".equals(pathInfo)) {
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
        
        } else if ("/remove".equals(pathInfo)) {
            String idProdotto = request.getParameter("idProdotto");
            String tipo = request.getParameter("tipo");
            
            carrello.removeRiga(idProdotto, tipo);
            
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"success\", \"nuovoTotale\":" + carrello.getTotale() + "}");
        
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Azione carrello non valida");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/carrello.jsp").forward(request, response);
    }
}
