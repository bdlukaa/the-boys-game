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
        def criar_heroi():
            exibir_snackbar("Herói criado!")

        def atualizar_heroi():
            exibir_snackbar("Herói atualizado!")

        herois = [
            {
                "id": 1,
                "real_name": "Bruce Wayne",
                "hero_name": "Batman",
                "gender": "Masculino",
                "height": 1.88,
                "weight": 95,
                "birth_date": "1939-05-19",
                "birth_place": "Gotham City",
                "strength_level": 85,
                "popularity": 90,
                "status": "Ativo",
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
            ft.DataColumn(ft.Text("")),  # Coluna vazia para ações
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
                                # Adicione a lógica para editar o herói aqui (ex: abrir um modal)
                                on_click=lambda e: exibir_snackbar(
                                    f"Editar Herói {heroi['id']}"
                                ),
                            )
                        ),
                    ]
                )
            )

        return ft.Container(
            ft.Column(
                [
                    ft.Row(
                        [
                            ft.Text("Gerenciar Heróis", theme_style="headlineSmall"),
                            ft.Text(
                                f"{len(herois)}", theme_style="bodySmall", expand=True
                            ),
                            ft.IconButton(
                                icon=ft.icons.ADD,
                                on_click=lambda _: criar_heroi(),
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
                    ft.DataTable(
                        columns=colunas,
                        rows=linhas,
                        column_spacing=40,
                    ),
                ],
            ),
            expand=True,
        )

    def crimes_view():
        def criar_crime():
            # Lógica para criar um crime (placeholder por enquanto)
            exibir_snackbar("Crime criado!")

        def atualizar_crime():
            # Lógica para atualizar um crime (placeholder por enquanto)
            exibir_snackbar("Crime atualizado!")

        crimes = [
            {
                "nome": "Roubo a banco",
                "descricao": "Roubo a banco central de Gotham City.",
                "data": "2024-11-20",
                "heroi_responsavel": "Batman",
                "severidade": 8,
            },
            {
                "nome": "Sequestro",
                "descricao": "Sequestro da filha do prefeito.",
                "data": "2024-11-18",
                "heroi_responsavel": "Mulher Maravilha",
                "severidade": 9,
            },
            # Adicione mais crimes aqui
        ]

        colunas = [
            ft.DataColumn(ft.Text("Nome")),
            ft.DataColumn(ft.Text("Descrição")),
            ft.DataColumn(ft.Text("Data")),
            ft.DataColumn(ft.Text("Herói Responsável")),
            ft.DataColumn(ft.Text("Severidade")),
            ft.DataColumn(ft.Text("")),  # Coluna vazia para ações
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
                                # Adicione a lógica para editar o crime aqui (ex: abrir um modal)
                                on_click=lambda e: exibir_snackbar(
                                    f"Editar Crime {crime['nome']}"
                                ),
                            )
                        ),
                    ]
                )
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
                                on_click=lambda _: criar_crime(),
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
                    ft.DataTable(
                        columns=colunas,
                        rows=linhas,
                        column_spacing=40,
                    ),
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
        def criar_missao():
            # Lógica para criar uma missão (placeholder por enquanto)
            exibir_snackbar("Missão criada!")

        def atualizar_missao():
            # Lógica para atualizar uma missão (placeholder por enquanto)
            exibir_snackbar("Missão atualizada!")

        missoes = [
            {
                "nome": "Salvar o mundo",
                "descricao": "Impedir o meteoro de colidir com a Terra.",
                "dificuldade": 10,
                "herois_designados": ["Batman", "Mulher Maravilha"],
                "resultado": "Sucesso",
                "recompensa": "Força + 5",
            },
            {
                "nome": "Resgatar reféns",
                "descricao": "Libertar os reféns do banco central.",
                "dificuldade": 7,
                "herois_designados": ["Batman"],
                "resultado": "Fracasso",
                "recompensa": "Popularidade - 10",
            },
            # Adicione mais missões aqui
        ]

        colunas = [
            ft.DataColumn(ft.Text("Nome")),
            ft.DataColumn(ft.Text("Descrição")),
            ft.DataColumn(ft.Text("Dificuldade")),
            ft.DataColumn(ft.Text("Heróis Designados")),
            ft.DataColumn(ft.Text("Resultado")),
            ft.DataColumn(ft.Text("Recompensa")),
            ft.DataColumn(ft.Text("")),  # Coluna vazia para ações
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
                                # Adicione a lógica para editar a missão aqui (ex: abrir um modal)
                                on_click=lambda e: exibir_snackbar(
                                    f"Editar Missão {missao['nome']}"
                                ),
                            )
                        ),
                    ]
                )
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
                                on_click=lambda _: criar_missao(),
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
                    ft.DataTable(
                        columns=colunas,
                        rows=linhas,
                        column_spacing=40,
                    ),
                ],
            ),
            expand=True,
        )

    change_content("home")


ft.app(target=main)
