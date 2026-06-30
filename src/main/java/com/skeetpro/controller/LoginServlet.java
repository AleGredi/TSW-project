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
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            com.skeetpro.dao.ClienteDAO clienteDAO = new com.skeetpro.dao.impl.ClienteDAOImpl();
            Cliente utenteLoggato = clienteDAO.doLogin(email, password);
            
            if (utenteLoggato != null) {
                HttpSession session = request.getSession();
                session.setAttribute("utente", utenteLoggato);
                
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.setAttribute("errore", "Credenziali errate! Riprova.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errore", "Eccezione: " + e.getMessage() + " - Cause: " + e.getCause());
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
