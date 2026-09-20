package com.skeetpro.control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.skeetpro.dao.ArmaDAO;
import com.skeetpro.dao.impl.ArmaDAOImpl;
import com.skeetpro.model.Arma;

@WebServlet("/admin/armi")
public class AdminArmiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ArmaDAO armaDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.armaDAO = new ArmaDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null || session.getAttribute("adminCsrfToken") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        List<Arma> armi = armaDAO.findAll();
        request.setAttribute("armi", armi);
        request.getRequestDispatcher("/WEB-INF/view/admin/armi.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null || session.getAttribute("adminCsrfToken") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        String matricola = request.getParameter("matricola");

        try {
            if ("add".equals(action) || "edit".equals(action)) {
                Arma arma = new Arma();
                arma.setMatricola(matricola);
                arma.setModello(request.getParameter("modello"));
                arma.setCalibro(request.getParameter("calibro"));
                arma.setDescrizione(request.getParameter("descrizione"));
                arma.setPrezzoNoleggio(Double.parseDouble(request.getParameter("prezzoNoleggio")));
                arma.setAttiva("on".equals(request.getParameter("attiva")));

                if ("add".equals(action)) {
                    armaDAO.save(arma);
                    session.setAttribute("successMsg", "Arma aggiunta con successo!");
                } else {
                    armaDAO.update(arma);
                    session.setAttribute("successMsg", "Arma aggiornata con successo!");
                }
            } else if ("delete".equals(action)) {
                armaDAO.softDelete(matricola);
                session.setAttribute("successMsg", "Arma nascosta dal catalogo (Soft Delete)!");
            } else if ("riattiva".equals(action)) {
                armaDAO.riattiva(matricola);
                session.setAttribute("successMsg", "Arma riattivata e visibile nel catalogo!");
            }
        } catch (Exception e) {
            session.setAttribute("errorMsg", "Errore durante l'operazione: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/armi");
    }
}
