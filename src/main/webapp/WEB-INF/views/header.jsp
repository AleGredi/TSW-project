<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header class="header">
    <a href="${pageContext.request.contextPath}/home" style="text-decoration: none; color: inherit;">
        <h1 style="letter-spacing: 2px; text-transform: uppercase;">SkeetPro</h1>
    </a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/catalogo">Catalogo</a>
        <a href="${pageContext.request.contextPath}/carrello">
            Carrello
            <c:if test="${not empty sessionScope.carrello and sessionScope.carrello.numeroArticoli > 0}">
                <span style="background-color: var(--color-accent); color: white; padding: 2px 6px; border-radius: 12px; font-size: 11px; margin-left: 5px;">
                    ${sessionScope.carrello.numeroArticoli}
                </span>
            </c:if>
        </a>
        
        <c:choose>
            <c:when test="${not empty sessionScope.utente}">
                <a href="${pageContext.request.contextPath}/profilo">Area Personale</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login">Login</a>
                <a href="${pageContext.request.contextPath}/registrazione">Registrati</a>
            </c:otherwise>
        </c:choose>
    </div>
</header>
