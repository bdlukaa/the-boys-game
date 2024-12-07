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