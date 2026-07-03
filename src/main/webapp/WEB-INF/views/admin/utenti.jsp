<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Utenti - SkeetPro Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
</head>
<body>

    <div class="admin-layout">
        <aside class="admin-sidebar">
            <h2>🎯 SkeetPro Admin</h2>
            <ul>

                <li><a href="${pageContext.request.contextPath}/admin/utenti" class="active">👥 Utenti e Soci</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/armi">🔫 Armi</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/munizioni">📦 Munizioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/prenotazioni">📅 Prenotazioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/ordini">📦 Ordini</a></li>
            </ul>
        </aside>

        <main class="admin-main">
            <header class="admin-header">
                <h1 style="margin: 0; color: var(--color-dark); font-size: 24px;">Gestione Utenti e Soci</h1>
                <div>
                    <span style="margin-right: 15px; font-weight: bold; color: var(--color-primary);">Benvenuto, ${sessionScope.admin.username}</span>
                    <a href="${pageContext.request.contextPath}/admin/logout" class="btn-outline" style="padding: 8px 15px; font-size: 14px;">🚪 Logout</a>
                </div>
            </header>

            <c:if test="${not empty sessionScope.successMsg}">
                <div style="background-color: #d4edda; color: #155724; padding: 15px; border-radius: 4px; margin-bottom: 20px; border: 1px solid #c3e6cb;">
                    ${sessionScope.successMsg}
                </div>
                <c:remove var="successMsg" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div style="background-color: #f8d7da; color: #721c24; padding: 15px; border-radius: 4px; margin-bottom: 20px; border: 1px solid #f5c6cb;">
                    ${sessionScope.errorMsg}
                </div>
                <c:remove var="errorMsg" scope="session" />
            </c:if>

            <div class="admin-card">
                <h3>Elenco Clienti Registrati</h3>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Nome e Cognome</th>
                            <th>Codice Fiscale</th>
                            <th>Contatti</th>
                            <th>Tipo</th>
                            <th>Stato Socio</th>
                            <th>Licenza Porto Armi</th>
                            <th>Azioni</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${utenti}">
                            <tr>
                                <td><strong>${u.nome} ${u.cognome}</strong></td>
                                <td style="font-family: monospace;">${u.cf}</td>
                                <td><a href="mailto:${u.email}">${u.email}</a></td>
                                
                                <td>
                                    <c:choose>
                                        <c:when test="${u.tipoCliente == 'Socio'}">
                                            <span style="font-weight: bold; color: var(--color-accent);">Socio</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #666;">Temporaneo</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                
                                <td>
                                    <c:if test="${u.tipoCliente == 'Socio'}">
                                        <c:choose>
                                            <c:when test="${u.statoSocio == 'Attivo'}">
                                                <span class="status-badge status-active">ATTIVO</span>
                                            </c:when>
                                            <c:when test="${u.statoSocio == 'Sospeso'}">
                                                <span class="status-badge status-suspended">SOSPESO</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-expired">SCADUTO</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <div style="font-size: 11px; margin-top: 4px;">Tessera: ${u.nTessera}</div>
                                    </c:if>
                                    <c:if test="${u.tipoCliente != 'Socio'}">
                                        <span class="status-badge status-temp">N/A</span>
                                    </c:if>
                                </td>
                                
                                <td>
                                    <c:if test="${u.tipoCliente == 'Socio'}">
                                        <c:if test="${not empty u.numLicenza}">
                                            <strong>${u.numLicenza}</strong> <br>
                                            Scad: <span style="font-family: monospace;">${u.scadenzaPortoArmiFormatted}</span>
                                            
                                            <c:if test="${u.portoArmiScaduto}">
                                                <br><span class="alert-badge alert-danger" style="margin: 3px 0; display: inline-block;">! SCADUTO !</span>
                                            </c:if>
                                            <c:if test="${u.portoArmiInScadenza}">
                                                <br><span class="alert-badge alert-warning" style="margin: 3px 0; display: inline-block;">Scade tra meno di 30 gg</span>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${empty u.numLicenza}">
                                            <span style="color: #999; display: block; margin-bottom: 5px;"><i>Nessuna licenza</i></span>
                                        </c:if>
                                        
                                        <form action="${pageContext.request.contextPath}/admin/utenti" method="post" style="margin-top: 8px; display: flex; flex-direction: column; gap: 4px; background: #f9f9f9; padding: 5px; border-radius: 4px; border: 1px solid #ddd;">
                                            <input type="hidden" name="action" value="aggiornaPortoArmi">
                                            <input type="hidden" name="cf" value="${u.cf}">
                                            <input type="text" name="numLicenza" placeholder="N. Licenza" value="${u.numLicenza}" style="padding: 4px; font-size: 11px; border: 1px solid #ccc; border-radius: 3px;" required>
                                            <input type="date" name="scadenza" value="${u.scadenzaPortoArmi}" style="padding: 4px; font-size: 11px; border: 1px solid #ccc; border-radius: 3px;" required>
                                            <button type="submit" class="action-btn" style="background-color: var(--color-primary); padding: 4px; font-size: 11px; width: 100%;">Salva/Aggiorna</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${u.tipoCliente != 'Socio'}">
                                        <span style="color: #999;"><i>Non applicabile</i></span>
                                    </c:if>
                                </td>
                                
                                <td>
                                    <c:if test="${u.tipoCliente == 'Socio'}">
                                        <c:choose>
                                            <c:when test="${u.statoSocio == 'Attivo'}">
                                                <form action="${pageContext.request.contextPath}/admin/utenti" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="cambiaStato">
                                                    <input type="hidden" name="cf" value="${u.cf}">
                                                    <input type="hidden" name="stato" value="Sospeso">
                                                    <button type="submit" class="action-btn btn-suspend">Sospendi</button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <form action="${pageContext.request.contextPath}/admin/utenti" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="cambiaStato">
                                                    <input type="hidden" name="cf" value="${u.cf}">
                                                    <input type="hidden" name="stato" value="Attivo">
                                                    <button type="submit" class="action-btn btn-activate">Attiva</button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </main>
    </div>

</body>
</html>
