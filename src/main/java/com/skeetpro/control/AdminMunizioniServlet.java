package com.skeetpro.control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.skeetpro.dao.MunizioneDAO;
import com.skeetpro.dao.impl.MunizioneDAOImpl;
import com.skeetpro.model.Munizione;

@WebServlet("/admin/munizioni")
public class AdminMunizioniServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MunizioneDAO munizioneDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.munizioneDAO = new MunizioneDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null || session.getAttribute("adminCsrfToken") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        List<Munizione> munizioni = munizioneDAO.findAll();
        request.setAttribute("munizioni", munizioni);
        request.getRequestDispatcher("/WEB-INF/view/admin/munizioni.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null || session.getAttribute("adminCsrfToken") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        String lotto = request.getParameter("lotto");

        try {
            if ("add".equals(action) || "edit".equals(action)) {
                Munizione m = new Munizione();
                m.setLotto(lotto);
                m.setMarca(request.getParameter("marca"));
                m.setCalibro(request.getParameter("calibro"));
                m.setDescrizione(request.getParameter("descrizione"));
                m.setPrezzo(Double.parseDouble(request.getParameter("prezzo")));
                m.setAttiva("on".equals(request.getParameter("attiva")));

                if ("add".equals(action)) {
                    munizioneDAO.save(m);
                    session.setAttribute("successMsg", "Munizione aggiunta al catalogo con successo!");
                } else {
                    munizioneDAO.update(m);
                    session.setAttribute("successMsg", "Munizione aggiornata con successo!");
                }
            } else if ("delete".equals(action)) {
                munizioneDAO.softDelete(lotto);
                session.setAttribute("successMsg", "Munizione sospesa (Soft Delete)!");
            } else if ("riattiva".equals(action)) {
                munizioneDAO.riattiva(lotto);
                session.setAttribute("successMsg", "Munizione riattivata nel catalogo!");
            }
        } catch (Exception e) {
            session.setAttribute("errorMsg", "Errore durante l'operazione: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/munizioni");
    }
}
