function aggiungiAlCarrello(idProdotto, tipo, nome, prezzo, quantita, durata) {

    const formData = new URLSearchParams();
    formData.append("idProdotto", idProdotto);
    formData.append("tipo", tipo);
    formData.append("nome", nome);
    formData.append("prezzo", prezzo);
    formData.append("quantita", quantita);
    if(durata) formData.append("durata", durata);


    fetch("carrello/add", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
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
    .catch(error => console.error("Errore nell'aggiunta al carrello:", error));
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
    toast.style.backgroundColor = type === 'success' ? 'var(--color-primary, #3B4A2F)' : 'var(--color-accent, #C45C1A)';
    toast.style.color = '#fff';
    toast.style.padding = '15px 25px';
    toast.style.marginTop = '10px';
    toast.style.borderRadius = '8px';
    toast.style.boxShadow = '0 5px 15px rgba(0,0,0,0.2)';
    toast.style.fontWeight = 'bold';
    toast.style.opacity = '0';
    toast.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
    toast.style.transform = 'translateY(20px)';
    
    toastContainer.appendChild(toast);
    
    setTimeout(() => { 
        toast.style.opacity = '1'; 
        toast.style.transform = 'translateY(0)';
    }, 10);
    
    setTimeout(() => {
        toast.style.opacity = '0';
        toast.style.transform = 'translateY(20px)';
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

function rimuoviDalCarrello(idProdotto, tipo) {
    const formData = new URLSearchParams();
    formData.append("idProdotto", idProdotto);
    formData.append("tipo", tipo);

    fetch(window.location.pathname.replace('/carrello', '') + "/carrello/remove", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: formData.toString()
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === "success") {

            location.reload(); 
        }
    })
    .catch(error => console.error("Errore nella rimozione:", error));
}

function aggiornaQuantita(idProdotto, tipo, quantitaAttuale, variazione) {
    let nuovaQuantita = quantitaAttuale + variazione;
    
    const formData = new URLSearchParams();
    formData.append("idProdotto", idProdotto);
    formData.append("tipo", tipo);
    formData.append("quantita", nuovaQuantita);

    fetch(window.location.pathname.replace('/carrello', '') + "/carrello/update", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: formData.toString()
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === "success") {
            location.reload(); 
        }
    })
    .catch(error => console.error("Errore nell'aggiornamento:", error));
}
