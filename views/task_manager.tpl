<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciador de Tarefas • TASK-IT</title>
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
            --bg-body: #f8fafc;
            --surface: #ffffff;
            --surface-hover: #f1f5f9;
            --border: #e2e8f0;
            --border-light: #edf2f7;
            --text-main: #0f172a;
            --text-secondary: #475569;
            --text-muted: #94a3b8;
            
            --todo-accent: #6366f1;
            --todo-bg: #eef2ff;
            --todo-border: #c7d2fe;

            --doing-accent: #f59e0b;
            --doing-bg: #fffbeb;
            --doing-border: #fde68a;

            --done-accent: #10b981;
            --done-bg: #ecfdf5;
            --done-border: #a7f3d0;

            --danger: #ef4444;
            --danger-bg: #fef2f2;

            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
            --radius-xl: 20px;

            --shadow-subtle: 0 1px 3px 0 rgba(0, 0, 0, 0.05);
            --shadow-card: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
            --shadow-hover: 0 10px 15px -3px rgba(0, 0, 0, 0.08), 0 4px 6px -4px rgba(0, 0, 0, 0.04);
            --shadow-column: 0 4px 20px -2px rgba(0, 0, 0, 0.04);

            --transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Navbar Principal */
        .navbar {
            background-color: var(--surface);
            border-bottom: 1px solid var(--border);
            padding: 14px 28px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 50;
            backdrop-filter: blur(8px);
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }

        .brand-badge {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
            box-shadow: 0 4px 10px -2px rgba(79, 70, 229, 0.35);
        }

        .brand-text {
            font-size: 20px;
            font-weight: 800;
            letter-spacing: -0.5px;
            background: linear-gradient(135deg, #1e1b4b 0%, #4338ca 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .navbar-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 6px 14px 6px 8px;
            background: var(--bg-body);
            border: 1px solid var(--border);
            border-radius: 999px;
        }

        .user-avatar {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: 700;
        }

        .user-meta {
            display: flex;
            flex-direction: column;
            text-align: left;
        }

        .user-name {
            font-size: 13px;
            font-weight: 700;
            color: var(--text-main);
            line-height: 1.2;
            max-width: 140px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .user-id-badge {
            font-size: 11px;
            font-weight: 600;
            color: var(--text-muted);
        }

        .btn-logout {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            background: #ffffff;
            color: #dc2626;
            border: 1.5px solid #fee2e2;
            border-radius: var(--radius-md);
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }

        .btn-logout:hover {
            background: var(--danger-bg);
            border-color: #fca5a5;
            color: #b91c1c;
            transform: translateY(-1px);
        }

        /* Container Principal do App */
        .main-content {
            flex: 1;
            padding: 28px;
            max-width: 1360px;
            width: 100%;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* Barra Superior do Kanban (Criação rápida e Filtros) */
        .kanban-toolbar {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 18px 22px;
            box-shadow: var(--shadow-subtle);
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            align-items: center;
            justify-content: space-between;
        }

        .new-task-form {
            display: flex;
            align-items: center;
            gap: 10px;
            flex: 1;
            min-width: 300px;
        }

        .input-task-wrapper {
            position: relative;
            flex: 1;
        }

        .input-task-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 14px;
        }

        .input-task {
            width: 100%;
            padding: 11px 16px 11px 40px;
            background: var(--bg-body);
            border: 1.5px solid var(--border);
            border-radius: var(--radius-md);
            font-size: 14px;
            font-family: inherit;
            color: var(--text-main);
            transition: var(--transition);
        }

        .input-task:focus {
            outline: none;
            background: var(--surface);
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.12);
        }

        .btn-add-task {
            padding: 11px 20px;
            background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: var(--transition);
            white-space: nowrap;
            box-shadow: 0 4px 12px -2px rgba(79, 70, 229, 0.35);
        }

        .btn-add-task:hover {
            background: linear-gradient(135deg, #4338ca 0%, #4f46e5 100%);
            transform: translateY(-1px);
        }

        .toolbar-stats {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .stat-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 999px;
            font-size: 12.5px;
            font-weight: 600;
            background: var(--bg-body);
            border: 1px solid var(--border);
            color: var(--text-secondary);
        }

        .stat-pill .count {
            padding: 2px 7px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 700;
        }

        .stat-pill.todo .count { background: var(--todo-bg); color: var(--todo-accent); }
        .stat-pill.doing .count { background: var(--doing-bg); color: var(--doing-accent); }
        .stat-pill.done .count { background: var(--done-bg); color: var(--done-accent); }

        /* Board Kanban */
        .board-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
            align-items: start;
        }

        @media (max-width: 960px) {
            .board-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Colunas */
        .kanban-column {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 20px 18px;
            box-shadow: var(--shadow-column);
            display: flex;
            flex-direction: column;
            gap: 16px;
            min-height: 480px;
            transition: var(--transition);
        }

        .kanban-column.drag-over {
            border-color: var(--primary);
            background-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.2);
        }

        /* Cabeçalho da Coluna */
        .column-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 14px;
            border-bottom: 1.5px solid var(--border-light);
        }

        .column-title-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .column-icon-badge {
            width: 32px;
            height: 32px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
        }

        .col-todo .column-icon-badge { background: var(--todo-bg); color: var(--todo-accent); }
        .col-doing .column-icon-badge { background: var(--doing-bg); color: var(--doing-accent); }
        .col-done .column-icon-badge { background: var(--done-bg); color: var(--done-accent); }

        .column-title {
            font-size: 15px;
            font-weight: 700;
            color: var(--text-main);
        }

        .column-counter {
            font-size: 12px;
            font-weight: 700;
            padding: 3px 10px;
            border-radius: 999px;
        }

        .col-todo .column-counter { background: var(--todo-bg); color: var(--todo-accent); }
        .col-doing .column-counter { background: var(--doing-bg); color: var(--doing-accent); }
        .col-done .column-counter { background: var(--done-bg); color: var(--done-accent); }

        /* Lista de Tarefas */
        .task-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            flex: 1;
            min-height: 160px;
        }

        /* Card de Tarefa */
        .task-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 14px 16px;
            box-shadow: var(--shadow-card);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            gap: 12px;
            position: relative;
            cursor: grab;
        }

        .task-card:active {
            cursor: grabbing;
        }

        .task-card.dragging {
            opacity: 0.45;
            transform: scale(0.98);
        }

        .task-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
            border-color: #cbd5e1;
        }

        /* Borda decorativa por status */
        .col-todo .task-card { border-left: 4px solid var(--todo-accent); }
        .col-doing .task-card { border-left: 4px solid var(--doing-accent); }
        .col-done .task-card { border-left: 4px solid var(--done-accent); background-color: #fafbfc; }

        .task-content {
            font-size: 14px;
            color: var(--text-main);
            font-weight: 500;
            line-height: 1.5;
            word-break: break-word;
        }

        .col-done .task-content {
            color: #64748b;
            text-decoration: line-through;
        }

        /* Barra de Ações do Card */
        .task-actions {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 6px;
            padding-top: 10px;
            border-top: 1px dashed var(--border-light);
        }

        .btn-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            border-radius: var(--radius-sm);
            border: 1px solid transparent;
            background: var(--bg-body);
            font-size: 13px;
            cursor: pointer;
            transition: var(--transition);
        }

        .btn-move-doing {
            color: var(--doing-accent);
            background: var(--doing-bg);
            border-color: var(--doing-border);
        }

        .btn-move-doing:hover {
            background: var(--doing-accent);
            color: #ffffff;
            transform: scale(1.08);
        }

        .btn-move-done {
            color: var(--done-accent);
            background: var(--done-bg);
            border-color: var(--done-border);
        }

        .btn-move-done:hover {
            background: var(--done-accent);
            color: #ffffff;
            transform: scale(1.08);
        }

        .btn-delete {
            color: #ef4444;
            background: #fef2f2;
            border-color: #fecaca;
        }

        .btn-delete:hover {
            background: #ef4444;
            color: #ffffff;
            transform: scale(1.08);
        }

        /* Empty State */
        .empty-state {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 36px 16px;
            text-align: center;
            color: var(--text-muted);
            border: 2px dashed #e2e8f0;
            border-radius: var(--radius-md);
            margin: auto 0;
        }

        .empty-state-icon {
            font-size: 26px;
            margin-bottom: 10px;
            color: #cbd5e1;
        }

        .empty-state-text {
            font-size: 13px;
            font-weight: 500;
        }

        /* Toast de Notificação */
        .toast {
            position: fixed;
            bottom: 24px;
            right: 24px;
            background: #1e293b;
            color: white;
            padding: 12px 20px;
            border-radius: var(--radius-md);
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.3);
            display: none;
            align-items: center;
            gap: 10px;
            font-size: 13.5px;
            font-weight: 500;
            z-index: 100;
            animation: slideUp 0.3s ease;
        }

        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
    </style>
</head>
<body>

    <!-- Header / Navbar -->
    <header class="navbar">
        <div class="navbar-brand">
            <div class="brand-badge">
                <i class="fa-solid fa-layer-group"></i>
            </div>
            <div class="brand-text">TASK-IT</div>
        </div>

        <div class="navbar-actions">
            <div class="user-profile">
                <div class="user-avatar" id="userAvatar">
                    <!-- Iniciais geradas via JS -->
                    <i class="fa-solid fa-user"></i>
                </div>
                <div class="user-meta">
                    <span class="user-name" title="{{nome_usuario}}">{{nome_usuario}}</span>
                    <span class="user-id-badge">ID: #{{user_id}}</span>
                </div>
            </div>

            <button class="btn-logout" onclick="logout()" title="Encerrar sessão">
                <i class="fa-solid fa-arrow-right-from-bracket"></i>
                <span>Sair</span>
            </button>
        </div>
    </header>

    <!-- Conteúdo Principal -->
    <main class="main-content">
        <!-- Toolbar com criação rápida e estatísticas -->
        <div class="kanban-toolbar">
            <div class="new-task-form">
                <div class="input-task-wrapper">
                    <i class="fa-solid fa-plus input-task-icon"></i>
                    <input type="text" id="new-task" class="input-task" placeholder="Adicionar nova tarefa... (Pressione Enter)" autofocus>
                </div>
                <button class="btn-add-task" onclick="addTask()">
                    <i class="fa-solid fa-plus"></i>
                    <span>Adicionar</span>
                </button>
            </div>

            <div class="toolbar-stats">
                <div class="stat-pill todo">
                    <span>A Fazer:</span>
                    <span class="count">{{len(tarefas.get('todo', []))}}</span>
                </div>
                <div class="stat-pill doing">
                    <span>Em Execução:</span>
                    <span class="count">{{len(tarefas.get('doing', []))}}</span>
                </div>
                <div class="stat-pill done">
                    <span>Concluídas:</span>
                    <span class="count">{{len(tarefas.get('done', []))}}</span>
                </div>
            </div>
        </div>

        <!-- Kanban Board Grid -->
        <div class="board-grid">
            
            <!-- Coluna: A Fazer -->
            <div class="kanban-column col-todo" data-column="todo">
                <div class="column-header">
                    <div class="column-title-group">
                        <div class="column-icon-badge">
                            <i class="fa-regular fa-clipboard"></i>
                        </div>
                        <h2 class="column-title">A Fazer</h2>
                    </div>
                    <span class="column-counter">{{len(tarefas.get('todo', []))}}</span>
                </div>

                <div class="task-list" id="todo-list">
                    % if tarefas.get('todo', []):
                        % for task in tarefas['todo']:
                            <div class="task-card" draggable="true" data-task="{{task}}" data-origin="todo">
                                <div class="task-content">{{task}}</div>
                                <div class="task-actions">
                                    <button class="btn-action btn-move-doing" onclick="moveTask('{{task}}', 'todo', 'doing')" title="Mover para Em Execução">
                                        <i class="fa-solid fa-play"></i>
                                    </button>
                                    <button class="btn-action btn-move-done" onclick="moveTask('{{task}}', 'todo', 'done')" title="Marcar como Concluído">
                                        <i class="fa-solid fa-check"></i>
                                    </button>
                                    <button class="btn-action btn-delete" onclick="deleteTask('{{task}}')" title="Excluir Tarefa">
                                        <i class="fa-regular fa-trash-can"></i>
                                    </button>
                                </div>
                            </div>
                        % end
                    % else:
                        <div class="empty-state">
                            <i class="fa-regular fa-calendar-check empty-state-icon"></i>
                            <span class="empty-state-text">Nenhuma tarefa pendente</span>
                        </div>
                    % end
                </div>
            </div>

            <!-- Coluna: Em Execução -->
            <div class="kanban-column col-doing" data-column="doing">
                <div class="column-header">
                    <div class="column-title-group">
                        <div class="column-icon-badge">
                            <i class="fa-solid fa-spinner fa-spin-pulse" style="--fa-animation-duration: 3s;"></i>
                        </div>
                        <h2 class="column-title">Em Execução</h2>
                    </div>
                    <span class="column-counter">{{len(tarefas.get('doing', []))}}</span>
                </div>

                <div class="task-list" id="doing-list">
                    % if tarefas.get('doing', []):
                        % for task in tarefas['doing']:
                            <div class="task-card" draggable="true" data-task="{{task}}" data-origin="doing">
                                <div class="task-content">{{task}}</div>
                                <div class="task-actions">
                                    <button class="btn-action btn-move-done" onclick="moveTask('{{task}}', 'doing', 'done')" title="Concluir Tarefa">
                                        <i class="fa-solid fa-check"></i>
                                    </button>
                                    <button class="btn-action btn-delete" onclick="deleteTask('{{task}}')" title="Excluir Tarefa">
                                        <i class="fa-regular fa-trash-can"></i>
                                    </button>
                                </div>
                            </div>
                        % end
                    % else:
                        <div class="empty-state">
                            <i class="fa-solid fa-bars-progress empty-state-icon"></i>
                            <span class="empty-state-text">Nenhuma tarefa em andamento</span>
                        </div>
                    % end
                </div>
            </div>

            <!-- Coluna: Terminado -->
            <div class="kanban-column col-done" data-column="done">
                <div class="column-header">
                    <div class="column-title-group">
                        <div class="column-icon-badge">
                            <i class="fa-solid fa-circle-check"></i>
                        </div>
                        <h2 class="column-title">Concluído</h2>
                    </div>
                    <span class="column-counter">{{len(tarefas.get('done', []))}}</span>
                </div>

                <div class="task-list" id="done-list">
                    % if tarefas.get('done', []):
                        % for task in tarefas['done']:
                            <div class="task-card" draggable="true" data-task="{{task}}" data-origin="done">
                                <div class="task-content">{{task}}</div>
                                <div class="task-actions">
                                    <button class="btn-action btn-delete" onclick="deleteTask('{{task}}')" title="Excluir Tarefa">
                                        <i class="fa-regular fa-trash-can"></i>
                                    </button>
                                </div>
                            </div>
                        % end
                    % else:
                        <div class="empty-state">
                            <i class="fa-regular fa-circle-check empty-state-icon"></i>
                            <span class="empty-state-text">Nenhuma tarefa concluída ainda</span>
                        </div>
                    % end
                </div>
            </div>

        </div>
    </main>

    <!-- Toast de Feedback -->
    <div id="toast" class="toast">
        <i class="fa-solid fa-circle-info"></i>
        <span id="toastMsg">Operação realizada</span>
    </div>

    <!-- Scripts de Interação -->
    <script>
        const userId = "{{user_id}}";
        const userName = "{{nome_usuario}}";

        // Gerar iniciais do usuário no avatar
        (function setupAvatar() {
            if (!userName || userName === "Desconhecido") return;
            const names = userName.trim().split(/\s+/);
            let initials = names[0][0];
            if (names.length > 1) {
                initials += names[names.length - 1][0];
            }
            const avatarEl = document.getElementById("userAvatar");
            if (avatarEl) avatarEl.textContent = initials.toUpperCase();
        })();

        // Atalho Enter para criar tarefa
        document.getElementById("new-task").addEventListener("keydown", function(e) {
            if (e.key === "Enter") {
                addTask();
            }
        });

        // Função de notificação Toast
        function showToast(message) {
            const toast = document.getElementById("toast");
            const toastMsg = document.getElementById("toastMsg");
            toastMsg.textContent = message;
            toast.style.display = "flex";
            setTimeout(() => {
                toast.style.display = "none";
            }, 2500);
        }

        // Adicionar Tarefa
        function addTask() {
            const inputEl = document.getElementById("new-task");
            const descricao = inputEl.value.trim();
            if (!descricao) return;

            inputEl.disabled = true;

            fetch("/add_task", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: new URLSearchParams({ user_id: userId, descricao: descricao })
            })
            .then(res => res.json())
            .then(() => {
                window.location.reload();
            })
            .catch(() => {
                inputEl.disabled = false;
                showToast("Erro ao adicionar tarefa.");
            });
        }

        // Mover Tarefa
        function moveTask(descricao, origem, destino) {
            fetch("/move_task", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: new URLSearchParams({ user_id: userId, descricao: descricao, origem: origem, destino: destino })
            })
            .then(res => res.json())
            .then(() => {
                window.location.reload();
            })
            .catch(() => {
                showToast("Erro ao mover tarefa.");
            });
        }

        // Excluir Tarefa
        function deleteTask(descricao) {
            fetch("/delete_task", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: new URLSearchParams({ user_id: userId, descricao: descricao })
            })
            .then(res => res.json())
            .then(() => {
                window.location.reload();
            })
            .catch(() => {
                showToast("Erro ao excluir tarefa.");
            });
        }

        // Logout
        function logout() {
            document.cookie = "user_id=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            showToast("Saindo...");
            setTimeout(() => {
                window.location.href = "/";
            }, 400);
        }

        // Drag & Drop nativo entre colunas
        const taskCards = document.querySelectorAll(".task-card");
        const columns = document.querySelectorAll(".kanban-column");

        let draggedCard = null;

        taskCards.forEach(card => {
            card.addEventListener("dragstart", (e) => {
                draggedCard = card;
                card.classList.add("dragging");
                e.dataTransfer.setData("text/plain", card.getAttribute("data-task"));
            });

            card.addEventListener("dragend", () => {
                card.classList.remove("dragging");
                columns.forEach(col => col.classList.remove("drag-over"));
            });
        });

        columns.forEach(col => {
            col.addEventListener("dragover", (e) => {
                e.preventDefault();
                col.classList.add("drag-over");
            });

            col.addEventListener("dragleave", () => {
                col.classList.remove("drag-over");
            });

            col.addEventListener("drop", (e) => {
                e.preventDefault();
                col.classList.remove("drag-over");
                if (!draggedCard) return;

                const origin = draggedCard.getAttribute("data-origin");
                const destination = col.getAttribute("data-column");
                const task = draggedCard.getAttribute("data-task");

                if (origin !== destination) {
                    moveTask(task, origin, destination);
                }
            });
        });
    </script>
</body>
</html>
