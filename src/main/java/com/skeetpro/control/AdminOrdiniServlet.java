package com.skeetpro.control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.skeetpro.dao.OrdineDAO;
import com.skeetpro.dao.impl.OrdineDAOImpl;
import com.skeetpro.model.OrdineAdminDTO;

@WebServlet("/admin/ordini")
public class AdminOrdiniServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrdineDAO ordineDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.ordineDAO = new OrdineDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null || session.getAttribute("adminCsrfToken") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String dataDa = request.getParameter("dataDa");
        String dataA = request.getParameter("dataA");
        String cliente = request.getParameter("cliente");

        List<OrdineAdminDTO> ordini = ordineDAO.findOrdiniFiltrati(dataDa, dataA, cliente);
        request.setAttribute("ordini", ordini);
        request.setAttribute("dataDa", dataDa);
        request.setAttribute("dataA", dataA);
        request.setAttribute("cliente", cliente);
        request.getRequestDispatcher("/WEB-INF/view/admin/ordini.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null || session.getAttribute("adminCsrfToken") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("cambiaStato".equals(action)) {
                int codice = Integer.parseInt(request.getParameter("codice"));
                String nuovoStato = request.getParameter("stato");
                ordineDAO.updateStato(codice, nuovoStato);
                session.setAttribute("successMsg", "Stato dell'ordine aggiornato con successo!");
            }
        } catch (Exception e) {
            session.setAttribute("errorMsg", "Errore durante l'operazione: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/ordini");
    }
}
