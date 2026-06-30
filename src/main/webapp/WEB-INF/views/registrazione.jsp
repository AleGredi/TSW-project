<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione - SkeetPro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
</head>
<body class="auth-page">
    <div class="reg-box">
        <h2>Registrati su SkeetPro</h2>
        
        <c:if test="${not empty errore}">
            <div class="error-message">${errore}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/registrazione" method="post">
            <div class="form-group">
                <label for="tipoCliente">Tipo di Account</label>
                <!-- JS onchange svela o nasconde i campi extra per il Socio -->
                <select id="tipoCliente" name="tipoCliente" onchange="toggleSocioFields()" required>
                    <option value="Temporaneo">Utente Temporaneo</option>
                    <option value="Socio">Socio del Circolo</option>
                </select>
            </div>

            <div class="form-group">
                <label for="cf">Codice Fiscale</label>
                <input type="text" id="cf" name="cf" maxlength="16" required>
            </div>

            <div class="form-group">
                <label for="nome">Nome</label>
                <input type="text" id="nome" name="nome" required>
            </div>

            <div class="form-group">
                <label for="cognome">Cognome</label>
                <input type="text" id="cognome" name="cognome" required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>

            <!-- Campi aggiuntivi visibili SOLO se sceglie "Socio" -->
            <div id="socio-fields" class="socio-fields">
                <small style="color: #666; display: block; margin-bottom: 10px;">La data d'iscrizione verrà impostata automaticamente a oggi. Il tuo <b>Numero Tessera</b> verrà generato automaticamente e mostrato al termine della registrazione.</small>
            </div>
            
            <button type="submit" class="btn-submit">Registrati</button>
            
            <div style="text-align: center; margin-top: 15px; font-size: 14px;">
                Hai già un account? <a href="${pageContext.request.contextPath}/login">Accedi qui</a>
            </div>
        </form>
    </div>

    <!-- Semplice script JS per mostrare/nascondere i campi del Socio -->
    <script>
        function toggleSocioFields() {
            var tipo = document.getElementById("tipoCliente").value;
            var socioFields = document.getElementById("socio-fields");
            
            if (tipo === "Socio") {
                socioFields.style.display = "block";
            } else {
                socioFields.style.display = "none";
            }
        }
    </script>
</body>
</html>
