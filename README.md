# SkeetPro - Centro Tiro a Volo

Progetto per il corso di Tecnologie e Servizi Web (TSW) - Università degli Studi di Salerno.
Applicazione web per la gestione di un centro di tiro a volo: prenotazione campi, noleggio armi, acquisto munizioni, carrello/ordini e pannello admin.

## Tecnologie
- Java 21, Jakarta Servlet, JSP, JSTL
- HTML5, CSS3, JavaScript (AJAX)
- MySQL 8.0, JDBC (DataSource JNDI)
- Apache Tomcat 11

## Configurazione e avvio
1. Importare lo script `database/storage.sql` su MySQL.
2. Impostare le credenziali del database in `src/main/webapp/META-INF/context.xml`.
3. Eseguire su Tomcat 11 da Eclipse (Run on Server) o tramite deploy del file `.war`.

## Account di prova
- Admin: `admin` / `admin123`
- Socio: `mario.rossi@email.it` / `pass123`
- Temporaneo: `giulia.bianchi@email.it` / `pass123`
