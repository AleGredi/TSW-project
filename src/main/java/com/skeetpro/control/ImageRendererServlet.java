package com.skeetpro.control;

import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.skeetpro.dao.ArmaDAO;
import com.skeetpro.dao.MunizioneDAO;
import com.skeetpro.dao.impl.ArmaDAOImpl;
import com.skeetpro.dao.impl.MunizioneDAOImpl;

@WebServlet({"/ImageRenderer", "/image"})
public class ImageRendererServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ArmaDAO armaDAO;
    private MunizioneDAO munizioneDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.armaDAO = new ArmaDAOImpl();
        this.munizioneDAO = new MunizioneDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        if (type == null) type = request.getParameter("tipo");
        String id = request.getParameter("id");
        
        if (type == null || id == null || type.trim().isEmpty() || id.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing type or id parameters");
            return;
        }

        byte[] imageBytes = null;
        if ("arma".equalsIgnoreCase(type)) {
            imageBytes = armaDAO.getFoto(id.trim());
        } else if ("munizione".equalsIgnoreCase(type)) {
            imageBytes = munizioneDAO.getFoto(id.trim());
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid type parameter");
            return;
        }

        if (imageBytes != null && imageBytes.length > 0) {
            response.setContentType("image/jpeg");
            try (OutputStream os = response.getOutputStream()) {
                os.write(imageBytes);
                os.flush();
            }
            return;
        }
        
        String placeholder = "arma".equalsIgnoreCase(type) ? "/images/placeholder-gun.svg" : "/images/placeholder-ammo.svg";
        response.sendRedirect(request.getContextPath() + placeholder);
    }
}
