<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - SkeetPro</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
</head>
<body class="auth-page">

    <div class="login-box">
        <h2 style="font-family: 'EB Garamond', serif; text-transform: uppercase;">ACCEDI</h2>
        
        <c:if test="${not empty errore}">
            <div class="error-message">
                ${errore}
            </div>
        </c:if>
        
        <c:if test="${not empty successMessage}">
            <div class="success-message">
                ${successMessage}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
            
            <div class="form-group">
                <label for="email">EMAIL</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="password">PASSWORD</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn-submit">LOGIN</button>
        </form>

        <p style="text-align: center; margin-top: 25px; font-size: 14px;">
            Non hai un account? <a href="${pageContext.request.contextPath}/registrazione" style="font-weight: bold; text-decoration: underline;">Registrati qui</a>
        </p>
    </div>
    
    <script src="${pageContext.request.contextPath}/scripts/validazione.js"></script>
</body>
</html>
