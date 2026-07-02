<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkeetPro - Admin Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <style>
        body { background-color: #f4f7f6; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }
        .admin-login-container { background: #fff; padding: 40px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 100%; max-width: 400px; text-align: center; }
        .admin-login-container h1 { color: var(--color-primary); margin-bottom: 20px; font-size: 24px; }
        .admin-login-container h1 span { color: var(--color-accent); font-weight: bold; }
        .admin-login-container input { width: 100%; padding: 12px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 6px; font-size: 16px; box-sizing: border-box; }
        .admin-login-container button { width: 100%; padding: 12px; background-color: var(--color-accent); color: white; border: none; border-radius: 6px; font-size: 18px; font-weight: bold; cursor: pointer; transition: background 0.3s; }
        .admin-login-container button:hover { background-color: #e56d25; }
        .admin-error { background-color: #ffdddd; color: #d8000c; padding: 10px; border-radius: 5px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="admin-login-container">
        <h1>🎯 SkeetPro <span>Admin</span></h1>
        
        <c:if test="${not empty errore}">
            <div class="admin-error">${errore}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <input type="text" name="username" placeholder="Username" required autofocus>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Accedi al Pannello</button>
        </form>
        <p style="margin-top: 20px; font-size: 14px;"><a href="${pageContext.request.contextPath}/home" style="color: var(--color-primary); text-decoration: none;">Torna al sito principale</a></p>
    </div>
</body>
</html>
