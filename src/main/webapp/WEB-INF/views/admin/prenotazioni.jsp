<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Prenotazioni - SkeetPro Admin</title>
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
                <li><a href="${pageContext.request.contextPath}/admin/prenotazioni" class="active">📅 Prenotazioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/ordini">📦 Ordini</a></li>
            </ul>
        </aside>

        <main class="admin-main">
            <header class="admin-header">
                <h1 style="margin: 0; color: var(--color-dark); font-size: 24px;">Calendario Prenotazioni</h1>
                <div>
                    <span style="margin-right: 15px; font-weight: bold; color: var(--color-primary);">Benvenuto, ${sessionScope.admin.username}</span>
                    <a href="${pageContext.request.contextPath}/admin/logout" class="btn-outline" style="padding: 8px 15px; font-size: 14px;">🚪 Logout</a>
                </div>
            </header>

            <div class="admin-card">
                <h3>Elenco Prenotazioni Campi</h3>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Data</th>
                            <th>Fascia Oraria</th>
                            <th>Campo / Disciplina</th>
                            <th>Cliente</th>
                            <th>Azioni</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${prenotazioni}">
                            <tr>
                                <td><strong><fmt:formatDate value="${p.data}" pattern="dd/MM/yyyy"/></strong></td>
                                <td>${p.fasciaOraria}</td>
                                <td>Campo ${p.campoId} (${p.disciplina})</td>
                                <td>${p.clienteNome} ${p.clienteCognome}<br><span style="font-size: 11px; color: #666; font-family: monospace;">${p.clienteCF}</span></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/prenotazioni" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="elimina">
                                        <input type="hidden" name="codice" value="${p.codice}">
                                        <button type="submit" class="action-btn btn-delete">Elimina</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty prenotazioni}">
                            <tr>
                                <td colspan="5" style="text-align: center; color: #888;">Nessuna prenotazione trovata.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

        </main>
    </div>

</body>
</html>
