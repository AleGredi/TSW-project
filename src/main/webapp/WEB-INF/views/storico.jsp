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

    <main class="dashboard max-w-1000">
        
        <div class="d-flex-justify-content-space-between-align-items-c">
            <h2 class="m-0-text-primary-font-family-EB-Garamond-serif-upp">
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
                <div class="cart-table-wrapper box-shadow-0-4-15-rgba-0000-05-rounded-12-overflow">
                    <table class="cart-table mb-0-box-shadow-none">
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
                                    <td class="fw-bold-text-muted">#${p.codice}</td>
                                    <td><strong>Campo ${p.campoId}</strong></td>
                                    <td>
                                        <span class="d-block-text-dark-fw-600"><fmt:formatDate value="${p.data}" pattern="dd/MM/yyyy" /></span>
                                        <span class="product-type mt-4"><fmt:formatDate value="${p.fasciaOraria}" pattern="HH:mm" /></span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>

            <c:when test="${tipoStorico != 'campi' && not empty ordiniPagina}">
                <c:forEach items="${ordiniPagina}" var="ordine">
                    <div class="bg-fff-rounded-10-border-1-solid-eaeaea-box-shadow">
                        <div class="d-flex-justify-content-space-between-border-bottom">
                            <div>
                                <strong class="text-primary-fs-18">Ordine #${ordine.codice}</strong><br>
                                <span class="text-muted-fs-14"><fmt:formatDate value="${ordine.data}" pattern="dd/MM/yyyy HH:mm"/></span>
                            </div>
                            <div>
                                <span class="product-type bg-accent-text-white-border-none">${ordine.stato}</span>
                            </div>
                        </div>
                        <table class="cart-table m-0-box-shadow-none-border-1-solid-eee">
                            <thead class="bg-f9f9f9-text-dark">
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
                                                    <br><small class="text-muted">${riga.durata} ore</small>
                                                </c:if>
                                            </td>
                                            <td>€ <fmt:formatNumber value="${riga.prezzo}" minFractionDigits="2" /></td>
                                            <td class="fw-bold">x${riga.quantita}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:forEach>
            </c:when>
            
            <c:otherwise>
                <p class="text-muted-font-style-italic-bg-fff-p-30-rounded-1">Nessun risultato trovato per questa categoria.</p>
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
                
                <span class="d-flex-align-items-center-fw-bold-text-muted">Pagina ${currentPage} di ${totalPages}</span>
                
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
