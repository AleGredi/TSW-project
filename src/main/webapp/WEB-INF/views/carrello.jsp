<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Il Tuo Carrello - SkeetPro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
</head>
<body class="cart-page">

    <jsp:include page="header.jsp" />

    <main class="cart-container">
        <c:choose>
            <c:when test="${empty sessionScope.carrello or empty sessionScope.carrello.righe}">
                <div class="empty-cart">
                    <h2 style="text-transform: uppercase;">Il tuo carrello è vuoto</h2>
                    <p>Sembra che tu non abbia ancora aggiunto nulla per la tua prossima sessione di tiro.</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn-outline">Scopri il Catalogo</a>
                </div>
            </c:when>
            
            <c:otherwise>
                <c:if test="${not empty sessionScope.erroreCarrello}">
                <div class="error-message" style="background-color: var(--color-error); color: white; padding: 10px; border-radius: 8px; margin-bottom: 20px;">
                    ${sessionScope.erroreCarrello}
                </div>
                <c:remove var="erroreCarrello" scope="session" />
            </c:if>

            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Prodotto</th>
                        <th>Tipo</th>
                        <th>Quantità</th>
                        <th>Durata (h)</th>
                        <th>Prezzo Unitario</th>
                        <th>Totale</th>
                        <th>Azione</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="riga" items="${sessionScope.carrello.righe}">
                        <tr>
                            <td><strong>${riga.nome}</strong></td>
                            <td><span class="badge ${riga.tipo.toLowerCase()}">${riga.tipo}</span></td>
                            <td>
                                <div style="display: flex; align-items: center; justify-content: center; gap: 10px;">
                                    <button class="btn-outline" style="padding: 2px 8px; min-width: auto; height: 30px;" onclick="aggiornaQuantita('${riga.idProdotto}', '${riga.tipo}', ${riga.quantita}, -1)">-</button>
                                    <span style="font-weight: bold; width: 20px; text-align: center;">${riga.quantita}</span>
                                    <button class="btn-outline" style="padding: 2px 8px; min-width: auto; height: 30px;" onclick="aggiornaQuantita('${riga.idProdotto}', '${riga.tipo}', ${riga.quantita}, 1)">+</button>
                                </div>
                            </td>
                            <td>${riga.durata > 0 ? riga.durata : '-'}</td>
                            <td>€ <fmt:formatNumber value="${riga.prezzoUnitario}" minFractionDigits="2" /></td>
                            <td><strong>€ <fmt:formatNumber value="${riga.totaleRiga}" minFractionDigits="2" /></strong></td>
                            <td>
                                <button class="btn-remove" onclick="rimuoviDalCarrello('${riga.idProdotto}', '${riga.tipo}')">Rimuovi</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="cart-summary">
                <h3>Totale Ordine: <span id="cart-totale">€ <fmt:formatNumber value="${sessionScope.carrello.totale}" minFractionDigits="2" /></span></h3>
                <form action="${pageContext.request.contextPath}/checkout" method="get" style="margin: 0;">
                    <button type="submit" class="btn-checkout">PROCEDI AL PAGAMENTO</button>
                </form>
            </div>
            </c:otherwise>
        </c:choose>
    </main>

    <script src="${pageContext.request.contextPath}/scripts/carrello.js"></script>
</body>
</html>
