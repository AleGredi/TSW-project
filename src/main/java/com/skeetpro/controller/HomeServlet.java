package com.skeetpro.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.skeetpro.model.Cliente;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public HomeServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // La home è accessibile a tutti, ma se c'è un utente loggato mostreremo contenuti personalizzati
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("utente") != null) {
            Cliente utente = (Cliente) session.getAttribute("utente");
            // Imposto il ruolo come attributo per facilitare i controlli nella JSP
            request.setAttribute("ruolo", utente.getTipoCliente());
        } else {
            request.setAttribute("ruolo", "Guest");
        }

        // Forward alla vista
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
