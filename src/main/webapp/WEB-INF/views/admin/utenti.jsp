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
    <style>
        .admin-layout { display: flex; min-height: 100vh; }
        .admin-sidebar { width: 250px; background-color: var(--color-primary); color: white; padding: 20px 0; }
        .admin-sidebar h2 { text-align: center; color: var(--color-accent); border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 20px; margin-bottom: 20px; }
        .admin-sidebar ul { list-style: none; padding: 0; margin: 0; }
        .admin-sidebar ul li a { display: block; padding: 15px 25px; color: white; text-decoration: none; transition: background 0.3s; }
        .admin-sidebar ul li a:hover, .admin-sidebar ul li a.active { background-color: rgba(255,255,255,0.1); border-left: 4px solid var(--color-accent); }
        .admin-main { flex: 1; background-color: #f4f7f6; padding: 30px; }
        .admin-header { display: flex; justify-content: space-between; align-items: center; background: white; padding: 15px 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 30px; }
        .admin-card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 20px; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: var(--color-surface); color: var(--color-primary); }
        .status-badge { padding: 5px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; color: white; }
        .status-active { background-color: #28a745; }
        .status-suspended { background-color: #ffc107; color: #333; }
        .status-expired { background-color: #dc3545; }
        .status-temp { background-color: #17a2b8; }
        
        .alert-badge { font-size: 11px; padding: 3px 6px; border-radius: 4px; font-weight: bold; margin-left: 5px; }
        .alert-warning { background-color: #ffeb3b; color: #b71c1c; border: 1px solid #fbc02d; }
        .alert-danger { background-color: #f44336; color: white; border: 1px solid #d32f2f; }
        
        .action-btn { border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 13px; color: white; margin-right: 5px; }
        .btn-suspend { background-color: #ffc107; color: #333; }
        .btn-activate { background-color: #28a745; }
    </style>
</head>
<body style="margin: 0;">

    <div class="admin-layout">
        <aside class="admin-sidebar">
            <h2>🎯 SkeetPro Admin</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
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
                <table>
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
