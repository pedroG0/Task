import pytest
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from controllers.tarefa_controller import obter_tarefas, adicionar_tarefa, mover_tarefa, excluir_tarefa
from models.tarefa import TarefaModel

@pytest.fixture(autouse=True)
def setup_database():
    """Configura o banco de dados de tarefas para testes"""
    TarefaModel.FILE_PATH = "tests/test_tarefas.json"  # Define um caminho temporário
    with open(TarefaModel.FILE_PATH, "w", encoding="utf-8") as file:
        file.write("{}")  # Cria um arquivo JSON vazio
    yield
    import os
    os.remove(TarefaModel.FILE_PATH)  # Remove após os testes

def test_obter_tarefas_usuario():
    """Testa se o controller retorna corretamente as tarefas de um usuário"""
    tarefas = obter_tarefas("1001")
    assert tarefas == {"todo": [], "doing": [], "done": []}  # Deve retornar listas vazias

def test_adicionar_tarefa():
    """Testa se o controller adiciona corretamente uma nova tarefa"""
    resposta = adicionar_tarefa("1001", "Comprar leite")
    assert resposta["mensagem"] == "Tarefa adicionada com sucesso"

    tarefas = obter_tarefas("1001")
    assert "Comprar leite" in tarefas["todo"]  # A tarefa deve estar na lista 'todo'

def test_mover_tarefa():
    """Testa se o controller move uma tarefa corretamente"""
    adicionar_tarefa("1001", "Estudar matemática")
    mover_tarefa("1001", "Estudar matemática", "todo", "doing")

    tarefas = obter_tarefas("1001")
    assert "Estudar matemática" in tarefas["doing"]
    assert "Estudar matemática" not in tarefas["todo"]

def test_excluir_tarefa():
    """Testa se o controller exclui corretamente uma tarefa"""
    adicionar_tarefa("1001", "Fazer exercícios")
    excluir_tarefa("1001", "Fazer exercícios")

    tarefas = obter_tarefas("1001")
    assert "Fazer exercícios" not in tarefas["todo"]
    assert "Fazer exercícios" not in tarefas["doing"]
    assert "Fazer exercícios" not in tarefas["done"]
