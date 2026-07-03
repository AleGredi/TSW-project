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
<body style="margin: 0;">

    <div class="admin-layout">
        <aside class="admin-sidebar">
            <h2>🎯 SkeetPro Admin</h2>
            <ul>

                <li><a href="${pageContext.request.contextPath}/admin/utenti">👥 Utenti e Soci</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/armi">🔫 Armi</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/munizioni">📦 Munizioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/prenotazioni">📅 Prenotazioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/ordini" class="active">📦 Ordini</a></li>
            </ul>
        </aside>

        <main class="admin-main">
            <header class="admin-header">
                <h1 style="margin: 0; color: var(--color-dark); font-size: 24px;">Storico Ordini (Noleggi e Munizioni)</h1>
                <div>
                    <span style="margin-right: 15px; font-weight: bold; color: var(--color-primary);">Benvenuto, ${sessionScope.admin.username}</span>
                    <a href="${pageContext.request.contextPath}/admin/logout" class="btn-outline" style="padding: 8px 15px; font-size: 14px;">🚪 Logout</a>
                </div>
            </header>

            <c:if test="${not empty sessionScope.successMsg}">
                <div style="background-color: #d4edda; color: #155724; padding: 15px; border-radius: 4px; margin-bottom: 20px; border: 1px solid #c3e6cb;">
                    ${sessionScope.successMsg}
                </div>
                <c:remove var="successMsg" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div style="background-color: #f8d7da; color: #721c24; padding: 15px; border-radius: 4px; margin-bottom: 20px; border: 1px solid #f5c6cb;">
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
                                <td><strong style="font-size: 18px;">#${o.codice}</strong></td>
                                <td><fmt:formatDate value="${o.data}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>${o.clienteNome} ${o.clienteCognome}<br><span style="font-size: 11px; color: #666; font-family: monospace;">${o.clienteCF}</span></td>
                                <td style="font-weight: bold; color: var(--color-primary);">
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
                                        <form action="${pageContext.request.contextPath}/admin/ordini" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="cambiaStato">
                                            <input type="hidden" name="codice" value="${o.codice}">
                                            <input type="hidden" name="stato" value="Ritirato">
                                            <button type="submit" class="action-btn btn-activate">Segna Ritirato</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin/ordini" method="post" style="display:inline;">
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
                                <td colspan="6" style="text-align: center; color: #888;">Nessun ordine trovato nello storico.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

        </main>
    </div>

</body>
</html>
