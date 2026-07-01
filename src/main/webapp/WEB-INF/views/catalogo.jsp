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
    <style>
        .catalogo-container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        .catalogo-section { margin-bottom: 60px; }
        .catalogo-section h2 { color: var(--color-primary); font-size: 32px; border-bottom: 3px solid var(--color-accent); padding-bottom: 10px; margin-bottom: 30px; display: inline-block; }
        .cards-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 30px; }
        .product-card { background-color: var(--color-surface); border: 1px solid #e8e8e8; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: transform 0.3s ease, box-shadow 0.3s ease; display: flex; flex-direction: column; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .card-img { height: 180px; width: 100%; object-fit: contain; background-color: #fff; border-bottom: 1px solid #f0f0f0; }
        .card-body { padding: 20px; display: flex; flex-direction: column; flex-grow: 1; }
        .card-body h3 { margin: 0 0 10px 0; color: var(--color-dark); font-size: 20px; }
        .card-tag { display: inline-block; background-color: var(--color-primary); color: white; padding: 4px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; margin-bottom: 15px; align-self: flex-start; }
        .card-desc { color: var(--color-muted); font-size: 14px; line-height: 1.5; flex-grow: 1; margin-bottom: 20px; }
        .card-footer { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #e8e8e8; padding-top: 15px; margin-top: auto; }
        .card-price { font-size: 22px; font-weight: bold; color: var(--color-dark); }
        .card-price small { font-size: 12px; color: var(--color-muted); font-weight: normal; }
        .btn-add-cart { background-color: var(--color-accent); color: white; border: none; padding: 10px 15px; border-radius: 6px; font-weight: bold; cursor: pointer; transition: all 0.2s ease; }
        .btn-add-cart:hover { background-color: var(--color-accent-lt); transform: scale(1.05); }
    </style>
</head>
<body>

    <jsp:include page="header.jsp" />

    <main class="catalogo-container">
        
        <section class="catalogo-section">
            <h2>🎯 Armi a Noleggio</h2>
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
                                        <button class="btn-add-cart" onclick="aggiungiAlCarrello('${arma.matricola}', 'Arma', '${arma.modello}', ${arma.prezzoNoleggio}, 1, 1)">🛒 Noleggia</button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <section class="catalogo-section">
            <h2>📦 Munizioni</h2>
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
                                        <button class="btn-add-cart" onclick="aggiungiAlCarrello('${mun.lotto}', 'Munizione', '${mun.marca}', ${mun.prezzo}, 1, 0)">🛒 Acquista</button>
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
