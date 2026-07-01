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

    <jsp:include page="header.jsp" />

    <main class="dashboard">
        <div class="welcome-box">
            <c:choose>
                <c:when test="${not empty sessionScope.utente}">
                    <h2>Benvenuto, ${sessionScope.utente.nome}!</h2>
                    <p>Il tuo livello di accesso è: <strong>${sessionScope.utente.tipoCliente}</strong></p>

                    <hr style="margin: 20px 0;">
                    
                    <h3>La tua Area Personale</h3>
                    <p>Usa la barra di navigazione in alto per accedere al catalogo, prenotare un campo, o gestire i tuoi noleggi.</p>
                    
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
            <a href="${pageContext.request.contextPath}/catalogo" class="card" style="text-decoration:none; color:inherit; display:block;">
                <h3>Catalogo</h3>
                <p>Scopri armi e munizioni</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/campi" class="card" style="text-decoration:none; color:inherit; display:block;">
                <h3>I Nostri Campi</h3>
                <p>Esplora le discipline e prenota</p>
            </a>


            <!-- Visibile solo agli utenti loggati (Temporaneo o Socio) -->
            <c:if test="${not empty sessionScope.utente}">
                <a href="${pageContext.request.contextPath}/campi" class="card" style="text-decoration:none; color:inherit; display:block;">
                    <h3>Prenota</h3>
                    <p>Scegli un campo e prenota</p>
                </a>
            </c:if>

            <!-- Visibile solo ai Soci -->
            <c:if test="${ruolo == 'Socio'}">
                <a href="${pageContext.request.contextPath}/catalogo" class="card" style="text-decoration:none; color:inherit; display:block;">
                    <h3>Armeria</h3>
                    <p>Acquisti e noleggi per Soci</p>
                </a>
            </c:if>
        </div>
    </div>

</body>
</html>
