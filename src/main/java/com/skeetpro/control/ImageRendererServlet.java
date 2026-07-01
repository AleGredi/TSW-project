package com.skeetpro.control;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.skeetpro.util.DataSourceProvider;

@WebServlet("/ImageRenderer")
public class ImageRendererServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String id = request.getParameter("id");
        
        if (type == null || id == null || type.trim().isEmpty() || id.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing type or id parameters");
            return;
        }

        String query = "";
        if ("arma".equalsIgnoreCase(type)) {
            query = "SELECT Foto FROM Arma WHERE Matricola = ?";
        } else if ("munizione".equalsIgnoreCase(type)) {
            query = "SELECT Foto FROM Munizioni WHERE Lotto = ?";
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid type parameter");
            return;
        }

        try (Connection conn = DataSourceProvider.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setString(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    byte[] imageBytes = rs.getBytes("Foto");
                    if (imageBytes != null && imageBytes.length > 0) {
                        response.setContentType("image/jpeg");
                        try (OutputStream os = response.getOutputStream()) {
                            os.write(imageBytes);
                            os.flush();
                        }
                        return;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // In caso di errore ignoriamo e proseguiamo (verrà fatto redirect al placeholder)
        }
        
        // Se l'immagine non è presente nel DB (null) o non c'è il record, reindirizziamo al placeholder statico
        String placeholder = "arma".equalsIgnoreCase(type) ? "/images/placeholder-gun.png" : "/images/placeholder-ammo.png";
        response.sendRedirect(request.getContextPath() + placeholder);
    }
}
