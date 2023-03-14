import psycopg
print(psycopg)

class Usuario: #classe: representa o que é no mundo real -> nesse caso, o usuário
    def __init__(self,login,senha):
        self.login = login
        self.senha = senha

def existe(usuario):
    with psycopg.connect( #abre uma conexão com o postgresql e aloca hardware (memória)
        host="localhost", #ou 127.0.0.1
        dbname="programacao_em_BD_login_python",
        port=5432, #default
        user="postgres",
        password="123456"
    ) as conexao:
        with conexao.cursor() as cursor:
            cursor.execute(
                "SELECT * FROM tb_usuario WHERE login=%s AND senha=%s",
                (f'{usuario.login}', f'{usuario.senha}')
            )
            result = cursor.fetchone() #entrega a tupla do usuário (vazia ou não)
            return result != None #true or false, boolean

print(existe(Usuario('admin', 'admin')))
