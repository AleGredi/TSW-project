package com.skeetpro.control;

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
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("utente") != null) {
            Cliente utente = (Cliente) session.getAttribute("utente");
            request.setAttribute("ruolo", utente.getTipoCliente());
        } else {
            request.setAttribute("ruolo", "Guest");
        }

        request.getRequestDispatcher("/WEB-INF/view/home.jsp").forward(request, response);
    }
}
