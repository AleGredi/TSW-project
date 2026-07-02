<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin - SkeetPro</title>
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
        .admin-card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
    </style>
</head>
<body style="margin: 0;">

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
