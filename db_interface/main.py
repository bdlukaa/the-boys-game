import flet as ft  # Importa o framework Flet para construção de interfaces gráficas

# Função principal que inicializa o aplicativo
def main(page: ft.Page):
    """
    Configura a página principal do aplicativo, incluindo layout, navegação e seções dinâmicas

    Parâmetros:
    - page (ft.Page): Página principal fornecida pelo Flet
    """
    # Define o título da janela do aplicativo
    page.title = "Simulador de Batalhas"

    # Define o tema do aplicativo como escuro
    page.theme_mode = ft.ThemeMode.DARK

    # Define o espaçamento interno da página (em pixels)
    page.padding = 50

    # Define a altura e largura da janela do aplicativo (em pixels)
    page.window.height = 700
    page.window.width = 1000

    # Função para exibir uma mensagem temporária (snackbar)
    def exibir_snackbar(mensagem, tipo="info"):
        """
        Exibe uma mensagem temporária (snackbar) na parte inferior da página.

        Parâmetros:
        - mensagem (str): Texto da mensagem a ser exibida.
        - tipo (str): Tipo de mensagem. Pode ser:
          - "info": Mensagem informativa (cor azul).
          - "error": Mensagem de erro (cor vermelha).

        Comportamento:
        - Mostra o snackbar com o texto especificado.
        - Atualiza a interface para refletir a adição do snackbar.
        """
        # Configura o componente Snackbar com texto e estilo baseados no tipo de mensagem
        snack_bar = ft.SnackBar(
            ft.Text(mensagem, text_align=ft.TextAlign.CENTER),  # Texto da mensagem
            bgcolor=ft.colors.BLUE_GREY if tipo == "info" else ft.colors.RED,  # Cor de fundo
            width=300,  # Largura do snackbar
            behavior=ft.SnackBarBehavior.FLOATING,  # Estilo flutuante
        )
        # Adiciona o snackbar à sobreposição da página
        page.overlay.append(snack_bar)

        # Abre o snackbar para exibição
        snack_bar.open = True

        # Atualiza a página para refletir as alterações
        page.update()

    # Função para criar o menu de navegação lateral
    def navigation_rail():
        """
        Cria o menu lateral de navegação do aplicativo, permitindo a troca entre as seções

        Retorno:
        - ft.NavigationRail: Componente que representa o menu lateral de navegação

        Características:
        - Contém opções como Home, Heróis, Crimes, Batalhas e Missões
        - Permite alternar entre as seções ao clicar em um item
        """
        return ft.NavigationRail(
            selected_index=0,  # Define a primeira opção (Home) como selecionada por padrão
            expand_loose=True,  # Permite que o menu se expanda caso haja espaço suficiente
            label_type=ft.NavigationRailLabelType.ALL,  # Mostra ícones e rótulos no menu
            destinations=[
                # Cada item do menu representa uma seção do aplicativo

                # Opção "Home"
                ft.NavigationRailDestination(
                    icon=ft.icons.HOME_OUTLINED,  # Ícone para o estado não selecionado
                    selected_icon=ft.icons.HOME,  # Ícone para o estado selecionado
                    label="Home",  # Texto exibido no menu
                ),

                # Opção "Heróis"
                ft.NavigationRailDestination(
                    icon=ft.icons.PERSON_OUTLINED,  # Ícone padrão
                    selected_icon=ft.icons.PERSON,  # Ícone ao ser selecionado
                    label="Heróis",  # Rótulo exibido
                ),

                # Opção "Crimes"
                ft.NavigationRailDestination(
                    icon=ft.icons.WARNING_OUTLINED,  # Ícone padrão
                    selected_icon=ft.icons.WARNING,  # Ícone ao ser selecionado
                    label="Crimes",  # Rótulo exibido
                ),

                # Opção "Batalhas"
                ft.NavigationRailDestination(
                    icon=ft.icons.SPORTS_MMA,  # Ícone padrão
                    selected_icon=ft.icons.SPORTS_MMA,  # Ícone ao ser selecionado
                    label="Batalhas",  # Rótulo exibido
                ),

                # Opção "Missões"
                ft.NavigationRailDestination(
                    icon=ft.icons.TASK_OUTLINED,  # Ícone padrão
                    selected_icon=ft.icons.TASK,  # Ícone ao ser selecionado
                    label="Missões",  # Rótulo exibido
                ),
            ],
            # Configura a ação que ocorre ao selecionar uma opção
            on_change=lambda e: change_content(
                page.navigation_rail.destinations[e.control.selected_index].label
            ),
        )

    # Adiciona o menu lateral à página principal
    page.navigation_rail = navigation_rail()

    def change_content(route):
        """
        Atualiza o conteúdo principal da página com base na rota selecionada

        Parâmetros:
        - route (str): Nome da rota selecionada (ex.: "Home", "Heróis")

        Funcionalidade:
        - Mapeia o nome da rota para a função correspondente
        - Limpa as visualizações existentes e adiciona a nova visualização
        """
        # Converte o nome da rota para minúsculas
        route = route.lower()

        # Dicionário que mapeia os nomes das rotas para funções correspondentes
        rotas = {
            "home": home_view,  # Seção inicial
            "heróis": herois_view,  # Seção de heróis
            "crimes": crimes_view,  # Seção de crimes
            "batalhas": batalhas_view,  # Seção de batalhas
            "missões": missoes_view,  # Seção de missões
        }

        # Obtém a função correspondente à rota, ou utiliza "home_view" como padrão
        content_function = rotas.get(route, home_view)

        # Limpa as visualizações atuais da página
        page.views.clear()

        # Adiciona a nova visualização à página
        page.views.append(
            ft.View(
                "/",  # Define a rota base
                [
                    # Barra de título (AppBar) da página
                    ft.AppBar(
                        title=ft.Text("The Boys"),  # Título exibido no AppBar
                        bgcolor=ft.colors.TRANSPARENT,  # Fundo transparente
                        center_title=True,  # Centraliza o título
                    ),
                    # Layout principal da página com o menu lateral e conteúdo
                    ft.Row(
                        [
                            page.navigation_rail,  # Adiciona o menu lateral
                            ft.VerticalDivider(width=1),  # Linha divisória vertical
                            content_function(),  # Carrega o conteúdo correspondente à rota
                        ],
                        expand=True,  # Expande para ocupar todo o espaço disponível
                    ),
                ],
            )
        )

        # Atualiza a interface da página para refletir as mudanças
        page.update()

    def home_view():
        """
        Cria o layout para a tela inicial (Home) do aplicativo

        Retorno:
        - ft.Container: Componente que exibe uma mensagem de boas-vindas e um botão para iniciar o simulador
        """
        return ft.Container(
            # Coluna para organizar os elementos verticalmente
            ft.Column(
                [
                    # Texto de boas-vindas
                    ft.Text(
                        "Bem-vindo ao Simulador de Batalhas!",  # Mensagem inicial
                        theme_style="headlineMedium",  # Estilo de texto destacado
                    ),
                    # Botão para iniciar o simulador
                    ft.ElevatedButton(
                        "Iniciar Simulador",  # Texto exibido no botão
                        # Ação executada ao clicar no botão
                        on_click=lambda _: exibir_snackbar("Simulador iniciado!"),
                    ),
                ],
                # Alinha os elementos no centro verticalmente
                alignment=ft.MainAxisAlignment.CENTER,
                # Alinha os elementos no centro horizontalmente
                horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            ),
            # Centraliza todo o container na página
            alignment=ft.alignment.center,
            # Expande o container para ocupar todo o espaço disponível
            expand=True,
    )

    def herois_view():
        """
        Cria o layout para a seção de gerenciamento de heróis no aplicativo

        Funcionalidades:
        - Exibe uma lista de heróis em formato de tabela
        - Permite criar e atualizar heróis
        - Inclui botões de ação para manipulação de dados (ex.: editar heróis)

        Retorno:
        - ft.Container: Componente que exibe a tabela de heróis e botões de gerenciamento
        """
        # Função para simular a criação de um novo herói
        def criar_heroi():
            """
            Mostra uma mensagem indicando que um herói foi criado
            (A lógica para criação real pode ser implementada posteriormente)
            """
            exibir_snackbar("Herói criado!")

        # Função para simular a atualização de heróis
        def atualizar_heroi():
            """
            Mostra uma mensagem indicando que os heróis foram atualizados
            (A lógica para atualização real pode ser implementada posteriormente)
            """
            exibir_snackbar("Herói atualizado!")

        # Lista fictícia de heróis (dados de exemplo)
        herois = [
            {
                "id": 1,
                "real_name": "Bruce Wayne",  # Nome real do herói
                "hero_name": "Batman",  # Nome de herói
                "gender": "Masculino",  # Gênero
                "height": 1.88,  # Altura em metros
                "weight": 95,  # Peso em quilogramas
                "birth_date": "1939-05-19",  # Data de nascimento
                "birth_place": "Gotham City",  # Local de nascimento
                "strength_level": 85,  # Nível de força (0-100)
                "popularity": 90,  # Popularidade (0-100)
                "status": "Ativo",  # Status do herói
            },
            {
                "id": 2,
                "real_name": "Diana Prince",
                "hero_name": "Mulher Maravilha",
                "gender": "Feminino",
                "height": 1.80,
                "weight": 75,
                "birth_date": "1941-10-21",
                "birth_place": "Themyscira",
                "strength_level": 95,
                "popularity": 80,
                "status": "Ativo",
            },
        ]

        # Configuração das colunas da tabela
        colunas = [
            ft.DataColumn(ft.Text("ID")),  # Coluna para o ID do herói
            ft.DataColumn(ft.Text("Nome Real")),  # Coluna para o nome real
            ft.DataColumn(ft.Text("Nome de Herói")),  # Coluna para o nome de herói
            ft.DataColumn(ft.Text("Gênero")),  # Coluna para o gênero
            ft.DataColumn(ft.Text("Altura")),  # Coluna para a altura
            ft.DataColumn(ft.Text("Peso")),  # Coluna para o peso
            ft.DataColumn(ft.Text("Data de Nascimento")),  # Coluna para a data de nascimento
            ft.DataColumn(ft.Text("Local de Nascimento")),  # Coluna para o local de nascimento
            ft.DataColumn(ft.Text("Força")),  # Coluna para o nível de força
            ft.DataColumn(ft.Text("Popularidade")),  # Coluna para a popularidade
            ft.DataColumn(ft.Text("Status")),  # Coluna para o status
            ft.DataColumn(ft.Text("")),  # Coluna vazia para botões de ação
        ]

        # Criação das linhas da tabela com os dados dos heróis
        linhas = []
        for heroi in herois:
            linhas.append(
                ft.DataRow(
                    cells=[
                        ft.DataCell(ft.Text(heroi["id"])),  # Celula com o ID do herói
                        ft.DataCell(ft.Text(heroi["real_name"])),  # Celula com o nome real
                        ft.DataCell(ft.Text(heroi["hero_name"])),  # Celula com o nome de herói
                        ft.DataCell(ft.Text(heroi["gender"])),  # Celula com o gênero
                        ft.DataCell(ft.Text(heroi["height"])),  # Celula com a altura
                        ft.DataCell(ft.Text(heroi["weight"])),  # Celula com o peso
                        ft.DataCell(ft.Text(heroi["birth_date"])),  # Celula com a data de nascimento
                        ft.DataCell(ft.Text(heroi["birth_place"])),  # Celula com o local de nascimento
                        ft.DataCell(ft.Text(heroi["strength_level"])),  # Celula com o nível de força
                        ft.DataCell(ft.Text(heroi["popularity"])),  # Celula com a popularidade
                        ft.DataCell(ft.Text(heroi["status"])),  # Celula com o status
                        ft.DataCell(
                            ft.IconButton(
                                icon=ft.icons.EDIT,  # Botão com ícone de edição
                                tooltip="Editar Herói",  # Texto ao passar o mouse
                                # Simula a edição do herói
                                on_click=lambda e: exibir_snackbar(f"Editar Herói {heroi['id']}"),
                            )
                        ),
                    ]
                )
            )

        # Retorna o layout da seção de heróis
        return ft.Container(
            ft.Column(
                [
                    # Linha de título e botões de gerenciamento
                    ft.Row(
                        [
                            ft.Text("Gerenciar Heróis", theme_style="headlineSmall"),  # Título da seção
                            ft.Text(f"{len(herois)}", theme_style="bodySmall", expand=True),  # Quantidade de heróis
                            ft.IconButton(  # Botão para criar um novo herói
                                icon=ft.icons.ADD,
                                on_click=lambda _: criar_heroi(),
                                tooltip="Criar Herói",
                            ),
                            ft.IconButton(  # Botão para atualizar a lista de heróis
                                icon=ft.icons.REFRESH,
                                on_click=lambda _: atualizar_heroi(),
                                tooltip="Atualizar Heróis",
                            ),
                        ],
                        alignment=ft.MainAxisAlignment.START,  # Alinha os elementos no início da linha
                    ),
                    # Tabela com os dados dos heróis
                    ft.DataTable(
                        columns=colunas,  # Define as colunas da tabela
                        rows=linhas,  # Define as linhas com os dados
                        column_spacing=40,  # Espaçamento entre colunas
                    ),
                ],
            ),
            expand=True,  # Expande o container para preencher o espaço disponível
        )

    def crimes_view():
        """
        Cria o layout para a seção de gerenciamento de crimes

        Funcionalidades:
        - Exibe uma lista de crimes em formato de tabela
        - Permite criar e atualizar crimes
        - Inclui botões de ação para manipulação de dados (ex.: editar crimes)

        Retorno:
        - ft.Container: Componente que exibe a tabela de crimes e botões de gerenciamento
        """
        # Função para simular a criação de um crime
        def criar_crime():
            """
            Mostra uma mensagem indicando que um crime foi criado
            (A lógica para criação real pode ser implementada posteriormente)
            """
            exibir_snackbar("Crime criado!")

        # Função para simular a atualização de crimes
        def atualizar_crime():
            """
            Mostra uma mensagem indicando que os crimes foram atualizados
            (A lógica para atualização real pode ser implementada posteriormente)
            """
            exibir_snackbar("Crime atualizado!")

        # Lista fictícia de crimes
        crimes = [
            {
                "nome": "Roubo a banco",  # Nome do crime
                "descricao": "Roubo a banco central de Gotham City.",  # Descrição do crime
                "data": "2024-11-20",  # Data do crime
                "heroi_responsavel": "Batman",  # Herói responsável
                "severidade": 8,  # Nível de severidade (1 a 10)
            },
            {
                "nome": "Sequestro",
                "descricao": "Sequestro da filha do prefeito.",
                "data": "2024-11-18",
                "heroi_responsavel": "Mulher Maravilha",
                "severidade": 9,
            },
        ]

        # Configuração das colunas da tabela
        colunas = [
            ft.DataColumn(ft.Text("Nome")),  # Nome do crime
            ft.DataColumn(ft.Text("Descrição")),  # Descrição do crime
            ft.DataColumn(ft.Text("Data")),  # Data do crime
            ft.DataColumn(ft.Text("Herói Responsável")),  # Nome do herói responsável
            ft.DataColumn(ft.Text("Severidade")),  # Nível de severidade
            ft.DataColumn(ft.Text("")),  # Coluna para ações (botões)
        ]

        # Criação das linhas da tabela com os dados dos crimes
        linhas = []
        for crime in crimes:
            linhas.append(
                ft.DataRow(
                    cells=[
                        ft.DataCell(ft.Text(crime["nome"])),  # Nome do crime
                        ft.DataCell(ft.Text(crime["descricao"])),  # Descrição do crime
                        ft.DataCell(ft.Text(crime["data"])),  # Data do crime
                        ft.DataCell(ft.Text(crime["heroi_responsavel"])),  # Herói responsável
                        ft.DataCell(ft.Text(crime["severidade"])),  # Severidade do crime
                        ft.DataCell(
                            ft.IconButton(
                                icon=ft.icons.EDIT,  # Botão de edição
                                tooltip="Editar Crime",  # Dica ao passar o mouse
                                on_click=lambda e: exibir_snackbar(f"Editar Crime {crime['nome']}"),
                            )
                        ),
                    ]
                )
            )

        # Retorna o layout da seção de crimes
        return ft.Container(
            ft.Column(
                [
                    # Linha de título e botões de gerenciamento
                    ft.Row(
                        [
                            ft.Text("Gerenciar Crimes", theme_style="headlineSmall"),  # Título da seção
                            ft.Text(f"{len(crimes)} crimes", theme_style="bodySmall", expand=True),  # Quantidade de crimes
                            ft.IconButton(  # Botão para criar um novo crime
                                icon=ft.icons.ADD,
                                on_click=lambda _: criar_crime(),
                                tooltip="Criar Crime",
                            ),
                            ft.IconButton(  # Botão para atualizar a lista de crimes
                                icon=ft.icons.REFRESH,
                                on_click=lambda _: atualizar_crime(),
                                tooltip="Atualizar Crimes",
                            ),
                        ],
                        alignment=ft.MainAxisAlignment.START,  # Alinha os elementos no início da linha
                    ),
                    # Tabela com os dados dos crimes
                    ft.DataTable(
                        columns=colunas,  # Define as colunas da tabela
                        rows=linhas,  # Define as linhas com os dados
                        column_spacing=40,  # Espaçamento entre colunas
                    ),
                ],
            ),
            expand=True,  # Expande o container para preencher o espaço disponível
        )

    def batalhas_view():
        """
        Cria o layout para a seção de batalhas

        Funcionalidades:
        - Exibe um botão para iniciar uma simulação de batalhas

        Retorno:
        - ft.Container: Componente que exibe um título e um botão para iniciar simulações
        """
        return ft.Container(
            ft.Column(
                [
                    # Título da seção
                    ft.Text("Simulador de Batalhas", theme_style="headlineSmall"),
                    # Botão para iniciar uma simulação
                    ft.ElevatedButton(
                        "Iniciar Simulação",
                        on_click=lambda _: exibir_snackbar("Simulação iniciada!"),
                    ),
                ],
            ),
            expand=True,  # Expande o container para preencher o espaço disponível
        )

    def missoes_view():
        """
        Cria o layout para a seção de gerenciamento de missões

        Funcionalidades:
        - Exibe uma lista de missões em formato de tabela
        - Permite criar e atualizar missões
        - Inclui botões de ação para manipulação de dados (ex.: editar missões)

        Retorno:
        - ft.Container: Componente que exibe a tabela de missões e botões de gerenciamento
        """
        # Função para simular a criação de uma missão
        def criar_missao():
            """
            Mostra uma mensagem indicando que uma missão foi criada
            (A lógica para criação real pode ser implementada posteriormente)
            """
            exibir_snackbar("Missão criada!")

        # Função para simular a atualização de missões
        def atualizar_missao():
            """
            Mostra uma mensagem indicando que as missões foram atualizadas
            (A lógica para atualização real pode ser implementada posteriormente)
            """
            exibir_snackbar("Missão atualizada!")

        # Lista fictícia de missões
        missoes = [
            {
                "nome": "Salvar o mundo",  # Nome da missão
                "descricao": "Impedir o meteoro de colidir com a Terra.",  # Descrição da missão
                "dificuldade": 10,  # Nível de dificuldade (1 a 10)
                "herois_designados": ["Batman", "Mulher Maravilha"],  # Heróis envolvidos
                "resultado": "Sucesso",  # Resultado da missão
                "recompensa": "Força + 5",  # Recompensa da missão
            },
            {
                "nome": "Resgatar reféns",
                "descricao": "Libertar os reféns do banco central.",
                "dificuldade": 7,
                "herois_designados": ["Batman"],
                "resultado": "Fracasso",
                "recompensa": "Popularidade - 10",
            },
        ]

        # Configuração das colunas da tabela
        colunas = [
            ft.DataColumn(ft.Text("Nome")),  # Nome da missão
            ft.DataColumn(ft.Text("Descrição")),  # Descrição da missão
            ft.DataColumn(ft.Text("Dificuldade")),  # Dificuldade da missão
            ft.DataColumn(ft.Text("Heróis Designados")),  # Heróis envolvidos
            ft.DataColumn(ft.Text("Resultado")),  # Resultado da missão
            ft.DataColumn(ft.Text("Recompensa")),  # Recompensa obtida
            ft.DataColumn(ft.Text("")),  # Coluna para ações (botões)
        ]

        # Criação das linhas da tabela com os dados das missões
        linhas = []
        for missao in missoes:
            linhas.append(
                ft.DataRow(
                    cells=[
                        ft.DataCell(ft.Text(missao["nome"])),  # Nome da missão
                        ft.DataCell(ft.Text(missao["descricao"])),  # Descrição
                        ft.DataCell(ft.Text(missao["dificuldade"])),  # Dificuldade
                        ft.DataCell(ft.Text(", ".join(missao["herois_designados"]))),  # Heróis
                        ft.DataCell(ft.Text(missao["resultado"])),  # Resultado
                        ft.DataCell(ft.Text(missao["recompensa"])),  # Recompensa
                        ft.DataCell(
                            ft.IconButton(
                                icon=ft.icons.EDIT,  # Botão de edição
                                tooltip="Editar Missão",  # Texto ao passar o mouse
                                on_click=lambda e: exibir_snackbar(f"Editar Missão {missao['nome']}"),
                            )
                        ),
                    ]
                )
            )

        # Retorna o layout da seção de missões
        return ft.Container(
            ft.Column(
                [
                    # Linha de título e botões de gerenciamento
                    ft.Row(
                        [
                            ft.Text("Gerenciar Missões", theme_style="headlineSmall"),  # Título da seção
                            ft.Text(f"{len(missoes)} missões", theme_style="bodySmall", expand=True),  # Quantidade
                            ft.IconButton(  # Botão para criar uma nova missão
                                icon=ft.icons.ADD,
                                on_click=lambda _: criar_missao(),
                                tooltip="Criar Missão",
                            ),
                            ft.IconButton(  # Botão para atualizar a lista de missões
                                icon=ft.icons.REFRESH,
                                on_click=lambda _: atualizar_missao(),
                                tooltip="Atualizar Missões",
                            ),
                        ],
                        alignment=ft.MainAxisAlignment.START,  # Alinha os elementos no início da linha
                    ),
                    # Tabela com os dados das missões
                    ft.DataTable(
                        columns=colunas,  # Define as colunas da tabela
                        rows=linhas,  # Define as linhas com os dados
                        column_spacing=40,  # Espaçamento entre colunas
                    ),
                ],
            ),
            expand=True,  # Expande o container para preencher o espaço disponível
        )