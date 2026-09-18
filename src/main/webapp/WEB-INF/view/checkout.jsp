<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout e Pagamento - SkeetPro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/checkout.css">
</head>
<body class="cart-page">

    <jsp:include page="header.jsp" />

    <main class="checkout-wrapper">
        <div class="checkout-col">
            <div class="checkout-box">
                <h2>Riepilogo Ordine</h2>
                <ul class="order-recap-list">
                    <c:forEach var="riga" items="${sessionScope.carrello.righe}">
                        <li>
                            <span>${riga.quantita}x ${riga.nome}</span>
                            <span>€ <fmt:formatNumber value="${riga.totaleRiga}" minFractionDigits="2" /></span>
                        </li>
                    </c:forEach>
                </ul>
                <div class="order-recap-total">
                    Totale da pagare: <span class="text-accent">€ <fmt:formatNumber value="${sessionScope.carrello.totale}" minFractionDigits="2" /></span>
                </div>
                <p class="checkout-note">
                    <c:set var="haFisico" value="false" />
                    <c:forEach var="r" items="${sessionScope.carrello.righe}">
                        <c:if test="${r.tipo == 'Arma' || r.tipo == 'Munizione'}"><c:set var="haFisico" value="true" /></c:if>
                    </c:forEach>
                    <c:if test="${haFisico}">
                        * I beni fisici (Armi a noleggio e Munizioni) non vengono spediti e devono essere ritirati personalmente presso l'armeria del circolo, previa esibizione del Porto d'Armi.
                    </c:if>
                </p>
            </div>
        </div>

        <div class="checkout-col">
            <div class="checkout-box">
                <h2>Conferma e Pagamento</h2>

                <form action="${pageContext.request.contextPath}/checkout" method="post" id="paymentForm">
                    <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">

                    <div class="checkout-section-title">1. Dati di Spedizione e Recapito</div>
                    
                    <div class="form-group">
                        <label for="indirizzo">Indirizzo (Via e Civico)</label>
                        <input type="text" id="indirizzo" name="indirizzo" placeholder="Via Roma 12" required>
                    </div>

                    <div class="input-row">
                        <div class="form-group">
                            <label for="citta">Città</label>
                            <input type="text" id="citta" name="citta" placeholder="Salerno" required>
                        </div>
                        <div class="form-group">
                            <label for="cap">CAP</label>
                            <input type="text" id="cap" name="cap" placeholder="84100" maxlength="5" required>
                        </div>
                        <div class="form-group">
                            <label for="provincia">Provincia</label>
                            <input type="text" id="provincia" name="provincia" placeholder="SA" maxlength="2" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="telefono">Recapito Telefonico</label>
                        <input type="tel" id="telefono" name="telefono" placeholder="333 1234567" required>
                    </div>

                    <div class="checkout-section-title">2. Dati di Pagamento</div>


                    <div class="form-group">
                        <label for="titolare">Intestatario Carta</label>
                        <input type="text" id="titolare" name="titolare" placeholder="Mario Rossi" required>
                    </div>

                    <div class="form-group">
                        <label for="numeroCarta">Numero Carta</label>
                        <input type="text" id="numeroCarta" name="numeroCarta" placeholder="1234 5678 1234 5678" maxlength="19" required>
                    </div>

                    <div class="input-row">
                        <div class="form-group">
                            <label for="scadenza">Scadenza (MM/AA)</label>
                            <input type="text" id="scadenza" name="scadenza" placeholder="12/26" maxlength="5" required>
                        </div>
                        <div class="form-group">
                            <label for="cvv">CVV</label>
                            <input type="password" id="cvv" name="cvv" placeholder="123" maxlength="3" required>
                        </div>
                    </div>

                    <button type="submit" class="btn-submit">PAGA E CONFERMA ORDINE</button>
                </form>
            </div>
        </div>
    </main>

    <script src="${pageContext.request.contextPath}/scripts/validazione.js"></script>
    <script src="${pageContext.request.contextPath}/scripts/checkout.js"></script>
</body>
</html>
