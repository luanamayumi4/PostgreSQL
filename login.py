import psycopg
# print(psycopg)

class Usuario: #classe: representa o que é no mundo real -> nesse caso, o usuário
    def __init__(self,login,senha):
        self.login = login
        self.senha = senha

def existe(usuario):
    with psycopg.connect( #abre uma conexão com o postgresql e aloca hardware -> memória
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

# print(existe(Usuario('admin', 'admin'))) -> apenas para verificarmos a função 

#0-Sair
#1-Login
#2-Logoff

def menu():
    texto = '0-Fechar sistema\n1-Login\n2-Logoff\n'
    usuario = None
    opcao = int(input(texto))
    while opcao !=0:
        if opcao ==1:
            login = input("Digite seu login\n")
            senha = input("Digite sua senha\n")
            usuario = Usuario(login,senha)

# expresão condicional (if/else de uma linha só)
            print("Usuário OK!" if existe(usuario) else "Usuário NOK!") 

        elif opcao ==2:
            usuario = None
            print("Logoff realizado com sucesso")
  
        elif opcao ==3:
            login = input("Digite seu login\n")
            senha = input("Digite sua senha\n")
            novoUsuario = Usuario(login,senha)
            print("Novo usuário OK!" if existe(novoUsuario) else "Novo usuário NOK!")
        
    else:
        print("Até mais")

    opcao = int(input(texto))


# chamamos a função menu
menu()

        
    
            
 
