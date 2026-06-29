<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - SkeetPro</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">
</head>
<body class="auth-page">

    <div class="login-box">
        <h2>SkeetPro</h2>
        
        <%-- Se c'è un errore nella request (messo dalla Servlet), lo stampo qui tramite JSTL e Expression Language --%>
        <c:if test="${not empty errore}">
            <div class="error-message">
                ${errore}
            </div>
        </c:if>
        
        <%-- Mostro il messaggio di successo se arrivo dalla registrazione --%>
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="success-message">
                ${sessionScope.successMessage}
            </div>
            <%-- Rimuovo il messaggio dalla sessione dopo averlo mostrato --%>
            <c:remove var="successMessage" scope="session" />
        </c:if>

        <%-- Form con metodo POST diretto verso l'URL della LoginServlet. --%>
        <form action="${pageContext.request.contextPath}/login" method="post">
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

</body>
</html>
