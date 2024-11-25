import flet as ft

def main(page: ft.Page):
    page.title = "Simulador de Batalhas"
    page.theme_mode = ft.ThemeMode.DARK
    page.padding = 50
    page.window.height = 700
    page.window.width = 1000

    def exibir_snackbar(mensagem, tipo="info"):
        snack_bar = ft.SnackBar(
            ft.Text(mensagem),
            bgcolor=ft.colors.BLUE_GREY if tipo == "info" else ft.colors.RED,
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
        }
        content_function = rotas.get(route, home_view)
        page.views.clear()
        page.views.append(
            ft.View(
                "/",
                [
                    ft.AppBar(
                        title=ft.Text("Simulador de Batalhas"),
                        bgcolor=ft.colors.SURFACE_VARIANT,
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
        return ft.Container(
            ft.Column(
                [
                    ft.Text("Gerenciar Heróis", theme_style="headlineSmall"),
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
            expand=True,
        )

    def crimes_view():
        return ft.Container(
            ft.Column(
                [
                    ft.Text("Gerenciar Crimes", theme_style="headlineSmall"),
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

    change_content("home")

ft.app(target=main) 