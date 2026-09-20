<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkeetPro - Admin Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
</head>
<body class="admin-login-wrapper">
    <div class="admin-login-container">
        <h1>SkeetPro <span>Admin</span></h1>
        
        <c:if test="${not empty errore}">
            <div class="admin-error">${errore}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <input type="text" name="username" placeholder="Username" required autofocus>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Accedi al Pannello</button>
        </form>
        <p class="admin-login-footer"><a href="${pageContext.request.contextPath}/home">Torna al sito principale</a></p>
    </div>
</body>
</html>
