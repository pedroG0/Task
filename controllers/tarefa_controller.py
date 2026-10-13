from models.tarefa import TarefaModel

def obter_tarefas(user_id):
    return TarefaModel.obter_tarefas_usuario(user_id)

def adicionar_tarefa(user_id, descricao):
    TarefaModel.adicionar_tarefa(user_id, descricao)
    return {"mensagem": "Tarefa adicionada com sucesso"}

def mover_tarefa(user_id, descricao, origem, destino):
    TarefaModel.mover_tarefa(user_id, descricao, origem, destino)
    return {"mensagem": "Tarefa movida com sucesso"}

def excluir_tarefa(user_id, descricao):
    TarefaModel.excluir_tarefa(user_id, descricao)
    return {"mensagem": "Tarefa excluída com sucesso"}
