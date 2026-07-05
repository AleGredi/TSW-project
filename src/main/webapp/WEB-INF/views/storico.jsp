<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Storico ${tipoStorico == 'noleggi' ? 'Noleggi' : 'Acquisti'} - SkeetPro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/storico.css">
</head>
<body>

    <jsp:include page="header.jsp" />

    <main class="dashboard layout-wrapper-33">
        
        <div class="spacing-element-34">
            <h2 class="spacing-element-18-text-primary-font-family-EB-Garamond-serif-upp">
                <c:choose>
                    <c:when test="${tipoStorico == 'noleggi'}">STORICO NOLEGGI ARMI</c:when>
                    <c:when test="${tipoStorico == 'acquisti'}">STORICO ACQUISTI MUNIZIONI</c:when>
                    <c:otherwise>STORICO PRENOTAZIONI CAMPI</c:otherwise>
                </c:choose>
            </h2>
            <a href="${pageContext.request.contextPath}/profilo" class="btn-outline">TORNA AL PROFILO</a>
        </div>

        <c:if test="${not empty errore}">
            <div class="error-message">${errore}</div>
        </c:if>

        <c:choose>
            <c:when test="${tipoStorico == 'campi' && not empty prenotazioniPagina}">
                <div class="cart-table-wrapper custom-element-36">
                    <table class="cart-table spacing-element-37">
                        <thead>
                            <tr>
                                <th>Codice Prenotazione</th>
                                <th>Campo</th>
                                <th>Data / Ora</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${prenotazioniPagina}" var="p">
                                <tr>
                                    <td class="highlight-text-38">#${p.codice}</td>
                                    <td><strong>Campo ${p.campoId}</strong></td>
                                    <td>
                                        <span class="custom-element-39"><fmt:formatDate value="${p.data}" pattern="dd/MM/yyyy" /></span>
                                        <span class="product-type spacing-element-40"><fmt:formatDate value="${p.fasciaOraria}" pattern="HH:mm" /></span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>

            <c:when test="${tipoStorico != 'campi' && not empty ordiniPagina}">
                <c:forEach items="${ordiniPagina}" var="ordine">
                    <div class="checkout-panel">
                        <div class="custom-element-41">
                            <div>
                                <strong class="highlight-text-42">Ordine #${ordine.codice}</strong><br>
                                <span class="text-small-centered-43"><fmt:formatDate value="${ordine.data}" pattern="dd/MM/yyyy HH:mm"/></span>
                            </div>
                            <div>
                                <span class="product-type highlight-text-44">${ordine.stato}</span>
                            </div>
                        </div>
                        <table class="cart-table spacing-element-18-box-shadow-none-border-1-solid-eee">
                            <thead class="panel-box-46">
                                <tr>
                                    <th>Prodotto</th>
                                    <th>Prezzo Unitario</th>
                                    <th>Quantità</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${ordine.righe}" var="riga">
                                    <c:if test="${(tipoStorico == 'noleggi' && (riga.tipoProdotto == 'Arma' || riga.tipoProdotto == 'arma')) || (tipoStorico == 'acquisti' && (riga.tipoProdotto == 'Munizione' || riga.tipoProdotto == 'munizione'))}">
                                        <tr>
                                            <td>
                                                <strong>${riga.idProdotto}</strong><br>
                                                <span class="product-type">${riga.tipoProdotto}</span>
                                                <c:if test="${riga.durata > 0}">
                                                    <br><small class="highlight-text-47">${riga.durata} ore</small>
                                                </c:if>
                                            </td>
                                            <td>€ <fmt:formatNumber value="${riga.prezzo}" minFractionDigits="2" /></td>
                                            <td class="custom-element-48">x${riga.quantita}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:forEach>
            </c:when>
            
            <c:otherwise>
                <p class="custom-element-49">Nessun risultato trovato per questa categoria.</p>
            </c:otherwise>
        </c:choose>

        <c:if test="${(tipoStorico == 'campi' && not empty prenotazioniPagina) || (tipoStorico != 'campi' && not empty ordiniPagina)}">
            <div class="pagination">
                <c:choose>
                    <c:when test="${currentPage > 1}">
                        <a href="?tipo=${tipoStorico}&page=${currentPage - 1}" class="page-btn">PRECEDENTI</a>
                    </c:when>
                    <c:otherwise>
                        <span class="page-btn disabled">PRECEDENTI</span>
                    </c:otherwise>
                </c:choose>
                
                <span class="d-flex-align-items-center-highlight-text-38">Pagina ${currentPage} di ${totalPages}</span>
                
                <c:choose>
                    <c:when test="${currentPage < totalPages}">
                        <a href="?tipo=${tipoStorico}&page=${currentPage + 1}" class="page-btn">PROSSIMI</a>
                    </c:when>
                    <c:otherwise>
                        <span class="page-btn disabled">PROSSIMI</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

    </main>

</body>
</html>
