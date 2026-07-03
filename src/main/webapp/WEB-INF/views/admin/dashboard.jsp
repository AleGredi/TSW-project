<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin - SkeetPro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
</head>
<body>

    <div class="admin-layout">
        <aside class="admin-sidebar">
            <h2>🎯 SkeetPro Admin</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">📊 Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/utenti">👥 Utenti e Soci</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/armi">🔫 Armi</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/munizioni">📦 Munizioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/prenotazioni">📅 Prenotazioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/ordini">📦 Ordini</a></li>
            </ul>
        </aside>

        <main class="admin-main">
            <header class="admin-header">
                <h1 style="margin: 0; color: var(--color-dark); font-size: 24px;">Dashboard Generale</h1>
                <div>
                    <span style="margin-right: 15px; font-weight: bold; color: var(--color-primary);">Benvenuto, ${sessionScope.admin.username}</span>
                    <a href="${pageContext.request.contextPath}/admin/logout" class="btn-outline" style="padding: 8px 15px; font-size: 14px;">🚪 Logout</a>
                </div>
            </header>

            <div class="admin-card">
                <h3>Benvenuto nel Pannello di Controllo</h3>
                <p>Usa il menu laterale per gestire le diverse entità del circolo di tiro a volo.</p>
                <p style="color: var(--color-muted); margin-top: 20px;"><em>(Funzionalità in fase di sviluppo...)</em></p>
            </div>
        </main>
    </div>

</body>
</html>
