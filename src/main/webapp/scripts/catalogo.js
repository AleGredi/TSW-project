document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.getElementById('search-input');
    const armiGrid = document.getElementById('armi-grid');
    const munizioniGrid = document.getElementById('munizioni-grid');
    let debounceTimer;

    if (searchInput) {
        searchInput.addEventListener('input', (e) => {
            clearTimeout(debounceTimer);
            debounceTimer = setTimeout(() => {
                const q = e.target.value;
                const basePath = window.location.pathname;
                const url = basePath + (q ? '?q=' + encodeURIComponent(q) : '');
                
                fetch(url)
                    .then(res => res.text())
                    .then(html => {
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(html, 'text/html');
                        
                        const newArmiGrid = doc.getElementById('armi-grid');
                        const newMunizioniGrid = doc.getElementById('munizioni-grid');
                        
                        if (newArmiGrid && armiGrid) {
                            armiGrid.innerHTML = newArmiGrid.innerHTML;
                        }
                        if (newMunizioniGrid && munizioniGrid) {
                            munizioniGrid.innerHTML = newMunizioniGrid.innerHTML;
                        }
                        
                        window.history.replaceState({}, '', url);
                    })
                    .catch(err => console.error("Errore ricerca AJAX:", err));
            }, 300);
        });
    }
});
