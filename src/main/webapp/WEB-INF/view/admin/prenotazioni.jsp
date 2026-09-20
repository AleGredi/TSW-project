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
<body>

    <div class="admin-layout">
        <aside class="admin-sidebar">
            <h2>SkeetPro Admin</h2>
            <ul>

                <li><a href="${pageContext.request.contextPath}/admin/utenti">Utenti e Soci</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/armi">Armi</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/munizioni">Munizioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/prenotazioni" class="active">Prenotazioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/ordini">Ordini</a></li>
            </ul>
        </aside>

        <main class="admin-main">
            <header class="admin-header">
                <h1 class="admin-page-title">Calendario Prenotazioni</h1>
                <div>
                    <span class="admin-welcome-text">Benvenuto, ${sessionScope.admin.username}</span>
                    <a href="${pageContext.request.contextPath}/admin/logout" class="btn-outline admin-logout-btn">Logout</a>
                </div>
            </header>

            <div class="admin-card admin-card-mb">
                <h3>Filtra Prenotazioni</h3>
                <form action="${pageContext.request.contextPath}/admin/prenotazioni" method="get" class="admin-filter-form">
                    <div class="admin-filter-field">
                        <label for="dataDa" class="admin-filter-label">Dalla data:</label>
                        <input type="date" id="dataDa" name="dataDa" value="${dataDa}" class="admin-filter-input">
                    </div>
                    <div class="admin-filter-field">
                        <label for="dataA" class="admin-filter-label">Alla data:</label>
                        <input type="date" id="dataA" name="dataA" value="${dataA}" class="admin-filter-input">
                    </div>
                    <div class="admin-filter-field-wide">
                        <label for="cliente" class="admin-filter-label">Cliente (CF, Nome o Cognome):</label>
                        <input type="text" id="cliente" name="cliente" value="${cliente}" placeholder="Es. Mario o RSSMRA..." class="admin-filter-input">
                    </div>
                    <div class="admin-filter-actions">
                        <button type="submit" class="btn-save admin-btn-filter">FILTRA</button>
                        <c:if test="${not empty dataDa or not empty dataA or not empty cliente}">
                            <a href="${pageContext.request.contextPath}/admin/prenotazioni" class="action-btn btn-suspend admin-btn-reset">RESET</a>
                        </c:if>
                    </div>
                </form>
            </div>

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
                                <td>${p.clienteNome} ${p.clienteCognome}<br><span class="user-cf">${p.clienteCF}</span></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/prenotazioni" method="post" class="form-inline">
                                        <input type="hidden" name="action" value="elimina">
                                        <input type="hidden" name="codice" value="${p.codice}">
                                        <button type="submit" class="action-btn btn-delete">Elimina</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty prenotazioni}">
                            <tr>
                                <td colspan="5" class="empty-cell">Nessuna prenotazione trovata.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

        </main>
    </div>

</body>
</html>
