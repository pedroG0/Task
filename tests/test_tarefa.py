import pytest
import json
import os
import sys
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))# Adiciona o diretório principal ao sys.path
from models.tarefa import TarefaModel

# Define um caminho temporário para o banco de dados de tarefas
TEST_DB_PATH = "tests/test_tarefas.json"

@pytest.fixture(autouse=True)
def setup_database():
    """Cria um banco de dados de testes e limpa após cada teste."""
    TarefaModel.FILE_PATH = TEST_DB_PATH  # Usa o arquivo temporário
    with open(TEST_DB_PATH, "w", encoding="utf-8") as file:
        json.dump({}, file)  # Inicializa o JSON vazio
    yield
    os.remove(TEST_DB_PATH)  # Remove o arquivo de testes após os testes

def test_carregar_tarefas_vazio():
    """Testa se o banco de dados de tarefas retorna vazio inicialmente."""
    tarefas = TarefaModel.carregar_tarefas()
    assert tarefas == {}

def test_obter_tarefas_usuario_novo():
    """Testa se um novo usuário recebe listas de tarefas vazias automaticamente."""
    tarefas_usuario = TarefaModel.obter_tarefas_usuario("1001")
    assert tarefas_usuario == {"todo": [], "doing": [], "done": []}

def test_adicionar_tarefa():
    """Testa se uma nova tarefa pode ser adicionada corretamente."""
    TarefaModel.adicionar_tarefa("1001", "Estudar para a prova")
    
    tarefas_usuario = TarefaModel.obter_tarefas_usuario("1001")
    assert "Estudar para a prova" in tarefas_usuario["todo"]

def test_mover_tarefa():
    """Testa se uma tarefa pode ser movida de 'todo' para 'doing'."""
    TarefaModel.adicionar_tarefa("1001", "Fazer exercícios")
    TarefaModel.mover_tarefa("1001", "Fazer exercícios", "todo", "doing")
    
    tarefas_usuario = TarefaModel.obter_tarefas_usuario("1001")
    assert "Fazer exercícios" in tarefas_usuario["doing"]
    assert "Fazer exercícios" not in tarefas_usuario["todo"]

def test_mover_tarefa_para_done():
    """Testa se uma tarefa pode ser movida de 'doing' para 'done'."""
    TarefaModel.adicionar_tarefa("1001", "Revisar matéria")
    TarefaModel.mover_tarefa("1001", "Revisar matéria", "todo", "doing")
    TarefaModel.mover_tarefa("1001", "Revisar matéria", "doing", "done")
    
    tarefas_usuario = TarefaModel.obter_tarefas_usuario("1001")
    assert "Revisar matéria" in tarefas_usuario["done"]
    assert "Revisar matéria" not in tarefas_usuario["doing"]

def test_excluir_tarefa():
    """Testa se uma tarefa pode ser excluída corretamente."""
    TarefaModel.adicionar_tarefa("1001", "Ler livro")
    TarefaModel.excluir_tarefa("1001", "Ler livro")

    tarefas_usuario = TarefaModel.obter_tarefas_usuario("1001")
    assert "Ler livro" not in tarefas_usuario["todo"]
    assert "Ler livro" not in tarefas_usuario["doing"]
    assert "Ler livro" not in tarefas_usuario["done"]

def test_excluir_tarefa_inexistente():
    """Testa se a exclusão de uma tarefa inexistente não causa erro."""
    TarefaModel.excluir_tarefa("1001", "Tarefa que não existe")
    tarefas_usuario = TarefaModel.obter_tarefas_usuario("1001")
    assert tarefas_usuario == {"todo": [], "doing": [], "done": []}
