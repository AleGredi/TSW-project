document.addEventListener("DOMContentLoaded", function() {
    const campoSelect = document.getElementById("campoId");
    const dataInput = document.getElementById("data");
    const orarioSelect = document.getElementById("fasciaOraria");
    const statusDiv = document.getElementById("slot-status");
    const btnSubmit = document.getElementById("btn-prenota");

    function checkSlot() {
        const campoId = campoSelect.value;
        const data = dataInput.value;
        const orario = orarioSelect.value;

        if (campoId && data && orario) {
            statusDiv.innerText = "Controllo disponibilità in corso...";
            statusDiv.style.color = "#888";
            btnSubmit.disabled = true;
            btnSubmit.style.opacity = '0.5';

            const url = `campi?action=checkSlot&campoId=${campoId}&data=${data}&fasciaOraria=${orario}`;
            
            fetch(url)
                .then(response => response.json())
                .then(result => {
                    if (result.disponibile) {
                        statusDiv.innerText = "✓ Pedana libera per questo orario! Puoi procedere.";
                        statusDiv.style.color = "var(--color-primary)";
                        btnSubmit.disabled = false;
                        btnSubmit.style.opacity = '1';
                    } else {
                        statusDiv.innerText = "✗ Pedana GIA' OCCUPATA. Scegli un altro orario o un altro campo.";
                        statusDiv.style.color = "var(--color-accent)";
                        btnSubmit.disabled = true;
                        btnSubmit.style.opacity = '0.5';
                    }
                })
                .catch(error => {
                    console.error("Errore AJAX:", error);
                    statusDiv.innerText = "Errore di connessione al server.";
                    statusDiv.style.color = "var(--color-accent)";
                });
        } else {
            statusDiv.innerText = "Seleziona tutti i campi per verificare la disponibilità.";
            statusDiv.style.color = "var(--color-muted)";
            btnSubmit.disabled = true;
            btnSubmit.style.opacity = '0.5';
        }
    }

    campoSelect.addEventListener("change", checkSlot);
    dataInput.addEventListener("change", checkSlot);
    orarioSelect.addEventListener("change", checkSlot);
    
    if (dataInput) {
        const today = new Date().toISOString().split('T')[0];
        dataInput.setAttribute('min', today);
    }
});
