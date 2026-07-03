<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkeetPro - Il Tiro a Volo Digitale</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/home.css">
</head>
<body class="home-page">

    <jsp:include page="header.jsp" />

    <main class="dashboard">
        <c:if test="${not empty sessionScope.successMessage}">
            <div style="color: #fff; background-color: var(--color-primary); padding: 15px; border-radius: 8px; margin-bottom: 25px; font-weight: bold; text-align: center; box-shadow: 0 4px 10px rgba(0,0,0,0.1);">
                ${sessionScope.successMessage}
            </div>
            <c:remove var="successMessage" scope="session" />
        </c:if>

    <section class="hero">
        <c:choose>
            <c:when test="${not empty sessionScope.utente}">
                <h1>Bentornato, ${sessionScope.utente.nome}</h1>
                <p class="hero-subtitle" style="font-family: 'EB Garamond', serif; font-style: italic; font-size: 26px; margin-bottom: 40px; font-weight: 400; color: #d1d8cc;">Esplora il catalogo esclusivo per te che sei <strong style="color:var(--color-accent);">${sessionScope.utente.tipoCliente}</strong>.</p>
                <div class="hero-buttons">
                    <a href="${pageContext.request.contextPath}/campi" class="btn-hero">Prenota un Campo</a>
                    <a href="${pageContext.request.contextPath}/profilo" class="btn-hero-outline">La mia Dashboard</a>
                </div>
            </c:when>
            <c:otherwise>
                <h1>L'eccellenza nel tiro</h1>
                <p class="hero-subtitle" style="font-family: 'EB Garamond', serif; font-style: italic; font-size: 26px; margin-bottom: 40px; font-weight: 400;">La tua passione per il tiro a volo, con la qualità di sempre.</p>
                <div style="margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/registrazione" class="btn">Diventa Socio</a>
                    <a href="${pageContext.request.contextPath}/catalogo" class="btn-outline" style="color: white; border-color: white; margin-left: 15px;">Esplora Catalogo</a>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <div class="features-container">
        <div class="features-grid">
            <a href="${pageContext.request.contextPath}/campi" class="feature-card">
                <span class="feature-icon">🎯</span>
                <h3>Campi all'Avanguardia</h3>
                <p>Strutture moderne per Fossa Olimpica, Skeet e Sporting. Prenota la tua fascia oraria senza attese ed entra subito in pedana.</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/catalogo" class="feature-card">
                <span class="feature-icon">🔫</span>
                <h3>Armeria Esclusiva</h3>
                <p>Un catalogo di armi da noleggiare e munizioni da acquistare, riservato ai nostri Soci con porto d'armi. Sicurezza e altissima qualità.</p>
            </a>

            <a href="${pageContext.request.contextPath}/profilo" class="feature-card">
                <span class="feature-icon">📊</span>
                <h3>Tutto sotto Controllo</h3>
                <p>La tua dashboard personale per tracciare lo storico delle tue prenotazioni, i tuoi ordini e verificare la validità dei tuoi documenti.</p>
            </a>
        </div>
    </div>

    <section class="about-section">
        <h2>Perché scegliere SkeetPro?</h2>
        <div style="display: flex; justify-content: center; gap: 40px; max-width: 1100px; margin: 40px auto 0; flex-wrap: wrap;">
            <div class="feature-box" style="flex: 1; min-width: 280px; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.3);">
                <h4 style="font-size: 20px; margin-bottom: 15px;">🕒 Prenotazioni H24</h4>
                <p style="font-size: 16px; margin: 0; line-height: 1.6;">Il nostro sistema è sempre online. Assicurati il tuo slot preferito in pedana in qualsiasi momento, senza dover aspettare gli orari di apertura della segreteria.</p>
            </div>
            <div class="feature-box" style="flex: 1; min-width: 280px; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.3);">
                <h4 style="font-size: 20px; margin-bottom: 15px;">🏆 Strutture Professionali</h4>
                <p style="font-size: 16px; margin: 0; line-height: 1.6;">Campi omologati per Fossa Olimpica e Skeet. Macchine lanciapiattelli di ultima generazione, manutenute con cura per garantirti un'esperienza di tiro perfetta.</p>
            </div>
            <div class="feature-box" style="flex: 1; min-width: 280px; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.3);">
                <h4 style="font-size: 20px; margin-bottom: 15px;">🤝 La Nostra Community</h4>
                <p style="font-size: 16px; margin: 0; line-height: 1.6;">Unisciti ai nostri Soci! Accedi al noleggio di armi esclusive, partecipa alle gare ufficiali del circolo, scala le classifiche e vivi a pieno la competizione.</p>
            </div>
        </div>
    </section>

</body>
</html>
