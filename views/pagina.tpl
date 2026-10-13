<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login • TASK-IT</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --primary-light: #eef2ff;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --bg-gradient: linear-gradient(135deg, #f8fafc 0%, #e0e7ff 50%, #f1f5f9 100%);
            --card-bg: #ffffff;
            --border-color: #e2e8f0;
            --input-bg: #f8fafc;
            --danger: #ef4444;
            --danger-bg: #fef2f2;
            --success: #10b981;
            --success-bg: #ecfdf5;
            --radius-md: 12px;
            --radius-lg: 18px;
            --shadow-card: 0 20px 40px -15px rgba(0, 0, 0, 0.08), 0 0 1px 1px rgba(0, 0, 0, 0.03);
            --transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: var(--bg-gradient);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            color: var(--text-main);
            position: relative;
            overflow-x: hidden;
        }

        /* Elementos decorativos de fundo */
        .bg-shape-1, .bg-shape-2 {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            z-index: 0;
            opacity: 0.6;
            pointer-events: none;
        }

        .bg-shape-1 {
            width: 320px;
            height: 320px;
            background: #818cf8;
            top: 5%;
            left: 10%;
        }

        .bg-shape-2 {
            width: 380px;
            height: 380px;
            background: #c7d2fe;
            bottom: 5%;
            right: 10%;
        }

        .login-wrapper {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 440px;
        }

        /* Branding Superior */
        .brand-header {
            text-align: center;
            margin-bottom: 28px;
        }

        .brand-logo {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            border-radius: 16px;
            color: white;
            font-size: 26px;
            box-shadow: 0 10px 20px -5px rgba(79, 70, 229, 0.4);
            margin-bottom: 12px;
        }

        .brand-title {
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -0.5px;
            background: linear-gradient(135deg, #1e1b4b 0%, #4338ca 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .brand-subtitle {
            font-size: 14px;
            color: var(--text-muted);
            margin-top: 4px;
        }

        /* Card de Login */
        .login-card {
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            padding: 36px 32px;
            box-shadow: var(--shadow-card);
            border: 1px solid rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
        }

        .form-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 8px;
        }

        .input-container {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-icon {
            position: absolute;
            left: 14px;
            color: #94a3b8;
            font-size: 15px;
            pointer-events: none;
            transition: var(--transition);
        }

        .form-input {
            width: 100%;
            padding: 13px 14px 13px 42px;
            background-color: var(--input-bg);
            border: 1.5px solid var(--border-color);
            border-radius: var(--radius-md);
            font-size: 14px;
            font-family: inherit;
            color: var(--text-main);
            transition: var(--transition);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary);
            background-color: #ffffff;
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.12);
        }

        .form-input:focus + .input-icon,
        .input-container:focus-within .input-icon {
            color: var(--primary);
        }

        .toggle-password {
            position: absolute;
            right: 14px;
            background: none;
            border: none;
            color: #94a3b8;
            cursor: pointer;
            padding: 4px;
            font-size: 14px;
            transition: var(--transition);
        }

        .toggle-password:hover {
            color: var(--text-main);
        }

        /* Botão Principal */
        .btn-submit {
            width: 100%;
            padding: 14px;
            margin-top: 10px;
            background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 8px 16px -4px rgba(79, 70, 229, 0.35);
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, #4338ca 0%, #4f46e5 100%);
            transform: translateY(-1px);
            box-shadow: 0 12px 20px -4px rgba(79, 70, 229, 0.45);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .btn-submit:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        /* Mensagens de Feedback */
        .message-box {
            margin-top: 18px;
            padding: 12px 14px;
            border-radius: var(--radius-md);
            font-size: 13.5px;
            font-weight: 500;
            display: none;
            align-items: center;
            gap: 10px;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-6px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .message-box.error {
            display: flex;
            background-color: var(--danger-bg);
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        .message-box.success {
            display: flex;
            background-color: var(--success-bg);
            color: #047857;
            border: 1px solid #a7f3d0;
        }

        /* Rodapé do Card */
        .card-footer {
            margin-top: 24px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
            text-align: center;
            font-size: 14px;
            color: var(--text-muted);
        }

        .card-footer a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }

        .card-footer a:hover {
            color: var(--primary-hover);
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="bg-shape-1"></div>
    <div class="bg-shape-2"></div>

    <div class="login-wrapper">
        <div class="brand-header">
            <div class="brand-logo">
                <i class="fa-solid fa-list-check"></i>
            </div>
            <h1 class="brand-title">TASK-IT</h1>
            <p class="brand-subtitle">Gerencie suas tarefas com facilidade e foco</p>
        </div>

        <div class="login-card">
            <h2 class="form-title">
                <i class="fa-solid fa-arrow-right-to-bracket" style="color: var(--primary); font-size: 18px;"></i>
                Acesse sua conta
            </h2>

            <form id="loginForm">
                <div class="form-group">
                    <label class="form-label" for="email">E-mail</label>
                    <div class="input-container">
                        <i class="fa-regular fa-envelope input-icon"></i>
                        <input type="email" id="email" name="email" class="form-input" placeholder="seu.email@exemplo.com" required autocomplete="email">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="senha">Senha</label>
                    <div class="input-container">
                        <i class="fa-solid fa-lock input-icon"></i>
                        <input type="password" id="senha" name="senha" class="form-input" placeholder="Digite sua senha" required autocomplete="current-password">
                        <button type="button" class="toggle-password" id="togglePassword" aria-label="Mostrar senha">
                            <i class="fa-regular fa-eye"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-submit" id="btnSubmit">
                    <span>Entrar</span>
                    <i class="fa-solid fa-arrow-right"></i>
                </button>
            </form>

            <div id="message" class="message-box"></div>

            <div class="card-footer">
                Não tem uma conta? <a href="/cadastro">Cadastre-se gratuitamente</a>
            </div>
        </div>
    </div>

    <script>
        // Toggle de visibilidade da senha
        const togglePassword = document.getElementById("togglePassword");
        const passwordInput = document.getElementById("senha");
        
        togglePassword.addEventListener("click", function() {
            const isPassword = passwordInput.getAttribute("type") === "password";
            passwordInput.setAttribute("type", isPassword ? "text" : "password");
            this.innerHTML = isPassword ? '<i class="fa-regular fa-eye-slash"></i>' : '<i class="fa-regular fa-eye"></i>';
        });

        // Envio do formulário
        document.getElementById("loginForm").addEventListener("submit", function(event) {
            event.preventDefault();

            const email = document.getElementById("email").value;
            const senha = document.getElementById("senha").value;
            const messageElement = document.getElementById("message");
            const btnSubmit = document.getElementById("btnSubmit");

            // Feedback de carregamento
            btnSubmit.disabled = true;
            btnSubmit.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i><span>Entrando...</span>';
            messageElement.style.display = "none";

            fetch("/login", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams({
                    email: email,
                    senha: senha
                })
            })
            .then(response => response.text())
            .then(data => {
                if (data.includes("Erro") || data.includes("não encontrado") || data.includes("incorreta")) {
                    messageElement.className = "message-box error";
                    messageElement.innerHTML = `<i class="fa-solid fa-circle-exclamation"></i><span>${data}</span>`;
                    btnSubmit.disabled = false;
                    btnSubmit.innerHTML = '<span>Entrar</span><i class="fa-solid fa-arrow-right"></i>';
                } else {
                    messageElement.className = "message-box success";
                    messageElement.innerHTML = '<i class="fa-solid fa-circle-check"></i><span>Login realizado! Redirecionando...</span>';
                    setTimeout(() => {
                        window.location.href = "/task_manager";
                    }, 1200);
                }
            })
            .catch(error => {
                messageElement.className = "message-box error";
                messageElement.innerHTML = '<i class="fa-solid fa-triangle-exclamation"></i><span>Erro de conexão com o servidor.</span>';
                btnSubmit.disabled = false;
                btnSubmit.innerHTML = '<span>Entrar</span><i class="fa-solid fa-arrow-right"></i>';
            });
        });
    </script>
</body>
</html>
