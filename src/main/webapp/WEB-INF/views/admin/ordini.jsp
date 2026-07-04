<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Ordini - SkeetPro Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
</head>
<body>

    <div class="admin-layout">
        <aside class="admin-sidebar">
            <h2>SkeetPro Admin</h2>
            <ul>

                <li><a href="${pageContext.request.contextPath}/admin/utenti">Utenti e Soci</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/armi">Armi</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/munizioni">Munizioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/prenotazioni">Prenotazioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/ordini" class="active">Ordini</a></li>
            </ul>
        </aside>

        <main class="admin-main">
            <header class="admin-header">
                <h1 class="admin-page-title">Storico Ordini (Noleggi e Munizioni)</h1>
                <div>
                    <span class="admin-welcome-text">Benvenuto, ${sessionScope.admin.username}</span>
                    <a href="${pageContext.request.contextPath}/admin/logout" class="btn-outline admin-logout-btn">Logout</a>
                </div>
            </header>

            <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert-success">
                    ${sessionScope.successMsg}
                </div>
                <c:remove var="successMsg" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div class="alert-error">
                    ${sessionScope.errorMsg}
                </div>
                <c:remove var="errorMsg" scope="session" />
            </c:if>

            <div class="admin-card">
                <h3>Elenco Ordini Effettuati</h3>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>N. Ordine</th>
                            <th>Data Acquisto</th>
                            <th>Cliente</th>
                            <th>Totale Pagato</th>
                            <th>Stato Ritiro</th>
                            <th>Azioni</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="o" items="${ordini}">
                            <tr>
                                <td><strong class="order-id">#${o.codice}</strong></td>
                                <td><fmt:formatDate value="${o.data}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>${o.clienteNome} ${o.clienteCognome}<br><span class="text-cf">${o.clienteCF}</span></td>
                                <td class="text-price">
                                    € <fmt:formatNumber value="${o.totale}" pattern="0.00"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${o.stato == 'Da Ritirare'}">
                                            <span class="status-badge status-suspended">DA RITIRARE</span>
                                        </c:when>
                                        <c:when test="${o.stato == 'Ritirato'}">
                                            <span class="status-badge status-active">RITIRATO</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">ANNULLATO</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${o.stato == 'Da Ritirare'}">
                                        <form action="${pageContext.request.contextPath}/admin/ordini" method="post" class="form-inline-block">
                                            <input type="hidden" name="action" value="cambiaStato">
                                            <input type="hidden" name="codice" value="${o.codice}">
                                            <input type="hidden" name="stato" value="Ritirato">
                                            <button type="submit" class="action-btn btn-activate">Segna Ritirato</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin/ordini" method="post" class="form-inline-block">
                                            <input type="hidden" name="action" value="cambiaStato">
                                            <input type="hidden" name="codice" value="${o.codice}">
                                            <input type="hidden" name="stato" value="Annullato">
                                            <button type="submit" class="action-btn btn-delete">Annulla</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty ordini}">
                            <tr>
                                <td colspan="6" class="text-empty-table">Nessun ordine trovato nello storico.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

        </main>
    </div>

</body>
</html>
