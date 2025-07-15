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
    --azul-medio: #3b82f6;
    --azul-agua: #60a5fa;
    --azul-claro: #93c5fd;
    --azul-espuma: #eff6ff;
    --branco: #ffffff;
    --cinza-claro: #f8fafc;
    --cinza-medio: #64748b;
    --dourado: #f59e0b;
    --dourado-escuro: #d97706;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Poppins', sans-serif;
    line-height: 1.6;
    color: var(--azul-profundo);
    overflow-x: hidden;
}

.footer {
    background: var(--azul-escuro);
    color: white;
    text-align: center;
    padding: 2rem;
    font-weight: 300;    
}
    `;

    document.head.appendChild(style);
    document.body.appendChild(footer);
})()