<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Munizioni - SkeetPro Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <style>
        .admin-layout { display: flex; min-height: 100vh; }
        .admin-sidebar { width: 250px; background-color: var(--color-primary); color: white; padding: 20px 0; }
        .admin-sidebar h2 { text-align: center; color: var(--color-accent); border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 20px; margin-bottom: 20px; }
        .admin-sidebar ul { list-style: none; padding: 0; margin: 0; }
        .admin-sidebar ul li a { display: block; padding: 15px 25px; color: white; text-decoration: none; transition: background 0.3s; }
        .admin-sidebar ul li a:hover, .admin-sidebar ul li a.active { background-color: rgba(255,255,255,0.1); border-left: 4px solid var(--color-accent); }
        .admin-main { flex: 1; background-color: #f4f7f6; padding: 30px; }
        .admin-header { display: flex; justify-content: space-between; align-items: center; background: white; padding: 15px 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 30px; }
        .admin-card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: var(--color-surface); color: var(--color-primary); }
        .status-badge { padding: 5px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; color: white; }
        .status-active { background-color: #28a745; }
        .status-inactive { background-color: #dc3545; }
        .action-btn { border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 13px; color: white; }
        .btn-edit { background-color: #ffc107; color: #333; }
        .btn-delete { background-color: #dc3545; }
        .btn-activate { background-color: #28a745; }
        .form-row { display: flex; gap: 15px; margin-bottom: 15px; }
        .form-row > div { flex: 1; }
        .form-row label { display: block; font-weight: bold; margin-bottom: 5px; font-size: 14px; }
        .form-row input, .form-row select, .form-row textarea { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
    </style>
</head>
<body style="margin: 0;">

    <div class="admin-layout">
        <aside class="admin-sidebar">
            <h2>🎯 SkeetPro Admin</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/utenti">👥 Utenti e Soci</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/armi">🔫 Armi</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/munizioni" class="active">📦 Munizioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/prenotazioni">📅 Prenotazioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/ordini">📦 Ordini</a></li>
            </ul>
        </aside>

        <main class="admin-main">
            <header class="admin-header">
                <h1 style="margin: 0; color: var(--color-dark); font-size: 24px;">Gestione Munizioni</h1>
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
                <h3>Aggiungi Nuove Munizioni</h3>
                <form action="${pageContext.request.contextPath}/admin/munizioni" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="form-row">
                        <div><label>Lotto (Codice Univoco)</label><input type="text" name="lotto" required></div>
                        <div><label>Marca</label><input type="text" name="marca" required></div>
                        <div><label>Calibro</label><input type="text" name="calibro" required></div>
                    </div>
                    <div class="form-row">
                        <div><label>Prezzo Scatola (€)</label><input type="number" step="0.01" name="prezzo" required></div>
                        <div style="flex: 2;"><label>Descrizione</label><input type="text" name="descrizione"></div>
                        <div style="display: flex; align-items: center; justify-content: center; gap: 10px;">
                            <input type="checkbox" name="attiva" id="attiva" checked style="width: auto;">
                            <label for="attiva" style="margin: 0; cursor: pointer;">Attiva nel Catalogo</label>
                        </div>
                    </div>
                    <button type="submit" style="background: var(--color-primary); color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; font-weight: bold;">Salva Munizione</button>
                </form>
            </div>

            <div class="admin-card">
                <h3>Elenco Munizioni</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Lotto</th>
                            <th>Marca</th>
                            <th>Calibro</th>
                            <th>Prezzo</th>
                            <th>Stato</th>
                            <th>Azioni</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="m" items="${munizioni}">
                            <tr>
                                <td><strong>${m.lotto}</strong></td>
                                <td>${m.marca}</td>
                                <td>${m.calibro}</td>
                                <td>€ ${m.prezzo}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${m.attiva}">
                                            <span class="status-badge status-active">ATTIVA</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">SOSPESA</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="display: flex; gap: 5px;">
                                    <c:choose>
                                        <c:when test="${m.attiva}">
                                            <form action="${pageContext.request.contextPath}/admin/munizioni" method="post" style="margin:0;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="lotto" value="${m.lotto}">
                                                <button type="submit" class="action-btn btn-delete" title="Nascondi (Soft Delete)">Disattiva</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/admin/munizioni" method="post" style="margin:0;">
                                                <input type="hidden" name="action" value="riattiva">
                                                <input type="hidden" name="lotto" value="${m.lotto}">
                                                <button type="submit" class="action-btn btn-activate">Riattiva</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </main>
    </div>

</body>
</html>
