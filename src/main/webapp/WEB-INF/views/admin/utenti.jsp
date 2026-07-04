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
            <h2>SkeetPro Admin</h2>
            <ul>

                <li><a href="${pageContext.request.contextPath}/admin/utenti" class="active">Utenti e Soci</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/armi">Armi</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/munizioni">Munizioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/prenotazioni">Prenotazioni</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/ordini">Ordini</a></li>
            </ul>
        </aside>

        <main class="admin-main">
            <header class="admin-header">
                <h1 class="admin-page-title">Gestione Utenti e Soci</h1>
                <div>
                    <span class="admin-welcome-text">Benvenuto, ${sessionScope.admin.username}</span>
                    <a href="${pageContext.request.contextPath}/admin/logout" class="btn-outline admin-logout-btn">Logout</a>
                </div>
            </header>

            <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert-success">
                    ${sessionScope.successMsg}
                </div>
                <c:remove var="successMsg" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div class="alert-error">
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
                                <td class="text-monospace">${u.cf}</td>
                                <td><a href="mailto:${u.email}">${u.email}</a></td>
                                
                                <td>
                                    <c:choose>
                                        <c:when test="${u.tipoCliente == 'Socio'}">
                                            <span class="fw-bold-text-accent">Socio</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-666">Temporaneo</span>
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
                                        <div class="fs-11-mt-4">Tessera: ${u.nTessera}</div>
                                    </c:if>
                                    <c:if test="${u.tipoCliente != 'Socio'}">
                                        <span class="status-badge status-temp">N/A</span>
                                    </c:if>
                                </td>
                                
                                <td>
                                    <c:if test="${u.tipoCliente == 'Socio'}">
                                        <c:if test="${not empty u.numLicenza}">
                                            <strong>${u.numLicenza}</strong> <br>
                                            Scad: <span class="text-monospace">${u.scadenzaPortoArmiFormatted}</span>
                                            
                                            <c:if test="${u.portoArmiScaduto}">
                                                <br><span class="alert-badge alert-danger m-3-0-d-inline-block">! SCADUTO !</span>
                                            </c:if>
                                            <c:if test="${u.portoArmiInScadenza}">
                                                <br><span class="alert-badge alert-warning m-3-0-d-inline-block">Scade tra meno di 30 gg</span>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${empty u.numLicenza}">
                                            <span class="text-999-d-block-mb-5"><i>Nessuna licenza</i></span>
                                        </c:if>
                                        
                                        <form action="${pageContext.request.contextPath}/admin/utenti" method="post" class="mt-8-d-flex-flex-direction-column-gap-4-bg-f9f9f9-">
                                            <input type="hidden" name="action" value="aggiornaPortoArmi">
                                            <input type="hidden" name="cf" value="${u.cf}">
                                            <input type="text" name="numLicenza" placeholder="N. Licenza" value="${u.numLicenza}" class="p-4-fs-11-border-1-solid-ccc-rounded-3" required>
                                            <input type="date" name="scadenza" value="${u.scadenzaPortoArmi}" class="p-4-fs-11-border-1-solid-ccc-rounded-3" required>
                                            <button type="submit" class="action-btn bg-primary-p-4-fs-11-w-100pct">Salva/Aggiorna</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${u.tipoCliente != 'Socio'}">
                                        <span class="text-999"><i>Non applicabile</i></span>
                                    </c:if>
                                </td>
                                
                                <td>
                                    <c:if test="${u.tipoCliente == 'Socio'}">
                                        <c:choose>
                                            <c:when test="${u.statoSocio == 'Attivo'}">
                                                <form action="${pageContext.request.contextPath}/admin/utenti" method="post" class="form-inline-block">
                                                    <input type="hidden" name="action" value="cambiaStato">
                                                    <input type="hidden" name="cf" value="${u.cf}">
                                                    <input type="hidden" name="stato" value="Sospeso">
                                                    <button type="submit" class="action-btn btn-suspend">Sospendi</button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <form action="${pageContext.request.contextPath}/admin/utenti" method="post" class="form-inline-block">
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
