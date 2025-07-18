(function () {
    const footer = document.createElement('footer');
    footer.className = 'footer';
    footer.innerHTML = `
        <p>&copy; 2025 DeepBlue. Todos os direitos reservados.</p>
    `;

    const style = document.createElement('style');
    style.textContent = `
:root {
    --azul-profundo: #01203a;
    --azul-escuro: #1e3a8a;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Poppins', sans-serif;
    line-height: 1.6;
    color: var(--azul-escuro);
    overflow-x: hidden;
}

.footer {
    background: var(--azul-profundo);
    color: white;
    text-align: center;
    padding: 2rem;
    font-weight: 300;    
}
    `;

    document.head.appendChild(style);
    document.body.appendChild(footer);
})()