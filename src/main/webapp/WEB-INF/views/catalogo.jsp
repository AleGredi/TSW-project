<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogo - SkeetPro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/catalogo.css">
</head>
<body>

    <jsp:include page="header.jsp" />

    <main class="catalogo-container">
        
        <section class="catalogo-section">
            <h2>ARMI A NOLEGGIO</h2>
            <div class="cards-grid">
                <c:choose>
                    <c:when test="${empty armi}">
                        <p>Nessuna arma disponibile al momento.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="arma" items="${armi}">
                            <div class="product-card">
                                <img class="card-img" src="${pageContext.request.contextPath}/ImageRenderer?type=arma&id=${arma.matricola}" alt="${arma.modello}">
                                <div class="card-body">
                                    <span class="card-tag">${arma.calibro}</span>
                                    <h3>${arma.modello}</h3>
                                    <p class="card-desc">${arma.descrizione}</p>
                                    <div class="card-footer">
                                        <span class="card-price">€ ${arma.prezzoNoleggio} <small>/ ora</small></span>
                                        <button class="btn-add-cart" onclick="aggiungiAlCarrello('${arma.matricola}', 'Arma', '${arma.modello}', ${arma.prezzoNoleggio}, 1, 1)">NOLEGGIA</button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <section class="catalogo-section">
            <h2>MUNIZIONI</h2>
            <div class="cards-grid">
                <c:choose>
                    <c:when test="${empty munizioni}">
                        <p>Nessuna munizione disponibile al momento.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="mun" items="${munizioni}">
                            <div class="product-card">
                                <img class="card-img" src="${pageContext.request.contextPath}/ImageRenderer?type=munizione&id=${mun.lotto}" alt="${mun.marca}">
                                <div class="card-body">
                                    <span class="card-tag" style="background-color: var(--color-dark);">${mun.calibro}</span>
                                    <h3>${mun.marca}</h3>
                                    <p class="card-desc">${mun.descrizione}</p>
                                    <div class="card-footer">
                                        <span class="card-price">€ ${mun.prezzo} <small>/ scatola</small></span>
                                        <button class="btn-add-cart" onclick="aggiungiAlCarrello('${mun.lotto}', 'Munizione', '${mun.marca}', ${mun.prezzo}, 1, 0)">ACQUISTA</button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

    </main>

    <script src="${pageContext.request.contextPath}/scripts/carrello.js"></script>
</body>
</html>
