(function () {
    const header = document.createElement('header');
    header.className = 'custom-header';

    // Dados do usuário ou agência (vindos da JSP via window)
    const nomeUsuario = window.usuarioLogado || null;
    const emailUsuario = window.usuarioEmail || null;
    const nomeAgencia = window.agenciaLogada || null;
    const emailAgencia = window.agenciaEmail || null;

    let menuLoginHTML = '';

    if (nomeUsuario && emailUsuario) {
        // Usuário logado
        menuLoginHTML = `
        <div class="logado-container">
            <span class="logado-info">
                <i class="fas fa-user"></i> ${nomeUsuario}<br><small>${emailUsuario}</small>
            </span>
            <div class="logado-botoes">
                <a href="home.jsp" class="m2-btn" title="Home"><i class="fas fa-home"></i></a>
                <a href="logout.jsp" class="m2-btn logout" title="Sair"><i class="fas fa-sign-out-alt"></i></a>
            </div>
        </div>`;
    } else if (nomeAgencia && emailAgencia) {
        // Agência logada
        menuLoginHTML = `
        <div class="logado-container">
            <span class="logado-info">
                <i class="fas fa-building"></i> ${nomeAgencia}<br><small>${emailAgencia}</small>
            </span>
            <div class="logado-botoes">
                <a href="painel-agencia.jsp" class="m2-btn" title="Painel"><i class="fas fa-briefcase"></i></a>
                <a href="logout.jsp" class="m2-btn logout" title="Sair"><i class="fas fa-sign-out-alt"></i></a>
            </div>
        </div>`;
    } else {
        // Ninguém logado
        menuLoginHTML = `
            <a href="login-usuario.jsp" id="informacoes-login">
                <i class="fas fa-user"></i> Login/Cadastro
            </a>`;
    }

    header.innerHTML = `
        <header class="header" id="header">
            <div class="logo">DeepBlue</div>
            <nav>
                <a href="index.jsp"><i class="fas fa-home"></i> Início</a>
                <a href="mapaInterativo.jsp"><i class="fas fa-map"></i> Locais</a>
                <a href="agencias.jsp"><i class="fas fa-search"></i> Agências</a>
                <a href="faq.jsp"><i class="fas fa-comments"></i> FAQ</a>
                ${menuLoginHTML}
            </nav>
        </header>`;

    const style = document.createElement('style');
    style.textContent = `
        :root {
            --azul-profundo: #01203a;
            --azul-agua: #60a5fa;
            --azul-medio: #3b82f6;
            --vermelho: #f87171;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
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

        nav {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            padding: 0.7rem 1.2rem;
            border-radius: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        nav a::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, var(--azul-agua), var(--azul-medio));
            transition: left 0.3s ease;
            z-index: -1;
        }

        nav a:hover::before {
            left: 0;
        }

        nav a:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(96, 165, 250, 0.4);
        }

        /* Estilo para usuário/agência logado */
        .logado-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 0.4rem;
        }

        .logado-info {
            font-size: 0.9rem;
            opacity: 0.9;
            line-height: 1.3;
        }

        .logado-info small {
            font-size: 0.75rem;
            color: #ccc;
        }

        .logado-botoes {
            display: flex;
            gap: 0.5rem;
            margin-top: 0.2rem;
        }

        .m2-btn {
            background: none;
            border: 1px solid var(--azul-agua);
            color: var(--azul-agua);
            padding: 0.3rem 0.6rem;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 600;
            text-decoration: none;
            transition: 0.2s ease;
        }

        .m2-btn:hover {
            background-color: var(--azul-medio);
            color: white;
        }

        .m2-btn.logout {
            border-color: var(--vermelho);
            color: var(--vermelho);
        }

        .m2-btn.logout:hover {
            background-color: var(--vermelho);
            color: white;
        }
    `;

    document.head.appendChild(style);
    document.body.prepend(header);
})();
