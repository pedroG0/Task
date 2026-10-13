import json
import os
import hashlib  # Para armazenar senhas de forma segura

class UsuarioModel:
    #FILE_PATH = "database/usuarios.json"
    FILE_PATH = os.path.join(os.path.dirname(__file__), "../database/usuarios.json")  # Caminho absoluto

    @staticmethod
    def carregar_usuarios():
        """Carrega os usuários do JSON"""
        if not os.path.exists(UsuarioModel.FILE_PATH):
            return []
        try:
            with open(UsuarioModel.FILE_PATH, "r", encoding="utf-8") as file:
                return json.load(file)
        except json.JSONDecodeError:
            return []

    @staticmethod
    def salvar_usuarios(usuarios):
        """Salva os usuários no JSON"""
        with open(UsuarioModel.FILE_PATH, "w", encoding="utf-8") as file:
            json.dump(usuarios, file, indent=4, ensure_ascii=False)

    @staticmethod
    def gerar_hash_senha(senha):
        """Gera um hash SHA256 da senha para segurança"""
        return hashlib.sha256(senha.encode()).hexdigest()

    @staticmethod
    def adicionar_usuario(nome, email, senha):
        """Adiciona um novo usuário, verificando se o email já existe"""
        usuarios = UsuarioModel.carregar_usuarios()

        # Verifica se o e-mail já está cadastrado
        for usuario in usuarios:
            if usuario["email"] == email:
                return {"erro": "E-mail já cadastrado!"}

        # Gera um novo ID baseado no maior ID existente
        novo_id = max([u["id"] for u in usuarios], default=1000) + 1

        # Criptografa a senha antes de salvar
        senha_hash = UsuarioModel.gerar_hash_senha(senha)

        # Adiciona o novo usuário
        usuarios.append({"id": novo_id, "nome": nome, "email": email, "senha": senha_hash})
        UsuarioModel.salvar_usuarios(usuarios)

        return {"mensagem": "Usuário cadastrado com sucesso!", "id": novo_id}

    @staticmethod
    def buscar_usuario_por_email(email):
        """Busca um usuário pelo email e retorna os dados"""
        usuarios = UsuarioModel.carregar_usuarios()
        for usuario in usuarios:
            if usuario["email"] == email:
                return usuario  # Retorna os dados do usuário
        return None  # Se não encontrar, retorna None

    @staticmethod
    def verificar_login(email, senha):
        """Verifica se o email e senha são válidos para login"""
        usuario = UsuarioModel.buscar_usuario_por_email(email)
        if not usuario:
            return {"erro": "Usuário não encontrado"}

        # Compara a senha informada com o hash armazenado
        senha_hash = UsuarioModel.gerar_hash_senha(senha)
        if usuario["senha"] != senha_hash:
            return {"erro": "Senha incorreta"}

        return {"mensagem": "Login bem-sucedido", "id": usuario["id"]}
        
    @staticmethod
    def buscar_usuario_por_id(user_id):
        """Busca um usuário pelo ID"""
        usuarios = UsuarioModel.carregar_usuarios()
        for usuario in usuarios:
            if str(usuario["id"]) == str(user_id):  # Comparação como string para evitar erros
                return usuario
        return None  # Retorna None se o usuário não for encontrado
