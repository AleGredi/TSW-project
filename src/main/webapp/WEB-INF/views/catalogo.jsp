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
        
        <div class="search-container" style="margin-bottom: 40px; text-align: center; background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #eaeaea;">
            <h2 style="font-family: 'EB Garamond', serif; text-transform: uppercase; margin-bottom: 20px; font-size: 24px; color: var(--color-primary);">Ricerca nel Catalogo</h2>
            <form action="${pageContext.request.contextPath}/catalogo" method="get" style="display: flex; width: 100%; max-width: 600px; gap: 10px; margin: 0 auto;">
                <input type="text" name="q" value="${param.q}" placeholder="Cerca per modello, marca o calibro..." style="flex: 1; padding: 12px 20px; border: 1px solid #ccc; border-radius: 50px; font-size: 16px; outline: none;">
                <button type="submit" class="btn-submit" style="border-radius: 50px; padding: 12px 30px;">CERCA</button>
            </form>
            <c:if test="${not empty param.q}">
                <div style="margin-top: 20px; font-size: 15px;">
                    Risultati della ricerca per: <strong>${param.q}</strong> 
                    <a href="${pageContext.request.contextPath}/catalogo" style="color: var(--color-error); text-decoration: none; margin-left: 15px; font-weight: bold;">[ X Annulla ]</a>
                </div>
            </c:if>
        </div>
        
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
