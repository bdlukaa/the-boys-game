import flet as ft


def main(page: ft.Page):
    page.title = "Simulador de Batalhas"
    page.theme_mode = ft.ThemeMode.DARK  # Definindo o tema escuro
    page.padding = 50
    page.window_height = 700
    page.window_width = 1000

    def exibir_snackbar(mensagem, tipo="info"):
        page.snack_bar = ft.SnackBar(
            ft.Text(mensagem),
            bgcolor=ft.colors.BLUE_GREY if tipo == "info" else ft.colors.RED,
        )
        page.snack_bar.open = True
        page.update()

    def rota_view(route):
        page.views.clear()
        page.views.append(
            ft.View(
                "/",
                [
                    ft.AppBar(
                        title=ft.Text("Simulador de Batalhas"),
                        bgcolor=ft.colors.SURFACE_VARIANT,
                    ),
                    ft.NavigationRail(
                        selected_index=(
                            0
                            if route == "/"
                            else (
                                1
                                if route == "/herois"
                                else 2 if route == "/crimes" else 3
                            )
                        ),
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
                                icon=ft.icons.FIGHT_OUTLINED,
                                selected_icon=ft.icons.FIGHT,
                                label="Batalhas",
                            ),
                        ],
                        on_change=lambda e: page.go(
                            page.navigation_rail.destinations[
                                e.control.selected_index
                            ].route
                        ),
                    ),
                    ft.VerticalDivider(width=1),
                    view_conteudo(route),
                ],
            )
        )
        page.update()

    def view_conteudo(route):
        if route == "/":
            return ft.Container(
                ft.Column(
                    [
                        ft.Text(
                            "Bem-vindo ao Simulador de Batalhas!",
                            style="headlineMedium",
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
            )
        elif route == "/herois":
            return ft.Container(
                ft.Column(
                    [
                        ft.Text("Gerenciar Heróis", style="headlineSmall"),
                        ft.ElevatedButton(
                            "Criar Herói",
                            on_click=lambda _: exibir_snackbar("Herói criado!"),
                        ),
                        ft.ElevatedButton(
                            "Editar Herói",
                            on_click=lambda _: exibir_snackbar("Herói editado!"),
                        ),
                        ft.ElevatedButton(
                            "Consultar Herói",
                            on_click=lambda _: exibir_snackbar("Herói consultado!"),
                        ),
                    ],
                ),
            )
        elif route == "/crimes":
            return ft.Container(
                ft.Column(
                    [
                        ft.Text("Gerenciar Crimes", style="headlineSmall"),
                        ft.ElevatedButton(
                            "Criar Crime",
                            on_click=lambda _: exibir_snackbar("Crime criado!"),
                        ),
                        ft.ElevatedButton(
                            "Editar Crime",
                            on_click=lambda _: exibir_snackbar("Crime editado!"),
                        ),
                        ft.ElevatedButton(
                            "Consultar Crime",
                            on_click=lambda _: exibir_snackbar("Crime consultado!"),
                        ),
                    ],
                ),
            )
        elif route == "/batalhas":
            return ft.Container(
                ft.Column(
                    [
                        ft.Text("Simulador de Batalhas", style="headlineSmall"),
                        ft.ElevatedButton(
                            "Iniciar Simulação",
                            on_click=lambda _: exibir_snackbar("Simulação iniciada!"),
                        ),
                    ],
                ),
            )

    page.navigation_rail = ft.NavigationRail(
        selected_index=0,
        label_type=ft.NavigationRailLabelType.ALL,
        destinations=[
            ft.NavigationRailDestination(
                icon=ft.icons.HOME_OUTLINED, selected_icon=ft.icons.HOME, label="Home"
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
                icon=ft.icons.FIGHT_OUTLINED,
                selected_icon=ft.icons.FIGHT,
                label="Batalhas",
            ),
        ],
        on_change=lambda e: rota_view(
            page.navigation_rail.destinations[e.control.selected_index].label
        ),  # usa o label para identificar a rota
    )

    page.add(
        ft.Row(
            [
                page.navigation_rail,
                ft.VerticalDivider(width=1),
                view_conteudo("/"),
            ],
            expand=True,
        )
    )


ft.app(target=main)
