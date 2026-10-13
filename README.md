# 📋 TASK-IT • Gerenciador de Tarefas Kanban

Sistema web completo de gerenciamento de tarefas baseado no modelo Kanban, desenvolvido com arquitetura **MVC (Model-View-Controller)** utilizando **Python**, **Bottle Framework** e persistência em arquivos **JSON**.

Projeto desenvolvido no contexto da disciplina de **Orientação a Objetos (OO)** do curso de **Engenharia de Software** da **Universidade de Brasília (UnB)**.

---

## Funcionalidades

### Autenticação & Usuários
- **Cadastro de Usuários**: Validação de formulário, correspondência de senhas e prevenção de e-mails duplicados.
- **Segurança de Senhas**: Criptografia de ponta a ponta utilizando hash **SHA-256** (`hashlib`).
- **Login & Sessão**: Controle de acesso e autenticação baseada em cookies HTTP (`user_id`).
- **Logout Seguro**: Limpeza de cookies de sessão com redirecionamento automático.

### Gerenciador de Tarefas (Kanban)
- **Quadro Dinâmico**: Organização visual em 3 colunas (*A Fazer*, *Em Execução* e *Concluído*).
- **Drag & Drop Nativo**: Arraste e solte tarefas diretamente entre as colunas do Kanban.
- **Criação Rápida**: Adicione tarefas digitando e pressionando a tecla `Enter`.
- **Métricas em Tempo Real**: Contadores de tarefas no topo do painel e em cada cabeçalho de coluna.
- **Ações Rápidas**: Botões intuitivos com tooltips para mover, concluir ou excluir tarefas.
- **Interface Moderna & Responsiva**: Design contemporâneo construído com tipografia refinada (*Plus Jakarta Sans*), microinterações, feedback visual claro e ícones *Font Awesome 6*.

---

## Arquitetura do Projeto (MVC)

O projeto segue estritamente o padrão de projeto **MVC**:

```text
task/
├── app.py                      # Definição das rotas e configuração da aplicação Bottle
├── main.py                     # Ponto de entrada do servidor HTTP (localhost:8080)
│
├── controllers/                # Camada de controle e regras de negócio
│   ├── tarefa_controller.py    # Ações sobre tarefas (adicionar, mover, excluir, listar)
│   └── usuario_controller.py   # Ações de cadastro e validação de usuários
│
├── models/                     # Camada de modelo e acesso aos dados
│   ├── tarefa.py               # Modelo de dados e operações sobre tarefas
│   └── usuario.py              # Modelo de dados, hashing SHA-256 e validação de login
│
├── database/                   # Armazenamento persistente (JSON)
│   ├── tarefas.json            # Base de dados de tarefas agrupadas por ID de usuário
│   └── usuarios.json           # Base de dados com registros dos usuários
│
├── views/                      # Camada de visualização (Templates Bottle .tpl)
│   ├── pagina.tpl              # Tela de Login modernizada
│   ├── cadastro.tpl            # Tela de Cadastro de Usuário
│   ├── task_manager.tpl        # Quadro Kanban interativo
│   └── helper.tpl              # Guia de apoio pedagógico (BMVC)
│
└── tests/                      # Suíte de testes automatizados
    ├── test_app.py             # Testes de integração dos controllers
    ├── test_tarefa.py          # Testes unitários do TarefaModel
    ├── test_tarefa_controller.py
    ├── test_usuario.py         # Testes unitários do UsuarioModel
    └── test_usuario_controller.py
```

---

## Tecnologias Utilizadas

- **Linguagem**: [Python 3.x](https://www.python.org/)
- **Micro-framework Web**: [Bottle Framework](https://bottlepy.org/)
- **Persistência de Dados**: JSON nativo
- **Frontend**:
  - HTML5 Semântico & CSS3 Moderno (Custom Properties, Flexbox, Grid, Glassmorphism)
  - JavaScript ES6+ (Fetch API, Drag and Drop API)
  - [Google Fonts](https://fonts.google.com/) (*Plus Jakarta Sans*)
  - [Font Awesome 6](https://fontawesome.com/) (Ícones vetoriais)
- **Testes**: [pytest](https://docs.pytest.org/)

---

## Pré-requisitos e Instalação

1. Certifique-se de ter o **Python 3.10+** instalado em sua máquina.
2. Clone ou faça o download deste repositório:
   ```bash
   git clone <URL_DO_REPOSITORIO>
   cd task
   ```
3. Instale as dependências necessárias:
   ```bash
   pip install bottle pytest
   ```

---

## Como Executar a Aplicação

1. No diretório raiz do projeto, execute:
   ```bash
   python main.py
   ```
2. Abra seu navegador e acesse:
   ```text
   http://localhost:8080
   ```
3. Você será direcionado para a tela de **Login**. Caso seja seu primeiro acesso, clique em **Cadastre-se gratuitamente** para criar uma conta.

---

## Como Executar os Testes

A suíte de testes valida todas as regras de negócio dos modelos e controladores utilizando bancos de dados temporários isolados.

Para rodar todos os testes automatizados, execute no terminal:

```bash
pytest tests/
```

Para ver a saída detalhada:
```bash
pytest -v tests/
```

---

## Rotas e Endpoints da Aplicação

| Método | Rota | Descrição | Resposta |
|---|---|---|---|
| `GET` | `/` | Página de login principal | HTML (`pagina.tpl`) |
| `POST` | `/login` | Autenticação do usuário e definição do cookie | Texto / Status |
| `GET` | `/cadastro` | Página de cadastro de novos usuários | HTML (`cadastro.tpl`) |
| `POST` | `/cadastrar` | Processa o cadastro de um novo usuário | JSON |
| `GET` | `/task_manager` | Quadro Kanban do usuário logado (requer cookie) | HTML (`task_manager.tpl`) |
| `GET` | `/get_tasks` | Retorna as tarefas do usuário (`user_id`) | JSON |
| `POST` | `/add_task` | Adiciona uma nova tarefa na coluna "A Fazer" | JSON |
| `POST` | `/move_task` | Move uma tarefa entre colunas (`origem` ➔ `destino`) | JSON |
| `POST` | `/delete_task` | Remove permanentemente uma tarefa | JSON |

---

## Autor

Desenvolvido para a disciplina de **Orientação a Objetos** — Faculdade de Tecnologia / UnB.
