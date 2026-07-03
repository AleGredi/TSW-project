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
                    Totale da pagare: <span style="color: var(--color-accent);">€ <fmt:formatNumber value="${sessionScope.carrello.totale}" minFractionDigits="2" /></span>
                </div>
                <p style="font-size: 12px; color: var(--color-muted); margin-top: 20px; line-height: 1.5;">
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
                <h2>Dati di Pagamento</h2>
                
                <div class="payment-icons">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1200px-Mastercard-logo.svg.png" alt="Mastercard" style="object-fit: contain;">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png" alt="Visa" style="object-fit: contain;">
                </div>

                <form action="${pageContext.request.contextPath}/checkout" method="post" id="paymentForm">
                    <div class="form-group">
                        <label for="titolare">Intestatario Carta</label>
                        <input type="text" id="titolare" name="titolare" placeholder="Mario Rossi" required>
                        <div class="input-error" style="display:none; color: #d93025; font-size: 12px; margin-top: 5px;"></div>
                    </div>

                    <div class="form-group">
                        <label for="numeroCarta">Numero Carta</label>
                        <input type="text" id="numeroCarta" name="numeroCarta" placeholder="1234 5678 1234 5678" maxlength="19" required>
                        <div class="input-error" style="display:none; color: #d93025; font-size: 12px; margin-top: 5px;"></div>
                    </div>

                    <div class="input-row">
                        <div class="form-group">
                            <label for="scadenza">Scadenza (MM/AA)</label>
                            <input type="text" id="scadenza" name="scadenza" placeholder="12/26" maxlength="5" required>
                            <div class="input-error" style="display:none; color: #d93025; font-size: 12px; margin-top: 5px;"></div>
                        </div>
                        <div class="form-group">
                            <label for="cvv">CVV</label>
                            <input type="password" id="cvv" name="cvv" placeholder="123" maxlength="3" required>
                            <div class="input-error" style="display:none; color: #d93025; font-size: 12px; margin-top: 5px;"></div>
                        </div>
                    </div>

                    <button type="submit" class="btn-submit" style="width: 100%; margin-top: 10px;">PAGA E CONFERMA ORDINE</button>
                </form>
            </div>
        </div>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('paymentForm');
            const numCarta = document.getElementById('numeroCarta');
            const scadenza = document.getElementById('scadenza');
            const cvv = document.getElementById('cvv');

            numCarta.addEventListener('input', function(e) {
                let val = e.target.value.replace(/\D/g, '');
                if (val.length > 0) {
                    val = val.match(/.{1,4}/g).join(' ');
                }
                e.target.value = val;
            });

            scadenza.addEventListener('input', function(e) {
                let val = e.target.value.replace(/\D/g, '');
                if (val.length >= 2) {
                    val = val.substring(0, 2) + '/' + val.substring(2, 4);
                }
                e.target.value = val;
            });
            
            cvv.addEventListener('input', function(e) {
                e.target.value = e.target.value.replace(/\D/g, '');
            });

            form.addEventListener('submit', function(e) {
                let valid = true;

                if (numCarta.value.replace(/\D/g, '').length < 16) {
                    showError(numCarta, 'Il numero della carta deve contenere 16 cifre.');
                    valid = false;
                } else {
                    clearError(numCarta);
                }
                
                if (cvv.value.length < 3) {
                    showError(cvv, 'Il CVV deve contenere 3 cifre.');
                    valid = false;
                } else {
                    clearError(cvv);
                }

                if (!valid) {
                    e.preventDefault();
                }
            });
        });
    </script>
    <script src="${pageContext.request.contextPath}/scripts/validazione.js"></script>
</body>
</html>
