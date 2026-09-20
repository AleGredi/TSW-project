package com.skeetpro.control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.skeetpro.dao.ClienteDAO;
import com.skeetpro.dao.impl.ClienteDAOImpl;
import com.skeetpro.model.ClienteAdminDTO;

@WebServlet("/admin/utenti")
public class AdminUtentiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClienteDAO clienteDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.clienteDAO = new ClienteDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null || session.getAttribute("adminCsrfToken") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        List<ClienteAdminDTO> utenti = clienteDAO.findAllForAdmin();
        request.setAttribute("utenti", utenti);
        request.getRequestDispatcher("/WEB-INF/view/admin/utenti.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null || session.getAttribute("adminCsrfToken") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        String cf = request.getParameter("cf");

        try {
            if ("cambiaStato".equals(action)) {
                String nuovoStato = request.getParameter("stato");
                clienteDAO.updateStatoSocio(cf, nuovoStato);
                session.setAttribute("successMsg", "Stato socio aggiornato con successo!");
            } else if ("aggiornaPortoArmi".equals(action)) {
                String numLicenza = request.getParameter("numLicenza");
                String scadenza = request.getParameter("scadenza");
                if (numLicenza != null && !numLicenza.trim().isEmpty() && scadenza != null && !scadenza.trim().isEmpty()) {
                    clienteDAO.updatePortoArmi(cf, numLicenza.trim(), java.sql.Date.valueOf(scadenza));
                    session.setAttribute("successMsg", "Porto d'Armi aggiornato con successo!");
                } else {
                    session.setAttribute("errorMsg", "Compilare tutti i campi del Porto d'Armi.");
                }
            }
        } catch (Exception e) {
            session.setAttribute("errorMsg", "Errore durante l'operazione: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/utenti");
    }
}
