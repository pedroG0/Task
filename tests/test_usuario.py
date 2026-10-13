
import json
import os
import pytest
import os
import sys
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
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

def test_carregar_usuarios_vazio():
    """Testa se o banco de dados retorna vazio inicialmente."""
    usuarios = UsuarioModel.carregar_usuarios()
    assert usuarios == []

def test_adicionar_usuario():
    """Testa se um novo usuário pode ser adicionado corretamente."""
    resultado = UsuarioModel.adicionar_usuario("João Silva", "joao@email.com", "123456")
    assert "mensagem" in resultado
    assert resultado["mensagem"] == "Usuário cadastrado com sucesso!"
    assert "id" in resultado

    # Verifica se o usuário foi salvo corretamente
    usuarios = UsuarioModel.carregar_usuarios()
    assert len(usuarios) == 1
    assert usuarios[0]["nome"] == "João Silva"
    assert usuarios[0]["email"] == "joao@email.com"

def test_adicionar_usuario_email_existente():
    """Testa se impede a adição de um usuário com o mesmo email."""
    UsuarioModel.adicionar_usuario("João Silva", "joao@email.com", "123456")
    resultado = UsuarioModel.adicionar_usuario("Outro Nome", "joao@email.com", "nova_senha")
    assert "erro" in resultado
    assert resultado["erro"] == "E-mail já cadastrado!"

def test_buscar_usuario_por_email():
    """Testa se encontra um usuário pelo email."""
    UsuarioModel.adicionar_usuario("Maria Oliveira", "maria@email.com", "654321")
    usuario = UsuarioModel.buscar_usuario_por_email("maria@email.com")
    assert usuario is not None
    assert usuario["nome"] == "Maria Oliveira"

def test_buscar_usuario_nao_existente():
    """Testa se retorna None ao buscar um email inexistente."""
    usuario = UsuarioModel.buscar_usuario_por_email("naoexiste@email.com")
    assert usuario is None

def test_gerar_hash_senha():
    """Testa se a função gera um hash corretamente."""
    senha = "minha_senha_segura"
    hash1 = UsuarioModel.gerar_hash_senha(senha)
    hash2 = UsuarioModel.gerar_hash_senha(senha)
    assert hash1 == hash2  # Mesmo input deve gerar o mesmo hash
    assert hash1 != "minha_senha_segura"  # O hash deve ser diferente da senha original

def test_verificar_login_sucesso():
    """Testa se o login é bem-sucedido com credenciais corretas."""
    UsuarioModel.adicionar_usuario("Carlos Souza", "carlos@email.com", "senha123")
    resultado = UsuarioModel.verificar_login("carlos@email.com", "senha123")
    assert "mensagem" in resultado
    assert resultado["mensagem"] == "Login bem-sucedido"

def test_verificar_login_senha_incorreta():
    """Testa se o login falha com senha errada."""
    UsuarioModel.adicionar_usuario("Ana Lima", "ana@email.com", "senha_correta")
    resultado = UsuarioModel.verificar_login("ana@email.com", "senha_errada")
    assert "erro" in resultado
    assert resultado["erro"] == "Senha incorreta"

def test_verificar_login_usuario_nao_existente():
    """Testa se o login falha para usuário inexistente."""
    resultado = UsuarioModel.verificar_login("inexistente@email.com", "qualquer_senha")
    assert "erro" in resultado
    assert resultado["erro"] == "Usuário não encontrado"

def test_buscar_usuario_por_id():
    """Testa se encontra um usuário pelo ID."""
    UsuarioModel.adicionar_usuario("José Silva", "jose@email.com", "abc123")
    usuario = UsuarioModel.buscar_usuario_por_email("jose@email.com")
    user_id = usuario["id"]
    
    usuario_encontrado = UsuarioModel.buscar_usuario_por_id(user_id)
    assert usuario_encontrado is not None
    assert usuario_encontrado["nome"] == "José Silva"

def test_buscar_usuario_por_id_inexistente():
    """Testa se retorna None ao buscar um ID inexistente."""
    usuario = UsuarioModel.buscar_usuario_por_id(9999)
    assert usuario is None
