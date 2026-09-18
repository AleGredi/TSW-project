<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header class="header" data-context-path="${pageContext.request.contextPath}">
    <a href="${pageContext.request.contextPath}/home" class="logo">
        <h1>SkeetPro</h1>
    </a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/catalogo">Catalogo</a>
        <a href="${pageContext.request.contextPath}/campi">Campi</a>
        <a href="${pageContext.request.contextPath}/carrello">
            Carrello
            <c:if test="${not empty sessionScope.carrello and sessionScope.carrello.numeroArticoli > 0}">
                <span class="cart-badge" id="cart-counter">
                    ${sessionScope.carrello.numeroArticoli}
                </span>
            </c:if>
        </a>
        
        <c:choose>
            <c:when test="${not empty sessionScope.admin}">
                <a href="${pageContext.request.contextPath}/admin/utenti">Pannello Admin</a>
                <a href="${pageContext.request.contextPath}/admin/logout">Logout (${sessionScope.admin.username})</a>
            </c:when>
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
