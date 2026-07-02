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

    <main class="dashboard" style="max-width: 1000px;">
        
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-bottom: 2px solid var(--color-accent); padding-bottom: 15px;">
            <h2 style="margin: 0; color: var(--color-primary); font-family: 'EB Garamond', serif; text-transform: uppercase;">
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
                <div class="cart-table-wrapper" style="box-shadow: 0 4px 15px rgba(0,0,0,0.05); border-radius: 12px; overflow: hidden; border: 1px solid #eaeaea; margin-bottom: 25px;">
                    <table class="cart-table" style="margin-bottom: 0; box-shadow: none;">
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
                                    <td style="font-weight: bold; color: var(--color-muted);">#${p.codice}</td>
                                    <td><strong>Campo ${p.campoId}</strong></td>
                                    <td>
                                        <span style="display: block; color: var(--color-dark); font-weight: 600;"><fmt:formatDate value="${p.data}" pattern="dd/MM/yyyy" /></span>
                                        <span class="product-type" style="margin-top: 4px;"><fmt:formatDate value="${p.fasciaOraria}" pattern="HH:mm" /></span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>

            <c:when test="${tipoStorico != 'campi' && not empty ordiniPagina}">
                <c:forEach items="${ordiniPagina}" var="ordine">
                    <div style="background: #fff; border-radius: 10px; border: 1px solid #eaeaea; box-shadow: 0 4px 10px rgba(0,0,0,0.03); margin-bottom: 25px; padding: 20px;">
                        <div style="display: flex; justify-content: space-between; border-bottom: 1px solid #eee; padding-bottom: 10px; margin-bottom: 15px;">
                            <div>
                                <strong style="color: var(--color-primary); font-size: 18px;">Ordine #${ordine.codice}</strong><br>
                                <span style="color: var(--color-muted); font-size: 14px;"><fmt:formatDate value="${ordine.data}" pattern="dd/MM/yyyy HH:mm"/></span>
                            </div>
                            <div>
                                <span class="product-type" style="background-color: var(--color-accent); color: white; border: none;">${ordine.stato}</span>
                            </div>
                        </div>
                        <table class="cart-table" style="margin: 0; box-shadow: none; border: 1px solid #eee;">
                            <thead style="background-color: #f9f9f9; color: var(--color-dark);">
                                <tr>
                                    <th>Prodotto</th>
                                    <th>Prezzo Unitario</th>
                                    <th>Quantità</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${ordine.righe}" var="riga">
                                    <c:if test="${(tipoStorico == 'noleggi' && riga.tipoProdotto.toLowerCase() == 'arma') || (tipoStorico == 'acquisti' && riga.tipoProdotto.toLowerCase() == 'munizione')}">
                                        <tr>
                                            <td>
                                                <strong>${riga.idProdotto}</strong><br>
                                                <span class="product-type">${riga.tipoProdotto}</span>
                                                <c:if test="${riga.durata > 0}">
                                                    <br><small style="color: var(--color-muted);">${riga.durata} ore</small>
                                                </c:if>
                                            </td>
                                            <td>€ <fmt:formatNumber value="${riga.prezzo}" minFractionDigits="2" /></td>
                                            <td style="font-weight: bold;">x${riga.quantita}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:forEach>
            </c:when>
            
            <c:otherwise>
                <p style="color: var(--color-muted); font-style: italic; background: #fff; padding: 30px; border-radius: 10px; border: 1px dashed #ccc; text-align: center;">Nessun risultato trovato per questa categoria.</p>
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
                
                <span style="display: flex; align-items: center; font-weight: bold; color: var(--color-muted);">Pagina ${currentPage} di ${totalPages}</span>
                
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
