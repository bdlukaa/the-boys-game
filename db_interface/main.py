import flet as ft

def main(page: ft.Page):
    page.title = "Simulador de Batalhas"
    page.theme_mode = ft.ThemeMode.DARK
    page.padding = 50
    page.window.height = 700
    page.window.width = 1000

    def exibir_snackbar(mensagem, tipo="info"):
        snack_bar = ft.SnackBar(
            ft.Text(mensagem, text_align=ft.TextAlign.CENTER),
            bgcolor=ft.colors.BLUE_GREY if tipo == "info" else ft.colors.RED,
            width=300,
            behavior=ft.SnackBarBehavior.FLOATING,
        )
        page.overlay.append(snack_bar)
        snack_bar.open = True
        page.update()

    def navigation_rail():
        return ft.NavigationRail(
            selected_index=0,
            expand_loose=True,
            label_type=ft.NavigationRailLabelType.ALL,
            destinations=[
                ft.NavigationRailDestination(
                    icon=ft.icons.HOME_OUTLINED,
                    selected_icon=ft.icons.HOME,
                    label="Home",
                ),
                ft.NavigationRailDestination(
                    icon=ft.icons.PERSON_OUTLINED,
                    selected_icon=ft.icons.PERSON,
                    label="Heróis",
                ),
                ft.NavigationRailDestination(
                    icon=ft.icons.WARNING_OUTLINED,
                    selected_icon=ft.icons.WARNING,
                    label="Crimes",
                ),
                ft.NavigationRailDestination(
                    icon=ft.icons.SPORTS_MMA,
                    selected_icon=ft.icons.SPORTS_MMA,
                    label="Batalhas",
                ),
                ft.NavigationRailDestination(
                    icon=ft.icons.TASK_OUTLINED,
                    selected_icon=ft.icons.TASK,
                    label="Missões",
                ),
            ],
            on_change=lambda e: change_content(
                page.navigation_rail.destinations[e.control.selected_index].label
            ),
        )

    page.navigation_rail = navigation_rail()

    def change_content(route):
        route = route.lower()
        rotas = {
            "home": home_view,
            "heróis": herois_view,
            "crimes": crimes_view,
            "batalhas": batalhas_view,
            "missões": missoes_view,
        }
        content_function = rotas.get(route, home_view)
        page.views.clear()
        page.views.append(
            ft.View(
                "/",
                [
                    ft.AppBar(
                        title=ft.Text("The Boys"),
                        bgcolor=ft.colors.TRANSPARENT,
                        center_title=True,
                    ),
                    ft.Row(
                        [
                            page.navigation_rail,
                            ft.VerticalDivider(width=1),
                            content_function(),
                        ],
                        expand=True,
                    ),
                ],
            )
        )
        page.update()

    def home_view():
        return ft.Container(
            ft.Column(
                [
                    ft.Text(
                        "Bem-vindo ao Simulador de Batalhas!",
                        theme_style="headlineMedium",
                    ),
                    ft.ElevatedButton(
                        "Iniciar Simulador",
                        on_click=lambda _: exibir_snackbar("Simulador iniciado!"),
                    ),
                ],
                alignment=ft.MainAxisAlignment.CENTER,
                horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            ),
            alignment=ft.alignment.center,
            expand=True,
        )

    def herois_view():
        def criar_heroi(e):
            # Limpar os campos do diálogo
            for control in dlg_cria_heroi.content.controls:
                if isinstance(control, ft.TextField):
                    control.value = ""
            page.dialog = dlg_cria_heroi
            dlg_cria_heroi.open = True
            page.update()

        def salvar_heroi(e):
            # Obter os valores dos campos de texto
            novo_heroi = {
                "id": len(herois) + 1,  # Incrementar o ID
                "real_name": dlg_cria_heroi.content.controls[0].value,
                "hero_name": dlg_cria_heroi.content.controls[1].value,
                "gender": dlg_cria_heroi.content.controls[2].value,
                "height": float(dlg_cria_heroi.content.controls[3].value),
                "weight": float(dlg_cria_heroi.content.controls[4].value),
                "birth_date": dlg_cria_heroi.content.controls[5].value,
                "birth_place": dlg_cria_heroi.content.controls[6].value,
                "strength_level": int(dlg_cria_heroi.content.controls[7].value),
                "popularity": int(dlg_cria_heroi.content.controls[8].value),
                "status": dlg_cria_heroi.content.controls[9].value,
            }

            # Adicionar o novo herói à lista de heróis
            herois.append(novo_heroi)

            # Adicionar uma nova linha à tabela
            tabela_herois.rows.append(
                ft.DataRow(
                    cells=[
                        ft.DataCell(ft.Text(novo_heroi["id"])),
                        ft.DataCell(ft.Text(novo_heroi["real_name"])),
                        ft.DataCell(ft.Text(novo_heroi["hero_name"])),
                        ft.DataCell(ft.Text(novo_heroi["gender"])),
                        ft.DataCell(ft.Text(novo_heroi["height"])),
                        ft.DataCell(ft.Text(novo_heroi["weight"])),
                        ft.DataCell(ft.Text(novo_heroi["birth_date"])),
                        ft.DataCell(ft.Text(novo_heroi["birth_place"])),
                        ft.DataCell(ft.Text(novo_heroi["strength_level"])),
                        ft.DataCell(ft.Text(novo_heroi["popularity"])),
                        ft.DataCell(ft.Text(novo_heroi["status"])),
                        ft.DataCell(
                            ft.IconButton(
                                icon=ft.icons.EDIT,
                                tooltip="Editar Herói",
                                on_click=lambda e: exibir_snackbar(
                                    f"Editar Herói {novo_heroi['id']}"
                                ),
                            )
                        ),
                    ]
                )
            )

            # Fechar o diálogo
            dlg_cria_heroi.open = False

            # Atualizar a página
            page.update()

        def atualizar_heroi():
            exibir_snackbar("Herói atualizado!")

        herois = [
            {
                "id": 1,
                "real_name": "John Gillman",
                "hero_name": "Homelander",
                "gender": "Masculino",
                "height": 1.83,
                "weight": 95,
                "birth_date": "1979-06-19",
                "birth_place": "Laboratório Vought",
                "strength_level": 99,
                "popularity": 70,
                "status": "Ativo",
            },
            {
                "id": 2,
                "real_name": "Annie January",
                "hero_name": "Starlight",
                "gender": "Feminino",
                "height": 1.68,
                "weight": 60,
                "birth_date": "1993-04-05",
                "birth_place": "Des Moines, Iowa",
                "strength_level": 80,
                "popularity": 85,
                "status": "Ativo",
            },
            {
                "id": 3,
                "real_name": "Billy Butcher",
                "hero_name": "Butcher",
                "gender": "Masculino",
                "height": 1.80,
                "weight": 85,
                "birth_date": "1975-03-12",
                "birth_place": "Londres, Inglaterra",
                "strength_level": 70,
                "popularity": 60,
                "status": "Ativo",
            },
            {
                "id": 4,
                "real_name": "Hughie Campbell",
                "hero_name": "Wee Hughie",
                "gender": "Masculino",
                "height": 1.75,
                "weight": 70,
                "birth_date": "1990-08-21",
                "birth_place": "Nova York, EUA",
                "strength_level": 50,
                "popularity": 65,
                "status": "Ativo",
            },
            {
                "id": 5,
                "real_name": "Kevin Moskowitz",
                "hero_name": "The Deep",
                "gender": "Masculino",
                "height": 1.80,  # Valor estimado
                "weight": 90,  # Valor estimado
                "birth_date": "1988-07-10",  # Data aproximada
                "birth_place": "Sandusky, Ohio",
                "strength_level": 65,
                "popularity": 40,
                "status": "Ativo",
            },
            {
                "id": 6,
                "real_name": "Queen Maeve",
                "hero_name": "Queen Maeve",
                "gender": "Feminino",
                "height": 1.75,  # Valor estimado
                "weight": 75,  # Valor estimado
                "birth_date": "1980-05-15",  # Data aproximada
                "birth_place": "Desconhecido",
                "strength_level": 85,
                "popularity": 75,
                "status": "Ativo",
            },
            {
                "id": 7,
                "real_name": "Reggie Franklin",
                "hero_name": "A-Train",
                "gender": "Masculino",
                "height": 1.78,  # Valor estimado
                "weight": 80,  # Valor estimado
                "birth_date": "1989-11-20",  # Data aproximada
                "birth_place": "Desconhecido",
                "strength_level": 70,
                "popularity": 50,
                "status": "Ativo",
            },
            {
                "id": 8,
                "real_name": "Marvin T. Milk",
                "hero_name": "Mother's Milk",
                "gender": "Masculino",
                "height": 1.85,  # Valor estimado
                "weight": 100,  # Valor estimado
                "birth_date": "1978-06-02",  # Data aproximada
                "birth_place": "Desconhecido",
                "strength_level": 60,
                "popularity": 55,
                "status": "Ativo",
            },
            {
                "id": 9,
                "real_name": "Frenchie",
                "hero_name": "Frenchie",
                "gender": "Masculino",
                "height": 1.70,  # Valor estimado
                "weight": 70,  # Valor estimado
                "birth_date": "1976-04-08",  # Data aproximada
                "birth_place": "Desconhecido",
                "strength_level": 55,
                "popularity": 50,
                "status": "Ativo",
            },
            {
                "id": 10,
                "real_name": "Kimiko Miyashiro",
                "hero_name": "The Female",
                "gender": "Feminino",
                "height": 1.65,  # Valor estimado
                "weight": 60,  # Valor estimado
                "birth_date": "1991-09-15",  # Data aproximada
                "birth_place": "Japão",
                "strength_level": 80,
                "popularity": 60,
                "status": "Ativo",
            },
        ]

        colunas = [
            ft.DataColumn(ft.Text("ID")),
            ft.DataColumn(ft.Text("Nome Real")),
            ft.DataColumn(ft.Text("Nome de Herói")),
            ft.DataColumn(ft.Text("Gênero")),
            ft.DataColumn(ft.Text("Altura")),
            ft.DataColumn(ft.Text("Peso")),
            ft.DataColumn(ft.Text("Data de Nascimento")),
            ft.DataColumn(ft.Text("Local de Nascimento")),
            ft.DataColumn(ft.Text("Força")),
            ft.DataColumn(ft.Text("Popularidade")),
            ft.DataColumn(ft.Text("Status")),
            ft.DataColumn(ft.Text("")),
        ]

        linhas = []
        for heroi in herois:
            linhas.append(
                ft.DataRow(
                    cells=[
                        ft.DataCell(ft.Text(heroi["id"])),
                        ft.DataCell(ft.Text(heroi["real_name"])),
                        ft.DataCell(ft.Text(heroi["hero_name"])),
                        ft.DataCell(ft.Text(heroi["gender"])),
                        ft.DataCell(ft.Text(heroi["height"])),
                        ft.DataCell(ft.Text(heroi["weight"])),
                        ft.DataCell(ft.Text(heroi["birth_date"])),
                        ft.DataCell(ft.Text(heroi["birth_place"])),
                        ft.DataCell(ft.Text(heroi["strength_level"])),
                        ft.DataCell(ft.Text(heroi["popularity"])),
                        ft.DataCell(ft.Text(heroi["status"])),
                        ft.DataCell(
                            ft.IconButton(
                                icon=ft.icons.EDIT,
                                tooltip="Editar Herói",
                                on_click=lambda e: exibir_snackbar(
                                    f"Editar Herói {heroi['id']}"
                                ),
                            )
                        ),
                    ]
                )
            )

        dlg_cria_heroi = ft.AlertDialog(
            title=ft.Text("Novo Herói"),
            content=ft.Column(
                [
                    ft.TextField(label="Nome Real"),
                    ft.TextField(label="Nome de Herói"),
                    ft.TextField(label="Gênero"),
                    ft.TextField(label="Altura"),
                    ft.TextField(label="Peso"),
                    ft.TextField(label="Data de Nascimento"),
                    ft.TextField(label="Local de Nascimento"),
                    ft.TextField(label="Força"),
                    ft.TextField(label="Popularidade"),
                    ft.TextField(label="Status"),
                ]
            ),
            actions=[
                ft.TextButton(
                    "Cancelar", on_click=lambda e: page.close(dlg_cria_heroi)
                ),
                ft.TextButton("Criar", on_click=salvar_heroi),
            ],
            on_dismiss=lambda e: print("Dialog dismissed!"),
        )

        tabela_herois = ft.DataTable(
            columns=colunas,
            rows=linhas,
            column_spacing=40,
        )
        
        return ft.Container(
            ft.ListView(
                [
                    ft.Row(
                        [
                            ft.Text("Gerenciar Heróis", theme_style="headlineSmall"),
                            ft.Text(
                                f"{len(herois)}", theme_style="bodySmall", expand=True
                            ),
                            ft.IconButton(
                                icon=ft.icons.ADD,
                                on_click=criar_heroi,
                                tooltip="Criar Herói",
                            ),
                            ft.IconButton(
                                icon=ft.icons.REFRESH,
                                on_click=lambda _: atualizar_heroi(),
                                tooltip="Atualizar Heróis",
                            ),
                        ],
                        alignment=ft.MainAxisAlignment.START,
                    ),
                    tabela_herois,
                ],
            ),
            expand=True,
        )

    def crimes_view():
        def criar_crime(e):
            # Limpar os campos do diálogo
            for control in dlg_cria_crime.content.controls:
                if isinstance(control, ft.TextField):
                    control.value = ""
            page.dialog = dlg_cria_crime
            dlg_cria_crime.open = True
            page.update()

        def salvar_crime(e):
            # Obter os valores dos campos de texto
            novo_crime = {
                "nome": dlg_cria_crime.content.controls[0].value,
                "descricao": dlg_cria_crime.content.controls[1].value,
                "data": dlg_cria_crime.content.controls[2].value,
                "heroi_responsavel": dlg_cria_crime.content.controls[3].value,
                "severidade": int(dlg_cria_crime.content.controls[4].value),
            }

            # Adicionar o novo crime à lista de crimes
            crimes.append(novo_crime)

            # Adicionar uma nova linha à tabela
            tabela_crimes.rows.append(
                ft.DataRow(
                    cells=[
                        ft.DataCell(ft.Text(novo_crime["nome"])),
                        ft.DataCell(ft.Text(novo_crime["descricao"])),
                        ft.DataCell(ft.Text(novo_crime["data"])),
                        ft.DataCell(ft.Text(novo_crime["heroi_responsavel"])),
                        ft.DataCell(ft.Text(novo_crime["severidade"])),
                        ft.DataCell(
                            ft.IconButton(
                                icon=ft.icons.EDIT,
                                tooltip="Editar Crime",
                                on_click=lambda e: exibir_snackbar(
                                    f"Editar Crime {novo_crime['nome']}"
                                ),
                            )
                        ),
                    ]
                )
            )

            # Fechar o diálogo
            dlg_cria_crime.open = False

            # Atualizar a página
            page.update()

        def atualizar_crime():
            exibir_snackbar("Crime atualizado!")

        crimes = [
            {
                "nome": "Destruição do avião",
                "descricao": "Homelander intencionalmente não salvou o avião, causando a morte de todos a bordo.",
                "data": "2024-10-20",
                "heroi_responsavel": "Homelander",
                "severidade": 10,
            },
            {
                "nome": "Assassinato de Madelyn Stillwell",
                "descricao": "Homelander matou Madelyn Stillwell após descobrir suas mentiras.",
                "data": "2024-10-18",
                "heroi_responsavel": "Homelander",
                "severidade": 9,
            },
            {
                "nome": "Ataque terrorista",
                "descricao": "Homelander ataca civis em um protesto.",
                "data": "2024-11-05",
                "heroi_responsavel": "Homelander",
                "severidade": 10,
            },
            {
                "nome": "Consumo de drogas",
                "descricao": "A-Train usa Composto V para melhorar sua velocidade, colocando em risco sua saúde.",
                "data": "2024-11-10",
                "heroi_responsavel": "A-Train",
                "severidade": 7,
            },
            {
                "nome": "Assédio sexual",
                "descricao": "The Deep assedia Starlight em seu primeiro dia na equipe.",
                "data": "2024-10-15",
                "heroi_responsavel": "The Deep",
                "severidade": 8,
            },
            {
                "nome": "Negligência",
                "descricao": "Queen Maeve falha em impedir um acidente de trânsito por medo de se expor.",
                "data": "2024-11-01",
                "heroi_responsavel": "Queen Maeve",
                "severidade": 6,
            },
            {
                "nome": "Abuso de poder",
                "descricao": "Homelander usa seus poderes para intimidar e manipular pessoas.",
                "data": "2024-10-25",
                "heroi_responsavel": "Homelander",
                "severidade": 8,
            },
            {
                "nome": "Violência contra animais",
                "descricao": "The Deep maltrata animais marinhos em diversas ocasiões.",
                "data": "2024-11-08",
                "heroi_responsavel": "The Deep",
                "severidade": 5,
            },
            {
                "nome": "Corrupção",
                "descricao": "Vought encobre crimes e ações ilegais dos heróis em troca de lucro.",
                "data": "2024-10-16",
                "heroi_responsavel": "Vought",
                "severidade": 9,
            },
            {
                "nome": "Manipulação da mídia",
                "descricao": "Vought manipula a mídia para controlar a imagem pública dos heróis.",
                "data": "2024-10-28",
                "heroi_responsavel": "Vought",
                "severidade": 7,
            },
        ]

        colunas = [
            ft.DataColumn(ft.Text("Nome")),
            ft.DataColumn(ft.Text("Descrição")),
            ft.DataColumn(ft.Text("Data")),
            ft.DataColumn(ft.Text("Herói Responsável")),
            ft.DataColumn(ft.Text("Severidade")),
            ft.DataColumn(ft.Text("")),
        ]

        linhas = []
        for crime in crimes:
            linhas.append(
                ft.DataRow(
                    cells=[
                        ft.DataCell(ft.Text(crime["nome"])),
                        ft.DataCell(ft.Text(crime["descricao"])),
                        ft.DataCell(ft.Text(crime["data"])),
                        ft.DataCell(ft.Text(crime["heroi_responsavel"])),
                        ft.DataCell(ft.Text(crime["severidade"])),
                        ft.DataCell(
                            ft.IconButton(
                                icon=ft.icons.EDIT,
                                tooltip="Editar Crime",
                                on_click=lambda e: exibir_snackbar(
                                    f"Editar Crime {crime['nome']}"
                                ),
                            )
                        ),
                    ]
                )
            )

        dlg_cria_crime = ft.AlertDialog(
            title=ft.Text("Novo Crime"),
            content=ft.Column(
                [
                    ft.TextField(label="Nome"),
                    ft.TextField(label="Descrição"),
                    ft.TextField(label="Data"),
                    ft.TextField(label="Herói Responsável"),
                    ft.TextField(label="Severidade"),
                ]
            ),
            actions=[
                ft.TextButton(
                    "Cancelar", on_click=lambda e: page.close(dlg_cria_crime)
                ),
                ft.TextButton("Criar", on_click=salvar_crime),
            ],
            on_dismiss=lambda e: print("Dialog dismissed!"),
        )

        tabela_crimes = ft.DataTable(
            columns=colunas,
            rows=linhas,
            column_spacing=40,
        )

        return ft.Container(
            ft.Column(
                [
                    ft.Row(
                        [
                            ft.Text("Gerenciar Crimes", theme_style="headlineSmall"),
                            ft.Text(
                                f"{len(crimes)} crimes",
                                theme_style="bodySmall",
                                expand=True,
                            ),
                            ft.IconButton(
                                icon=ft.icons.ADD,
                                on_click=criar_crime,
                                tooltip="Criar Crime",
                            ),
                            ft.IconButton(
                                icon=ft.icons.REFRESH,
                                on_click=lambda _: atualizar_crime(),
                                tooltip="Atualizar Crimes",
                            ),
                        ],
                        alignment=ft.MainAxisAlignment.START,
                    ),
                    tabela_crimes
                ],
            ),
            expand=True,
        )

    def batalhas_view():
        return ft.Container(
            ft.Column(
                [
                    ft.Text("Simulador de Batalhas", theme_style="headlineSmall"),
                    ft.ElevatedButton(
                        "Iniciar Simulação",
                        on_click=lambda _: exibir_snackbar("Simulação iniciada!"),
                    ),
                ],
            ),
            expand=True,
        )

    def missoes_view():
        def criar_missao(e):
            # Limpar os campos do diálogo
            for control in dlg_cria_missao.content.controls:
                if isinstance(control, ft.TextField):
                    control.value = ""
            page.dialog = dlg_cria_missao
            dlg_cria_missao.open = True
            page.update()

        def salvar_missao(e):
            # Obter os valores dos campos de texto
            nova_missao = {
                "nome": dlg_cria_missao.content.controls[0].value,
                "descricao": dlg_cria_missao.content.controls[1].value,
                "dificuldade": int(dlg_cria_missao.content.controls[2].value),
                "herois_designados": dlg_cria_missao.content.controls[3].value.split(","),
                "resultado": dlg_cria_missao.content.controls[4].value,
                "recompensa": dlg_cria_missao.content.controls[5].value,
            }

            # Adicionar a nova missão à lista de missões
            missoes.append(nova_missao)

            # Adicionar uma nova linha à tabela
            tabela_missoes.rows.append(
                ft.DataRow(
                    cells=[
                        ft.DataCell(ft.Text(nova_missao["nome"])),
                        ft.DataCell(ft.Text(nova_missao["descricao"])),
                        ft.DataCell(ft.Text(nova_missao["dificuldade"])),
                        ft.DataCell(ft.Text(", ".join(nova_missao["herois_designados"]))),
                        ft.DataCell(ft.Text(nova_missao["resultado"])),
                        ft.DataCell(ft.Text(nova_missao["recompensa"])),
                        ft.DataCell(
                            ft.IconButton(
                                icon=ft.icons.EDIT,
                                tooltip="Editar Missão",
                                on_click=lambda e: exibir_snackbar(
                                    f"Editar Missão {nova_missao['nome']}"
                                ),
                            )
                        ),
                    ]
                )
            )

            # Fechar o diálogo
            dlg_cria_missao.open = False

            # Atualizar a página
            page.update()

        def atualizar_missao():
            exibir_snackbar("Missão atualizada!")

        missoes = [
            {
                "nome": "Infiltração na Igreja Coletiva",
                "descricao": "Starlight se infiltra na Igreja Coletiva para obter informações.",
                "dificuldade": 7,
                "herois_designados": ["Starlight"],
                "resultado": "Sucesso",
                "recompensa": "Popularidade + 15",
            },
            {
                "nome": "Resgate de reféns no banco",
                "descricao": "Os Sete tentam resgatar reféns em um assalto a banco.",
                "dificuldade": 8,
                "herois_designados": ["Homelander", "Queen Maeve", "A-Train", "The Deep", "Black Noir"],
                "resultado": "Fracasso parcial",
                "recompensa": "Popularidade - 5",
            },
            {
                "nome": "Impedir ataque terrorista",
                "descricao": "Homelander impede um ataque terrorista em Nova York.",
                "dificuldade": 9,
                "herois_designados": ["Homelander"],
                "resultado": "Sucesso",
                "recompensa": "Popularidade + 20",
            },
            {
                "nome": "Desativar bomba",
                "descricao": "Frenchie desativa uma bomba em um prédio do governo.",
                "dificuldade": 6,
                "herois_designados": ["Frenchie"],
                "resultado": "Sucesso",
                "recompensa": "Nenhuma",
            },
            {
                "nome": "Resgatar pessoas de incêndio",
                "descricao": "Starlight e Queen Maeve resgatam pessoas de um incêndio em um hospital.",
                "dificuldade": 8,
                "herois_designados": ["Starlight", "Queen Maeve"],
                "resultado": "Sucesso",
                "recompensa": "Popularidade + 10",
            },
            {
                "nome": "Capturar super-terrorista",
                "descricao": "Homelander e Black Noir capturam um super-terrorista em fuga.",
                "dificuldade": 10,
                "herois_designados": ["Homelander", "Black Noir"],
                "resultado": "Sucesso",
                "recompensa": "Popularidade + 15",
            },
            {
                "nome": "Investigar atividades suspeitas",
                "descricao": "Butcher e Hughie investigam atividades suspeitas da Vought.",
                "dificuldade": 5,
                "herois_designados": ["Butcher", "Hughie"],
                "resultado": "Sucesso",
                "recompensa": "Informação valiosa",
            },
            {
                "nome": "Proteger o presidente",
                "descricao": "Homelander e Queen Maeve protegem o presidente durante um evento público.",
                "dificuldade": 7,
                "herois_designados": ["Homelander", "Queen Maeve"],
                "resultado": "Sucesso",
                "recompensa": "Reconhecimento do governo",
            },
            {
                "nome": "Encontrar cura para o Composto V",
                "descricao": "Mother's Milk e Frenchie procuram uma cura para o Composto V.",
                "dificuldade": 9,
                "herois_designados": ["Mother's Milk", "Frenchie"],
                "resultado": "Fracasso",
                "recompensa": "Nenhuma",
            },
            {
                "nome": "Libertar a Female",
                "descricao": "Butcher e Hughie libertam a Female de um laboratório da Vought.",
                "dificuldade": 6,
                "herois_designados": ["Butcher", "Hughie"],
                "resultado": "Sucesso",
                "recompensa": "Aliança com a Female",
            },
        ]

        colunas = [
            ft.DataColumn(ft.Text("Nome")),
            ft.DataColumn(ft.Text("Descrição")),
            ft.DataColumn(ft.Text("Dificuldade")),
            ft.DataColumn(ft.Text("Heróis Designados")),
            ft.DataColumn(ft.Text("Resultado")),
            ft.DataColumn(ft.Text("Recompensa")),
            ft.DataColumn(ft.Text("")),
        ]

        linhas = []
        for missao in missoes:
            linhas.append(
                ft.DataRow(
                    cells=[
                        ft.DataCell(ft.Text(missao["nome"])),
                        ft.DataCell(ft.Text(missao["descricao"])),
                        ft.DataCell(ft.Text(missao["dificuldade"])),
                        ft.DataCell(ft.Text(", ".join(missao["herois_designados"]))),
                        ft.DataCell(ft.Text(missao["resultado"])),
                        ft.DataCell(ft.Text(missao["recompensa"])),
                        ft.DataCell(
                            ft.IconButton(
                                icon=ft.icons.EDIT,
                                tooltip="Editar Missão",
                                on_click=lambda e: exibir_snackbar(
                                    f"Editar Missão {missao['nome']}"
                                ),
                            )
                        ),
                    ]
                )
            )

        dlg_cria_missao = ft.AlertDialog(
            title=ft.Text("Nova Missão"),
            content=ft.Column(
                [
                    ft.TextField(label="Nome"),
                    ft.TextField(label="Descrição"),
                    ft.TextField(label="Dificuldade"),
                    ft.TextField(label="Heróis Designados (separados por vírgula)"),
                    ft.TextField(label="Resultado"),
                    ft.TextField(label="Recompensa"),
                ]
            ),
            actions=[
                ft.TextButton(
                    "Cancelar", on_click=lambda e: page.close(dlg_cria_missao)
                ),
                ft.TextButton("Criar", on_click=salvar_missao),
            ],
            on_dismiss=lambda e: print("Dialog dismissed!"),
        )

        tabela_missoes = ft.DataTable(
            columns=colunas,
            rows=linhas,
            column_spacing=40,
        )

        return ft.Container(
            ft.Column(
                [
                    ft.Row(
                        [
                            ft.Text("Gerenciar Missões", theme_style="headlineSmall"),
                            ft.Text(
                                f"{len(missoes)} missões",
                                theme_style="bodySmall",
                                expand=True,
                            ),
                            ft.IconButton(
                                icon=ft.icons.ADD,
                                on_click=criar_missao,
                                tooltip="Criar Missão",
                            ),
                            ft.IconButton(
                                icon=ft.icons.REFRESH,
                                on_click=lambda _: atualizar_missao(),
                                tooltip="Atualizar Missões",
                            ),
                        ],
                        alignment=ft.MainAxisAlignment.START,
                    ),
                    tabela_missoes
                ],
            ),
            expand=True,
        )

    change_content("home")

ft.app(target=main)