function showError(inputElement, message) {
    let errorDiv = inputElement.nextElementSibling;
    if (!errorDiv || !errorDiv.classList.contains('input-error')) {
        errorDiv = document.createElement('div');
        errorDiv.classList.add('input-error');
        errorDiv.style.color = '#d93025';
        errorDiv.style.fontSize = '12px';
        errorDiv.style.marginTop = '4px';
        inputElement.parentNode.insertBefore(errorDiv, inputElement.nextSibling);
    }
    errorDiv.innerText = message;
    inputElement.style.borderColor = '#d93025';
}

function clearError(inputElement) {
    const errorDiv = inputElement.nextElementSibling;
    if (errorDiv && errorDiv.classList.contains('input-error')) {
        errorDiv.remove();
    }
    inputElement.style.borderColor = '#ccc';
}

function validateCF(cfInput) {
    const cf = cfInput.value.trim().toUpperCase();
    cfInput.value = cf;
    const regex = /^[A-Z]{6}[0-9LMNPQRSTUV]{2}[ABCDEHLMPRST][0-9LMNPQRSTUV]{2}[A-Z][0-9LMNPQRSTUV]{3}[A-Z]$/;
    if (!regex.test(cf)) {
        showError(cfInput, "Codice Fiscale non valido.");
        return false;
    }
    clearError(cfInput);
    return true;
}

function validateEmail(emailInput) {
    const email = emailInput.value.trim();
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!regex.test(email)) {
        showError(emailInput, "Formato email non valido.");
        return false;
    }
    clearError(emailInput);
    return true;
}

function validateRequired(input) {
    if (input.value.trim() === '') {
        showError(input, "Questo campo è obbligatorio.");
        return false;
    }
    clearError(input);
    return true;
}

function validatePassword(passwordInput) {
    if (passwordInput.value.length < 8) {
        showError(passwordInput, "La password deve contenere almeno 8 caratteri.");
        return false;
    }
    clearError(passwordInput);
    return true;
}

document.addEventListener("DOMContentLoaded", function() {
    
    const regForm = document.getElementById('regForm');
    if (regForm) {
        const tipoSelect = document.getElementById('tipoCliente');
        const socioFields = document.getElementById('socio-fields');
        if (tipoSelect && socioFields) {
            const updateSocioVisibility = () => {
                socioFields.style.display = (tipoSelect.value === 'Socio') ? 'block' : 'none';
            };
            tipoSelect.addEventListener('change', updateSocioVisibility);
            updateSocioVisibility();
        }

        const cfInput = document.getElementById('cf');
        const emailInput = document.getElementById('email');
        const nomeInput = document.getElementById('nome');
        const cognomeInput = document.getElementById('cognome');
        const passwordInput = document.getElementById('password');

        if (cfInput) cfInput.addEventListener('change', () => validateCF(cfInput));
        if (emailInput) emailInput.addEventListener('change', () => validateEmail(emailInput));
        if (nomeInput) nomeInput.addEventListener('change', () => validateRequired(nomeInput));
        if (cognomeInput) cognomeInput.addEventListener('change', () => validateRequired(cognomeInput));
        if (passwordInput) passwordInput.addEventListener('change', () => validatePassword(passwordInput));

        regForm.addEventListener('submit', function(e) {
            let isValid = true;
            if (!validateRequired(nomeInput)) isValid = false;
            if (!validateRequired(cognomeInput)) isValid = false;
            if (!validateCF(cfInput)) isValid = false;
            if (!validateEmail(emailInput)) isValid = false;
            if (!validatePassword(passwordInput)) isValid = false;

            if (!isValid) {
                e.preventDefault();
            }
        });
    }

    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        const emailInput = document.getElementById('email');
        const passwordInput = document.getElementById('password');

        if (emailInput) emailInput.addEventListener('change', () => validateEmail(emailInput));
        if (passwordInput) passwordInput.addEventListener('change', () => validateRequired(passwordInput));

        loginForm.addEventListener('submit', function(e) {
            let isValid = true;
            if (!validateEmail(emailInput)) isValid = false;
            if (!validateRequired(passwordInput)) isValid = false;

            if (!isValid) {
                e.preventDefault();
            }
        });
    }
});
