<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - SkeetPro</title>
    
    <!-- Per ora metto il CSS interno per semplicità didattica, poi potremmo spostarlo in un file main.css in static/css -->
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-box {
            background-color: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 320px;
        }
        .login-box h2 {
            text-align: center;
            color: #333;
            margin-top: 0;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-size: 14px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box; /* Evita che il padding faccia sbordare l'input */
        }
        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #0056b3;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background-color: #004494;
        }
        .error-message {
            background-color: #ffe6e6;
            color: #d93025;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>

    <div class="login-box">
        <h2>SkeetPro</h2>
        
        <%-- Se c'è un errore nella request (messo dalla Servlet), lo stampo qui tramite JSTL e Expression Language --%>
        <c:if test="${not empty errore}">
            <div class="error-message">
                ${errore}
            </div>
        </c:if>

        <%-- Form con metodo POST diretto verso l'URL della LoginServlet. 
             Uso pageContext.request.contextPath per generare URL sicuri e indipendenti dal nome dell'applicazione --%>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <!-- type="email" fa una validazione automatica di base lato HTML5 -->
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
