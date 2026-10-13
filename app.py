from bottle import Bottle, run, template, static_file, request, response
import json
from controllers.usuario_controller import cadastrar_usuario
from controllers.tarefa_controller import obter_tarefas, adicionar_tarefa, mover_tarefa, excluir_tarefa
from models.usuario import UsuarioModel
from models.tarefa import TarefaModel

app = Bottle()

# Rota para servir arquivos estáticos (CSS, JS, imagens)
@app.route('/static/<filename:path>')
def static_files(filename):
    return static_file(filename, root='./static')

# Rota para carregar a página principal
@app.route('/')
def pagina_principal():
    return template('pagina')

# Rota para a página de cadastro (apenas GET)
@app.route('/cadastro', method="GET")
def pagina_cadastro():
    return template('cadastro')

# Rota para processar o cadastro de usuário (POST)
@app.route('/cadastrar', method="POST")
def cadastrar():
    nome = request.forms.get("fullname")  # Nome completo
    email = request.forms.get("email")
    senha = request.forms.get("password")  # Captura a senha
    confirmar_senha = request.forms.get("confirm-password")

    if senha != confirmar_senha:
        response.status = 400
        return json.dumps({"erro": "As senhas não coincidem!"}, ensure_ascii=False, indent=4)

    resultado = cadastrar_usuario(nome, email, senha)
    response.content_type = 'application/json'
    return json.dumps(resultado, ensure_ascii=False, indent=4)

@app.route('/login', method="POST")
def login():
    email = request.forms.get("email")
    senha = request.forms.get("senha")

    if not email or not senha:
        return "Erro: Email ou senha não fornecidos"

    resultado = UsuarioModel.verificar_login(email, senha)
    if "erro" in resultado:
        return resultado["erro"]

    user_id = resultado["id"]  # Obtém o ID do usuário logado

    response.set_cookie("user_id", str(user_id), path="/")  # Agora salva o ID correto do usuário logado

    return "Login bem-sucedido"



# Rota para servir arquivos estáticos
@app.route('/static/<filename:path>')
def static_files(filename):
    return static_file(filename, root='./static')

# Rota para exibir a página de gerenciamento de tarefas
@app.route('/task_manager')
def task_manager():
    user_id = request.get_cookie("user_id")  # Obtém o ID salvo no cookie
    if not user_id:
        return "Erro: Faça login primeiro."

    # Buscar o usuário pelo ID
    usuario = UsuarioModel.buscar_usuario_por_id(user_id)
    nome_usuario = usuario["nome"] if usuario else "Desconhecido"

    # Carregar apenas as tarefas do usuário logado
    tarefas_usuario = TarefaModel.obter_tarefas_usuario(user_id)

    return template('task_manager', user_id=user_id, nome_usuario=nome_usuario, tarefas=tarefas_usuario)

# Rota para obter tarefas do usuário
@app.route('/get_tasks', method="GET")
def get_tasks():
    user_id = request.query.get("user_id")
    response.content_type = 'application/json'
    return json.dumps(obter_tarefas(user_id), ensure_ascii=False, indent=4)

# Rota para adicionar uma nova tarefa
@app.route('/add_task', method="POST")
def add_task():
    user_id = request.forms.get("user_id")
    descricao = request.forms.get("descricao")
    response.content_type = 'application/json'
    return json.dumps(adicionar_tarefa(user_id, descricao), ensure_ascii=False, indent=4)

# Rota para mover tarefa
@app.route('/move_task', method="POST")
def move_task():
    user_id = request.forms.get("user_id")
    descricao = request.forms.get("descricao")
    origem = request.forms.get("origem")
    destino = request.forms.get("destino")
    response.content_type = 'application/json'
    return json.dumps(mover_tarefa(user_id, descricao, origem, destino), ensure_ascii=False, indent=4)

# Rota para excluir tarefa
@app.route('/delete_task', method="POST")
def delete_task():
    user_id = request.forms.get("user_id")
    descricao = request.forms.get("descricao")
    response.content_type = 'application/json'
    return json.dumps(excluir_tarefa(user_id, descricao), ensure_ascii=False, indent=4)


