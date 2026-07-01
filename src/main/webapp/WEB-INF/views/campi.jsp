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
    <style>
        .catalogo-container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        .catalogo-section { margin-bottom: 60px; }
        .catalogo-section h2 { color: var(--color-primary); font-size: 32px; border-bottom: 3px solid var(--color-accent); padding-bottom: 10px; margin-bottom: 30px; display: inline-block; }
        .cards-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 30px; }
        .product-card { background-color: var(--color-surface); border: 1px solid #e8e8e8; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: transform 0.3s ease, box-shadow 0.3s ease; display: flex; flex-direction: column; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .card-img { height: 200px; width: 100%; object-fit: cover; background-color: #eee; border-bottom: 1px solid #f0f0f0; }
        .card-body { padding: 20px; display: flex; flex-direction: column; flex-grow: 1; }
        .card-body h3 { margin: 0 0 10px 0; color: var(--color-dark); font-size: 24px; }
        .card-desc { color: var(--color-muted); font-size: 15px; line-height: 1.5; flex-grow: 1; margin-bottom: 20px; }
        .card-footer { display: flex; justify-content: center; align-items: center; border-top: 1px solid #e8e8e8; padding-top: 15px; margin-top: auto; }
        .btn-add-cart { background-color: var(--color-accent); color: white; border: none; padding: 12px 20px; border-radius: 6px; font-weight: bold; cursor: pointer; text-decoration: none; transition: all 0.2s ease; width: 100%; text-align: center; }
        .btn-add-cart:hover { background-color: var(--color-accent-lt); transform: scale(1.02); }
        .btn-disabled { background-color: #ccc; color: #fff; border: none; padding: 12px 20px; border-radius: 6px; font-weight: bold; width: 100%; text-align: center; display: inline-block; text-decoration: none; cursor: not-allowed; }
    </style>
</head>
<body class="home-page">

    <jsp:include page="header.jsp" />

    <main class="catalogo-container">
        
        <section class="catalogo-section">
            <h2>🌳 I Nostri Campi di Tiro</h2>
            <p style="font-size: 18px; color: var(--color-muted); margin-bottom: 40px; max-width: 800px;">
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
                                <!-- L'immagine dipende dalla disciplina -->
                                <img class="card-img" src="${pageContext.request.contextPath}/images/campo_${campo.disciplina.toLowerCase()}.jpg" alt="${campo.disciplina}" onerror="this.onerror=null; this.src='https://via.placeholder.com/400x200.png?text=Campo+SkeetPro';">
                                <div class="card-body">
                                    <h3>Campo ${campo.id} - ${campo.disciplina}</h3>
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
                                                <a href="${pageContext.request.contextPath}/campi?campoId=${campo.id}#form-prenotazione" class="btn-add-cart">📅 Prenota Subito</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/login" class="btn-disabled">🔒 Accedi per Prenotare</a>
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
            <hr style="margin: 60px 0; border: 0; border-top: 1px solid #eaeaea;">
            
            <section class="catalogo-section" id="form-prenotazione" style="max-width: 1200px; margin: 0 auto;">
                
                <c:if test="${not empty errore}">
                    <div style="color: #fff; background-color: var(--color-accent); padding: 10px; border-radius: 5px; margin-bottom: 20px; text-align: center;">${errore}</div>
                </c:if>
                <c:if test="${not empty sessionScope.messaggioSuccesso}">
                    <div style="color: #fff; background-color: var(--color-primary); padding: 10px; border-radius: 5px; margin-bottom: 20px; font-weight: bold; text-align: center;">${sessionScope.messaggioSuccesso}</div>
                    <c:remove var="messaggioSuccesso" scope="session" />
                </c:if>

                <div style="display: flex; gap: 40px; flex-wrap: wrap;">
                    <!-- Colonna di Sinistra: Form -->
                    <div style="flex: 1; min-width: 300px;">
                        <h2 style="margin-bottom: 20px; border-bottom: 2px solid var(--color-accent); padding-bottom: 10px; display: inline-block;">📅 Prenota la tua Pedana</h2>
                        
                        <form action="${pageContext.request.contextPath}/campi" method="post" style="background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #eaeaea;">
                            <div style="margin-bottom: 20px;">
                                <label for="campoId" style="display: block; margin-bottom: 8px; font-weight: bold; color: var(--color-primary);">Seleziona Campo / Disciplina:</label>
                                <select name="campoId" id="campoId" required style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px; font-size: 16px;">
                                    <option value="">-- Seleziona --</option>
                                    <c:forEach items="${campi}" var="c">
                                        <option value="${c.id}" ${param.campoId == c.id ? 'selected' : ''}>Campo ${c.id} - ${c.disciplina}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div style="margin-bottom: 20px;">
                                <label for="data" style="display: block; margin-bottom: 8px; font-weight: bold; color: var(--color-primary);">Data della prenotazione:</label>
                                <input type="date" name="data" id="data" required style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px; font-size: 16px;">
                            </div>

                            <div style="margin-bottom: 20px;">
                                <label for="fasciaOraria" style="display: block; margin-bottom: 8px; font-weight: bold; color: var(--color-primary);">Fascia Oraria (1 ora):</label>
                                <select name="fasciaOraria" id="fasciaOraria" required style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px; font-size: 16px;">
                                    <option value="">-- Seleziona --</option>
                                    <option value="09:00">09:00 - 10:00</option>
                                    <option value="10:00">10:00 - 11:00</option>
                                    <option value="11:00">11:00 - 12:00</option>
                                    <option value="14:00">14:00 - 15:00</option>
                                    <option value="15:00">15:00 - 16:00</option>
                                    <option value="16:00">16:00 - 17:00</option>
                                </select>
                                <div id="slot-status" style="margin-top: 8px; font-weight: bold; font-size: 15px;">Seleziona i campi per verificare la disponibilità.</div>
                            </div>

                            <button type="submit" id="btn-prenota" style="background-color: var(--color-accent); color: white; padding: 14px 35px; border-radius: 8px; font-size: 18px; font-weight: bold; border: none; cursor: pointer; width: 100%; opacity: 0.5;" disabled>Conferma Prenotazione</button>
                        </form>
                    </div>

                    <!-- Colonna di Destra: Mie Prenotazioni -->
                    <div style="flex: 1; min-width: 300px;">
                        <h2 style="margin-bottom: 20px; border-bottom: 2px solid var(--color-accent); padding-bottom: 10px; display: inline-block;">📌 Le mie Prenotazioni</h2>
                        <c:choose>
                            <c:when test="${not empty miePrenotazioni}">
                                <div style="background: #fff; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #eaeaea;">
                                    <table style="width: 100%; border-collapse: collapse; text-align: left;">
                                        <thead style="background-color: var(--color-surface); color: var(--color-primary);">
                                            <tr>
                                                <th style="padding: 15px; border-bottom: 2px solid #ddd;">Codice</th>
                                                <th style="padding: 15px; border-bottom: 2px solid #ddd;">Campo</th>
                                                <th style="padding: 15px; border-bottom: 2px solid #ddd;">Data/Ora</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${miePrenotazioni}" var="p">
                                                <tr style="transition: background 0.2s;">
                                                    <td style="padding: 15px; border-bottom: 1px solid #eee;">#${p.codice}</td>
                                                    <td style="padding: 15px; border-bottom: 1px solid #eee; font-weight: bold;">Campo ${p.campoId}</td>
                                                    <td style="padding: 15px; border-bottom: 1px solid #eee;">
                                                        <fmt:formatDate value="${p.data}" pattern="dd/MM/yyyy" /><br>
                                                        <small style="color: var(--color-muted);"><fmt:formatDate value="${p.fasciaOraria}" pattern="HH:mm" /></small>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p style="color: var(--color-muted); font-style: italic; background: #fff; padding: 20px; border-radius: 10px; border: 1px dashed #ccc;">Non hai ancora effettuato nessuna prenotazione.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </section>
        </c:if>

    </main>

    <script src="${pageContext.request.contextPath}/scripts/prenotazioni.js"></script>
</body>
</html>
