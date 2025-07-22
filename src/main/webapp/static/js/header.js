(function () {
    const header = document.createElement('header');
    header.className = 'custom-header';
    header.innerHTML = `
<header class="header" id="header">
    <div class="logo">DeepBlue</div>
    <nav>
        <a href="index.html"><i class="fas fa-home"></i> Início</a>
        <a href="mapaInterativo.jsp"><i class="fas fa-map"></i> Mapa Interativo</a>
        <a href="agencias.jsp"><i class="fas fa-search"></i> Agências</a>
        <a href="faq.html"><i class="fas fa-comments"></i> FAQ</a>
        <a href="login-usuario.jsp" id="informacoes-login"><i class="fas fa-user"></i> Login/Cadastro</a>
    </nav>
</header>`;

    const style = document.createElement('style');
    style.textContent = `
    :root {
    --azul-profundo: #01203a;
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

.header {
    background: rgba(1, 32, 58, 0.95);
    backdrop-filter: blur(15px);
    color: white;
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
    transition: all 0.3s ease;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.logo {
    font-size: 2rem;
    font-weight: 800;
    background: linear-gradient(45deg, #60a5fa, #93c5fd, #3b82f6);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    text-shadow: 0 0 30px rgba(96, 165, 250, 0.5);
}
    `;

    document.head.appendChild(style);
    document.body.prepend(header);

})()
