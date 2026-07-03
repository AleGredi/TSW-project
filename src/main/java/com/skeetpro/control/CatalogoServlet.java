package com.skeetpro.control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.skeetpro.dao.ArmaDAO;
import com.skeetpro.dao.MunizioneDAO;
import com.skeetpro.dao.impl.ArmaDAOImpl;
import com.skeetpro.dao.impl.MunizioneDAOImpl;
import com.skeetpro.model.Arma;
import com.skeetpro.model.Munizione;

@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CatalogoServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArmaDAO armaDAO = new ArmaDAOImpl();
        MunizioneDAO munizioneDAO = new MunizioneDAOImpl();
        
        String search = request.getParameter("q");
        
        List<Arma> armi = armaDAO.findAllAttive(search);
        List<Munizione> munizioni = munizioneDAO.findAllAttive(search);
        
        request.setAttribute("armi", armi);
        request.setAttribute("munizioni", munizioni);
        
        request.getRequestDispatcher("/WEB-INF/views/catalogo.jsp").forward(request, response);
    }
}
