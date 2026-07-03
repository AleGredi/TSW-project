package com.skeetpro.control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.skeetpro.model.Admin;
import com.skeetpro.dao.AdminDAO;
import com.skeetpro.dao.impl.AdminDAOImpl;

@WebServlet({"/admin/login", "/admin"})
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.adminDAO = new AdminDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            response.sendRedirect(request.getContextPath() + "/admin/utenti");
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Admin adminLoggato = adminDAO.login(username, password);
            
            if (adminLoggato != null) {
                HttpSession session = request.getSession();
                session.setAttribute("admin", adminLoggato);
                
                String token = java.util.UUID.randomUUID().toString();
                session.setAttribute("adminCsrfToken", token);
                
                response.sendRedirect(request.getContextPath() + "/admin/utenti");
            } else {
                request.setAttribute("errore", "Credenziali Admin non valide.");
                request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errore", "Si è verificato un errore: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(request, response);
        }
    }
}
