<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>I Nostri Campi - SkeetPro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/campi.css">
</head>
<body class="home-page">

    <jsp:include page="header.jsp" />

    <main class="catalogo-container">
        
        <section class="catalogo-section">
            <h2 class="custom-element-13">I NOSTRI CAMPI DI TIRO</h2>
            <p class="fs-18-highlight-text-47-mb-40-max-w-800">
                SkeetPro offre impianti all'avanguardia per tutte le principali discipline di Tiro a Volo.
                Scopri le nostre pedane e prenota la tua sessione.
            </p>
            
            <div class="cards-grid">
                <c:choose>
                    <c:when test="${empty campi}">
                        <p>Nessun campo disponibile al momento.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="campo" items="${campi}">
                            <div class="product-card">
                                <img class="card-img" src="${pageContext.request.contextPath}/images/campo_${campo.disciplina.toLowerCase()}.jpg" alt="${campo.disciplina}" onerror="this.onerror=null; this.src='https://via.placeholder.com/400x200.png?text=Campo+SkeetPro';">
                                <div class="card-body">
                                    <h3 class="custom-element-13-font-family-EB-Garamond-serif">Campo ${campo.id} - ${campo.disciplina}</h3>
                                    <p class="card-desc">
                                        <c:choose>
                                            <c:when test="${campo.disciplina == 'Trap'}">
                                                Pedana olimpica per il Trap (Fossa Olimpica). Perfetta per allenamenti professionali e gare.
                                            </c:when>
                                            <c:when test="${campo.disciplina == 'Skeet'}">
                                                Impianto dedicato allo Skeet con torri alta e bassa perfettamente tarate.
                                            </c:when>
                                            <c:otherwise>
                                                Percorso di caccia / Sporting con macchine lanciapiattelli multiple per simulare ogni tipo di volo.
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <div class="card-footer">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.utente}">
                                                <a href="${pageContext.request.contextPath}/campi?campoId=${campo.id}#form-prenotazione" class="btn-add-cart">PRENOTA SUBITO</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/login" class="btn-disabled">ACCEDI PER PRENOTARE</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <c:if test="${not empty sessionScope.utente}">
            <hr class="custom-element-53">
            
            <section class="catalogo-section" id="form-prenotazione" class="layout-wrapper-19-spacing-element-18-auto">
                
                <c:if test="${not empty errore}">
                    <div class="error-message">${errore}</div>
                </c:if>
                <c:if test="${not empty sessionScope.messaggioSuccesso}">
                    <div class="success-message">${sessionScope.messaggioSuccesso}</div>
                    <c:remove var="messaggioSuccesso" scope="session" />
                </c:if>

                <div class="flex-container-55">
                    <div class="flex-container-56">
                        <h2 class="custom-element-57">PRENOTA LA TUA PEDANA</h2>
                        
                        <form action="${pageContext.request.contextPath}/campi" method="post" class="custom-element-58">
                            <div class="form-group">
                                <label for="campoId">Seleziona Campo / Disciplina:</label>
                                <select name="campoId" id="campoId" required>
                                    <option value="">-- Seleziona --</option>
                                    <c:forEach items="${campi}" var="c">
                                        <option value="${c.id}" ${param.campoId == c.id ? 'selected' : ''}>Campo ${c.id} - ${c.disciplina}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="data">Data della prenotazione:</label>
                                <input type="date" name="data" id="data" required>
                            </div>

                            <div class="form-group">
                                <label for="fasciaOraria">Fascia Oraria (1 ora):</label>
                                <select name="fasciaOraria" id="fasciaOraria" required>
                                    <option value="">-- Seleziona --</option>
                                    <option value="09:00">09:00 - 10:00</option>
                                    <option value="10:00">10:00 - 11:00</option>
                                    <option value="11:00">11:00 - 12:00</option>
                                    <option value="14:00">14:00 - 15:00</option>
                                    <option value="15:00">15:00 - 16:00</option>
                                    <option value="16:00">16:00 - 17:00</option>
                                </select>
                                <div id="slot-status" class="custom-element-59">Seleziona i campi per verificare la disponibilità.</div>
                            </div>

                            <button type="submit" id="btn-prenota" class="btn-submit custom-element-60" disabled>CONFERMA PRENOTAZIONE</button>
                        </form>
                </div>
            </section>
        </c:if>

    </main>

    <script src="${pageContext.request.contextPath}/scripts/prenotazioni.js"></script>
</body>
</html>
