package com.skeetpro.control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.skeetpro.dao.PrenotazioneDAO;
import com.skeetpro.dao.impl.PrenotazioneDAOImpl;
import com.skeetpro.model.PrenotazioneAdminDTO;

@WebServlet("/admin/prenotazioni")
public class AdminPrenotazioniServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PrenotazioneDAO prenotazioneDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.prenotazioneDAO = new PrenotazioneDAOImpl();
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

        List<PrenotazioneAdminDTO> prenotazioni = prenotazioneDAO.findPrenotazioniFiltrate(dataDa, dataA, cliente);
        request.setAttribute("prenotazioni", prenotazioni);
        request.setAttribute("dataDa", dataDa);
        request.setAttribute("dataA", dataA);
        request.setAttribute("cliente", cliente);
        request.getRequestDispatcher("/WEB-INF/view/admin/prenotazioni.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null || session.getAttribute("adminCsrfToken") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        if ("elimina".equals(action)) {
            String codice = request.getParameter("codice");
            prenotazioneDAO.deleteByCodice(codice);
        }

        response.sendRedirect(request.getContextPath() + "/admin/prenotazioni");
    }
}
