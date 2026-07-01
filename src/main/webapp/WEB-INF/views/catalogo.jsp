<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogo - SkeetPro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
</head>
<body class="home-page">

    <div class="header">
        <h1>SkeetPro - Catalogo Pubblico</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <c:choose>
                <c:when test="${not empty sessionScope.utente}">
                    <a href="${pageContext.request.contextPath}/logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login">Login</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="home-container" style="max-width: 1000px;">
        
        <h2 style="color: #0056b3; border-bottom: 2px solid #ddd; padding-bottom: 10px;">Armi a Noleggio</h2>
        <div class="dashboard-cards" style="justify-content: flex-start;">
            <c:choose>
                <c:when test="${empty armi}">
                    <p>Nessuna arma disponibile al momento.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="arma" items="${armi}">
                        <div class="card" style="width: 250px;">
                            <img src="${pageContext.request.contextPath}/ImageRenderer?type=arma&id=${arma.matricola}" alt="${arma.modello}" style="width: 100%; height: 150px; object-fit: contain; background: #fff; border-radius: 4px;">
                            <h3 style="margin-top: 10px;">${arma.modello}</h3>
                            <p style="font-size: 14px; color: #555;">Calibro: <strong>${arma.calibro}</strong></p>
                            <p style="font-size: 12px; color: #777; height: 40px; overflow: hidden;">${arma.descrizione}</p>
                            <div style="font-size: 18px; font-weight: bold; color: #28a745; margin-top: 10px;">
                                &euro; ${arma.prezzoNoleggio} / sessione
                            </div>
                            <!-- Il carrello verrà gestito in un'altra fase (solo socio) -->
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <h2 style="color: #0056b3; border-bottom: 2px solid #ddd; padding-bottom: 10px; margin-top: 50px;">Munizioni</h2>
        <div class="dashboard-cards" style="justify-content: flex-start;">
            <c:choose>
                <c:when test="${empty munizioni}">
                    <p>Nessuna munizione disponibile al momento.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="mun" items="${munizioni}">
                        <div class="card" style="width: 250px;">
                            <img src="${pageContext.request.contextPath}/ImageRenderer?type=munizione&id=${mun.lotto}" alt="${mun.calibro}" style="width: 100%; height: 150px; object-fit: contain; background: #fff; border-radius: 4px;">
                            <h3 style="margin-top: 10px;">${mun.marca}</h3>
                            <p style="font-size: 14px; color: #555;">Calibro: <strong>${mun.calibro}</strong></p>
                            <p style="font-size: 12px; color: #777; height: 40px; overflow: hidden;">${mun.descrizione}</p>
                            <div style="font-size: 18px; font-weight: bold; color: #28a745; margin-top: 10px;">
                                &euro; ${mun.prezzo}
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

</body>
</html>
