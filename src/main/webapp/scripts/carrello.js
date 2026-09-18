function getContextPath() {
    const header = document.querySelector('.header');
    return header ? (header.getAttribute('data-context-path') || '') : '';
}

function aggiungiAlCarrello(idProdotto, tipo, nome, prezzo, quantita, durata) {
    const cp = getContextPath();
    const formData = new URLSearchParams();
    formData.append("idProdotto", idProdotto);
    formData.append("tipo", tipo);
    formData.append("nome", nome);
    formData.append("prezzo", prezzo);
    formData.append("quantita", quantita);
    if (durata) formData.append("durata", durata);

    fetch(cp + "/carrello/add", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: formData.toString()
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === "success") {
            let counter = document.getElementById("cart-counter");
            if (counter) {
                counter.innerText = data.totaleArticoli;
            }
            showToast("Aggiunto al carrello!");
        }
    })
    .catch(error => console.error("Errore aggiunta carrello:", error));
}

function showToast(message, type = 'success') {
    let toastContainer = document.getElementById('toast-container');
    if (!toastContainer) {
        toastContainer = document.createElement('div');
        toastContainer.id = 'toast-container';
        toastContainer.style.position = 'fixed';
        toastContainer.style.bottom = '20px';
        toastContainer.style.right = '20px';
        toastContainer.style.zIndex = '9999';
        document.body.appendChild(toastContainer);
    }
    
    const toast = document.createElement('div');
    toast.innerText = message;
    toast.style.backgroundColor = type === 'success' ? '#1c1b1a' : '#f15d2a';
    toast.style.color = '#fff';
    toast.style.padding = '14px 24px';
    toast.style.marginTop = '10px';
    toast.style.borderRadius = '8px';
    toast.style.boxShadow = '0 4px 12px rgba(0,0,0,0.2)';
    toast.style.fontWeight = 'bold';
    
    toastContainer.appendChild(toast);
    
    setTimeout(() => {
        toast.remove();
    }, 2500);
}

function rimuoviDalCarrello(idProdotto, tipo) {
    const cp = getContextPath();
    const formData = new URLSearchParams();
    formData.append("idProdotto", idProdotto);
    formData.append("tipo", tipo);

    fetch(cp + "/carrello/remove", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: formData.toString()
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === "success") {
            window.location.href = cp + "/carrello";
        }
    })
    .catch(error => console.error("Errore rimozione carrello:", error));
}

function aggiornaQuantita(idProdotto, tipo, quantitaAttuale, variazione) {
    const cp = getContextPath();
    let nuovaQuantita = quantitaAttuale + variazione;
    
    const formData = new URLSearchParams();
    formData.append("idProdotto", idProdotto);
    formData.append("tipo", tipo);
    formData.append("quantita", nuovaQuantita);

    fetch(cp + "/carrello/update", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: formData.toString()
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === "success") {
            window.location.href = cp + "/carrello";
        }
    })
    .catch(error => console.error("Errore aggiornamento quantita:", error));
}

function svuotaCarrello() {
    const cp = getContextPath();
    fetch(cp + "/carrello/clear", {
        method: "POST"
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === "success") {
            window.location.href = cp + "/carrello";
        }
    })
    .catch(error => {
        window.location.href = cp + "/carrello?action=clear";
    });
}
