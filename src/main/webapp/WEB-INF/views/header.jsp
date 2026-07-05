<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header class="header">
    <a href="${pageContext.request.contextPath}/home" class="custom-element-30">
        <h1 class="letter-spacing-2-custom-element-13">SkeetPro</h1>
    </a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/catalogo">Catalogo</a>
        <a href="${pageContext.request.contextPath}/campi">Campi</a>
        <a href="${pageContext.request.contextPath}/carrello">
            Carrello
            <c:if test="${not empty sessionScope.carrello and sessionScope.carrello.numeroArticoli > 0}">
                <span class="custom-element-32">
                    ${sessionScope.carrello.numeroArticoli}
                </span>
            </c:if>
        </a>
        
        <c:choose>
            <c:when test="${not empty sessionScope.utente}">
                <a href="${pageContext.request.contextPath}/profilo">Area Personale</a>
                <a href="${pageContext.request.contextPath}/logout">Logout (${sessionScope.utente.nome})</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login">Login</a>
                <a href="${pageContext.request.contextPath}/registrazione">Registrati</a>
            </c:otherwise>
        </c:choose>
    </div>
</header>
