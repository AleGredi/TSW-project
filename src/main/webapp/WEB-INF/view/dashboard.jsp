<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Il mio Profilo - SkeetPro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
</head>
<body>

    <jsp:include page="header.jsp" />

    <main class="dashboard">
        <div class="welcome-box">
            <h2>Profilo di ${sessionScope.utente.nome} ${sessionScope.utente.cognome}</h2>
            <p class="user-meta">Tipo Account: <strong class="text-accent">${sessionScope.utente.tipoCliente}</strong> | C.F.: ${sessionScope.utente.cf}</p>
            
            <c:if test="${sessionScope.utente.tipoCliente == 'Socio'}">
                <p class="user-submeta">
                    Tessera N°: <strong>${sessionScope.utente.numeroTessera}</strong>
                    <c:choose>
                        <c:when test="${not empty scadenzaPortoArmi}">
                            | Scadenza Porto d'Armi: <strong>${scadenzaPortoArmi}</strong>
                        </c:when>
                        <c:otherwise>
                            | <span class="text-error">Porto d'Armi Non Inserito o Scaduto</span>
                        </c:otherwise>
                    </c:choose>
                </p>
            </c:if>
            
            <div class="dashboard-actions">
                <a href="${pageContext.request.contextPath}/storico?tipo=campi" class="btn">PRENOTAZIONI CAMPI</a>
                <a href="${pageContext.request.contextPath}/storico?tipo=noleggi" class="btn-outline">NOLEGGI ARMI</a>
                <a href="${pageContext.request.contextPath}/storico?tipo=acquisti" class="btn-outline">ACQUISTI MUNIZIONI</a>
            </div>
        </div>

        <c:if test="${not empty errore}">
            <div class="error-message">${errore}</div>
        </c:if>
    </main>

</body>
</html>
