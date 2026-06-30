<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkeetPro - Home</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
</head>
<body class="home-page">

    <div class="header">
        <h1>SkeetPro</h1>
        <div class="nav-links">
            <c:choose>
                <c:when test="${not empty sessionScope.utente}">
                    <a href="${pageContext.request.contextPath}/logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login">Login</a>
                    <a href="${pageContext.request.contextPath}/registrazione">Registrati</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="container">
        <div class="welcome-box">
            <c:choose>
                <c:when test="${not empty sessionScope.utente}">
                    <h2>Benvenuto, ${sessionScope.utente.nome} ${sessionScope.utente.cognome}!</h2>
                    <p>Accesso effettuato come: <strong>${ruolo}</strong></p>
                    <c:if test="${ruolo == 'Socio'}">
                        <p style="color: #0056b3; font-weight: bold; margin-top: 10px;">
                            Numero Tessera Socio: ${sessionScope.utente.numeroTessera}
                        </p>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <h2>Benvenuto al circolo di tiro a volo SkeetPro!</h2>
                    <p>Effettua il login o registrati per prenotare campi, noleggiare armi o acquistare munizioni.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="dashboard-cards">
            <!-- Visibile a tutti -->
            <div class="card">
                <h3>Catalogo</h3>
                <p>Scopri armi e munizioni</p>
            </div>
            <div class="card">
                <h3>Gare</h3>
                <p>Calendario eventi pubblici</p>
            </div>

            <!-- Visibile solo agli utenti loggati (Temporaneo o Socio) -->
            <c:if test="${not empty sessionScope.utente}">
                <div class="card">
                    <h3>Prenota</h3>
                    <p>Prenota un campo</p>
                </div>
            </c:if>

            <!-- Visibile solo ai Soci -->
            <c:if test="${ruolo == 'Socio'}">
                <div class="card">
                    <h3>Armeria</h3>
                    <p>Acquisti e noleggi per Soci</p>
                </div>
            </c:if>
        </div>
    </div>

</body>
</html>
