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
        <h2>SkeetPro</h2>
        
        <c:if test="${not empty errore}">
            <div class="error-message">
                ${errore}
            </div>
        </c:if>
        
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="success-message">
                ${sessionScope.successMessage}
            </div>
            <c:remove var="successMessage" scope="session" />
        </c:if>

        <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="es. mario.rossi@email.it" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn-submit">Accedi</button>
        </form>
    </div>
    
    <script src="${pageContext.request.contextPath}/scripts/validazione.js"></script>
</body>
</html>
