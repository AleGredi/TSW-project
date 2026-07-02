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
        <h2 style="font-family: 'EB Garamond', serif; text-transform: uppercase;">REGISTRATI</h2>
        
        <c:if test="${not empty errore}">
            <div class="error-message">${errore}</div>
        </c:if>

        <form id="regForm" action="${pageContext.request.contextPath}/registrazione" method="post">
            <div class="form-group">
                <label for="tipoCliente">TIPO DI ACCOUNT</label>
                <select id="tipoCliente" name="tipoCliente" onchange="toggleSocioFields()" required>
                    <option value="Temporaneo">Utente Temporaneo</option>
                    <option value="Socio">Socio del Circolo</option>
                </select>
            </div>

            <div class="form-group">
                <label for="cf">CODICE FISCALE</label>
                <input type="text" id="cf" name="cf" maxlength="16" required>
            </div>

            <div class="form-group">
                <label for="nome">NOME</label>
                <input type="text" id="nome" name="nome" required>
            </div>

            <div class="form-group">
                <label for="cognome">COGNOME</label>
                <input type="text" id="cognome" name="cognome" required>
            </div>

            <div class="form-group">
                <label for="email">EMAIL</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">PASSWORD</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div id="socio-fields" class="socio-fields">
                <small style="color: #666; display: block; margin-bottom: 10px;">La data d'iscrizione verrà impostata automaticamente a oggi. Il tuo <b>Numero Tessera</b> verrà generato automaticamente e mostrato al termine della registrazione.</small>
            </div>
            
            <button type="submit" class="btn-submit">REGISTRATI</button>
            
            <div style="text-align: center; margin-top: 25px; font-size: 14px;">
                Hai già un account? <a href="${pageContext.request.contextPath}/login" style="font-weight: bold; text-decoration: underline;">Accedi qui</a>
            </div>
        </form>
    </div>

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
    <script src="${pageContext.request.contextPath}/scripts/validazione.js"></script>
</body>
</html>
