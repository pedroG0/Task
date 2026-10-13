from models.usuario import UsuarioModel

def cadastrar_usuario(nome, email, senha):
    if UsuarioModel.buscar_usuario_por_email(email):
        return {"erro": "Email já cadastrado!"}
    
    novo_id = UsuarioModel.adicionar_usuario(nome, email, senha)
    return {"mensagem": "Usuário cadastrado com sucesso!", "id": novo_id}
