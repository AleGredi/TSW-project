package com.skeetpro.controller;

import java.io.IOException;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.skeetpro.model.Cliente;
import com.skeetpro.model.Socio;
import com.skeetpro.model.Temporaneo;
import com.skeetpro.dao.ClienteDAO;
import com.skeetpro.dao.impl.ClienteDAOImpl;

@WebServlet("/registrazione")
public class RegistrazioneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegistrazioneServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/registrazione.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupero i parametri base del Cliente dal form
        String cf = request.getParameter("cf");
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String tipoCliente = request.getParameter("tipoCliente");

        Cliente nuovoCliente = null;
        String numTessera = null;

        // In base al tipo scelto nel form, instanzio la sottoclasse corretta (Gerarchia disgiunta)
        if ("Socio".equalsIgnoreCase(tipoCliente)) {
            // Genero in automatico il numero di tessera
            numTessera = "TESS-" + java.util.UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            // Per semplicità, consideriamo la data d'iscrizione come la data odierna
            LocalDate dataIscrizione = LocalDate.now(); 
            nuovoCliente = new Socio(cf, nome, cognome, email, password, "Socio", numTessera, dataIscrizione);
        } else {
            nuovoCliente = new Temporaneo(cf, nome, cognome, email, password, "Temporaneo");
        }

        // Chiamo il DAO per salvare
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        boolean success = clienteDAO.save(nuovoCliente);

        if (success) {
            // Salvo il messaggio in sessione per mostrarlo dopo il redirect
            jakarta.servlet.http.HttpSession session = request.getSession();
            if (numTessera != null) {
                session.setAttribute("successMessage", "Registrazione completata! Il tuo Numero Tessera è: <strong>" + numTessera + "</strong>");
            } else {
                session.setAttribute("successMessage", "Registrazione completata con successo!");
            }
            // Se la registrazione va a buon fine, reindirizzo al login (PRG Pattern)
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Se fallisce (es. CF o Email già presenti nel DB), torno alla JSP mostrando l'errore
            request.setAttribute("errore", "Errore durante la registrazione. Assicurati che il CF o l'Email non siano già in uso.");
            request.getRequestDispatcher("/WEB-INF/views/registrazione.jsp").forward(request, response);
        }
    }
}
