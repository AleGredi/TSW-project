<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Il Tuo Carrello - SkeetPro</title>
    <!-- Usa un font di sistema pulito ma possiamo simulare eleganza con il CSS vanilla -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
</head>
<body class="cart-page">

    <jsp:include page="header.jsp" />

    <main class="cart-container">
        <c:choose>
            <c:when test="${empty sessionScope.carrello or empty sessionScope.carrello.righe}">
                <div class="empty-cart">
                    <h2>Il tuo carrello è vuoto 💨</h2>
                    <p>Sembra che tu non abbia ancora aggiunto nulla per la tua prossima sessione di tiro.</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn-outline">Scopri il Catalogo</a>
                </div>
            </c:when>
            
            <c:otherwise>
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th>Prodotto</th>
                            <th>Prezzo Unitario</th>
                            <th>Quantità</th>
                            <th>Durata (Ore)</th>
                            <th>Totale Riga</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="riga" items="${sessionScope.carrello.righe}">
                            <tr id="riga-${riga.idProdotto}">
                                <td>
                                    <span class="product-name">${riga.nome}</span>
                                    <span class="product-type">${riga.tipo}</span>
                                </td>
                                <td>€ <fmt:formatNumber value="${riga.prezzoUnitario}" minFractionDigits="2" /></td>
                                <td><strong>${riga.quantita}</strong></td>
                                <td>
                                    <c:if test="${riga.durata > 0}">⏳ ${riga.durata}</c:if>
                                    <c:if test="${riga.durata == 0}">-</c:if>
                                </td>
                                <td><strong>€ <fmt:formatNumber value="${riga.totaleRiga}" minFractionDigits="2" /></strong></td>
                                <td style="text-align: right;">
                                    <button class="btn-remove" onclick="rimuoviDalCarrello('${riga.idProdotto}', '${riga.tipo}')">❌ Rimuovi</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div class="cart-summary">
                    <h3>Totale Ordine: <span id="cart-totale">€ <fmt:formatNumber value="${sessionScope.carrello.totale}" minFractionDigits="2" /></span></h3>
                    <form action="${pageContext.request.contextPath}/checkout" method="post" style="margin: 0;">
                        <button type="submit" class="btn-checkout">💳 Procedi al Checkout</button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <script src="${pageContext.request.contextPath}/scripts/carrello.js"></script>
</body>
</html>
