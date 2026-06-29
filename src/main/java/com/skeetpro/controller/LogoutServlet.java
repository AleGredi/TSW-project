package com.skeetpro.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LogoutServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupero la sessione corrente, ma passando "false" evito di crearne una nuova se non esiste
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Invalido la sessione: distrugge tutti i dati al suo interno (incluso l'utente loggato)
            session.invalidate();
        }
        
        // Pattern PRG: faccio un redirect in GET verso la home page
        response.sendRedirect(request.getContextPath() + "/home");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
