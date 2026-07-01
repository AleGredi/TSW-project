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
            alert("Aggiunto al carrello!");
        }
    })
    .catch(error => console.error("Errore nell'aggiunta al carrello:", error));
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
