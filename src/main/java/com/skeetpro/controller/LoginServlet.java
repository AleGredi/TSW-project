package com.skeetpro.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.skeetpro.model.Cliente;
import com.skeetpro.dao.*;
import com.skeetpro.dao.impl.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    // Il GET serve solo per mostrare la pagina HTML/JSP col form
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward alla vista
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    // Il POST serve a ricevere i dati quando l'utente clicca "Accedi"
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupero i parametri dal form HTML
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Usiamo il DAO per interrogare il vero database
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        Cliente utenteLoggato = clienteDAO.doLogin(email, password);
        
        if (utenteLoggato != null) {
            // Login corretto
            
            // Salvo l'utente nella sessione
            HttpSession session = request.getSession();
            session.setAttribute("utente", utenteLoggato);
            
            // Pattern PRG: Faccio un REDIRECT alla pagina principale
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            // Login fallito
            request.setAttribute("errore", "Credenziali errate! Riprova.");
            
            // Faccio FORWARD di nuovo alla pagina di login per mostrare l'errore
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
