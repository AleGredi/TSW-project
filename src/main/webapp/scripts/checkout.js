document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('paymentForm');
    if (!form) return;

    const indirizzo = document.getElementById('indirizzo');
    const citta = document.getElementById('citta');
    const cap = document.getElementById('cap');
    const provincia = document.getElementById('provincia');
    const telefono = document.getElementById('telefono');
    const titolare = document.getElementById('titolare');
    const numeroCarta = document.getElementById('numeroCarta');
    const scadenza = document.getElementById('scadenza');
    const cvv = document.getElementById('cvv');

    function checkCap() {
        if (!/^\d{5}$/.test(cap.value.trim())) {
            showError(cap, "Inserisci un CAP valido di 5 cifre.");
            return false;
        }
        clearError(cap);
        return true;
    }

    function checkProvincia() {
        if (!/^[A-Za-z]{2}$/.test(provincia.value.trim())) {
            showError(provincia, "Sigla provincia di 2 lettere (es. SA).");
            return false;
        }
        clearError(provincia);
        return true;
    }

    function checkTelefono() {
        if (!/^[0-9]{8,15}$/.test(telefono.value.trim())) {
            showError(telefono, "Inserisci un recapito telefonico (8-15 cifre).");
            return false;
        }
        clearError(telefono);
        return true;
    }

    function checkCarta() {
        const cleaned = numeroCarta.value.replace(/\s+/g, '');
        if (!/^\d{16}$/.test(cleaned)) {
            showError(numeroCarta, "Il numero di carta deve contenere 16 cifre.");
            return false;
        }
        clearError(numeroCarta);
        return true;
    }

    function checkScadenza() {
        if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(scadenza.value.trim())) {
            showError(scadenza, "Formato scadenza non valido (MM/AA).");
            return false;
        }
        clearError(scadenza);
        return true;
    }

    function checkCvv() {
        if (!/^\d{3}$/.test(cvv.value.trim())) {
            showError(cvv, "Il CVV deve contenere 3 cifre.");
            return false;
        }
        clearError(cvv);
        return true;
    }

    if (indirizzo) indirizzo.addEventListener('change', () => validateRequired(indirizzo));
    if (citta) citta.addEventListener('change', () => validateRequired(citta));
    if (cap) cap.addEventListener('change', checkCap);
    if (provincia) provincia.addEventListener('change', checkProvincia);
    if (telefono) telefono.addEventListener('change', checkTelefono);
    if (titolare) titolare.addEventListener('change', () => validateRequired(titolare));
    if (numeroCarta) numeroCarta.addEventListener('change', checkCarta);
    if (scadenza) scadenza.addEventListener('change', checkScadenza);
    if (cvv) cvv.addEventListener('change', checkCvv);

    form.addEventListener('submit', function(e) {
        let valid = true;
        if (indirizzo && !validateRequired(indirizzo)) valid = false;
        if (citta && !validateRequired(citta)) valid = false;
        if (cap && !checkCap()) valid = false;
        if (provincia && !checkProvincia()) valid = false;
        if (telefono && !checkTelefono()) valid = false;
        if (titolare && !validateRequired(titolare)) valid = false;
        if (numeroCarta && !checkCarta()) valid = false;
        if (scadenza && !checkScadenza()) valid = false;
        if (cvv && !checkCvv()) valid = false;

        if (!valid) {
            e.preventDefault();
        }
    });
});
