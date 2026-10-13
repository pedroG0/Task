import pytest
import json
import os
import sys
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from controllers.usuario_controller import cadastrar_usuario
from models.usuario import UsuarioModel

# Define um caminho temporário para o banco de dados de usuários
TEST_DB_PATH = "tests/test_usuarios.json"

@pytest.fixture(autouse=True)
def setup_database():
    """Cria um banco de dados de testes e limpa após cada teste."""
    UsuarioModel.FILE_PATH = TEST_DB_PATH  # Usa o arquivo temporário
    with open(TEST_DB_PATH, "w", encoding="utf-8") as file:
        json.dump([], file)  # Inicializa o JSON vazio
    yield
    os.remove(TEST_DB_PATH)  # Remove o arquivo de testes após os testes

def test_cadastrar_usuario():
    """Testa se o controller cadastra corretamente um novo usuário"""
    resposta = cadastrar_usuario("João Silva", "joao@email.com", "123456")
    assert "mensagem" in resposta
    assert resposta["mensagem"] == "Usuário cadastrado com sucesso!"
    assert "id" in resposta

    # Verifica se o usuário foi salvo corretamente
    usuarios = UsuarioModel.carregar_usuarios()
    assert len(usuarios) == 1
    assert usuarios[0]["nome"] == "João Silva"
    assert usuarios[0]["email"] == "joao@email.com"

def test_cadastrar_usuario_email_existente():
    """Testa se impede o cadastro de um email já existente"""
    cadastrar_usuario("Maria Oliveira", "maria@email.com", "654321")
    resposta = cadastrar_usuario("Outra Pessoa", "maria@email.com", "outra_senha")
    assert "erro" in resposta
    assert resposta["erro"] == "Email já cadastrado!"
