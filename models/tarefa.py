import json
import os

class TarefaModel:
    FILE_PATH = "database/tarefas.json"

    @staticmethod
    def carregar_tarefas():
        """Carrega todas as tarefas do JSON"""
        if not os.path.exists(TarefaModel.FILE_PATH):
            return {}
        with open(TarefaModel.FILE_PATH, "r", encoding="utf-8") as file:
            try:
                return json.load(file)
            except json.JSONDecodeError:
                return {}

    @staticmethod
    def salvar_tarefas(tarefas):
        """Salva as tarefas no JSON"""
        with open(TarefaModel.FILE_PATH, "w", encoding="utf-8") as file:
            json.dump(tarefas, file, indent=4, ensure_ascii=False)

    @staticmethod
    def obter_tarefas_usuario(user_id):
        """Obtém as tarefas do usuário ou cria uma estrutura vazia se não houver"""
        tarefas = TarefaModel.carregar_tarefas()

        user_id = str(user_id)  # Garante que o ID seja string para comparação

        if user_id not in tarefas:
            # Se o usuário não tiver tarefas, cria uma estrutura vazia
            tarefas[user_id] = {"todo": [], "doing": [], "done": []}
            TarefaModel.salvar_tarefas(tarefas)  # Salva no banco de dados para manter a estrutura

        return tarefas[user_id]  # Retorna as tarefas do usuário

    @staticmethod
    def adicionar_tarefa(user_id, descricao):
        """Adiciona uma nova tarefa para o usuário"""
        tarefas = TarefaModel.carregar_tarefas()
        user_id = str(user_id)

        if user_id not in tarefas:
            tarefas[user_id] = {"todo": [], "doing": [], "done": []}

        tarefas[user_id]["todo"].append(descricao)
        TarefaModel.salvar_tarefas(tarefas)

    @staticmethod
    def mover_tarefa(user_id, descricao, origem, destino):
        """Move uma tarefa entre colunas"""
        tarefas = TarefaModel.carregar_tarefas()
        user_id = str(user_id)

        if user_id in tarefas and descricao in tarefas[user_id][origem]:
            tarefas[user_id][origem].remove(descricao)
            tarefas[user_id][destino].append(descricao)
            TarefaModel.salvar_tarefas(tarefas)

    @staticmethod
    def excluir_tarefa(user_id, descricao):
        """Exclui uma tarefa do usuário"""
        tarefas = TarefaModel.carregar_tarefas()
        user_id = str(user_id)

        if user_id not in tarefas:
            return  # Se o usuário não tem tarefas, não há o que excluir

        for lista in ["todo", "doing", "done"]:
            if descricao in tarefas[user_id][lista]:
                tarefas[user_id][lista].remove(descricao)
                TarefaModel.salvar_tarefas(tarefas)
                return
