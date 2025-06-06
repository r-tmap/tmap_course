library(shiny)

ui <- fluidPage(
	h2("My Shiny App"),
	textInput("txt", "Type something"),
	textOutput("output")
)

server <- function(input, output) {
	output$output <- renderText({
		paste("You typed:", input$txt)
	})
}

shinyApp(ui, server)


library(tmap)
library(spData)

tmap_mode("view")  ## enable interactive mode

tm_shape(World) +
	tm_polygons("continent")

library(shiny)
library(tmap)
library(spData)

tmap_mode("view")

vars = setdiff(names(World), c("iso_a3", "name", "sovereignt", "geometry"))

ui <- fluidPage(
	tmapOutput("map", height = 500),
	selectInput("var", choices = vars, label = "Variable")
)

server <- function(input, output) {
	output$map <- renderTmap({
		tm_shape(World) +
			tm_polygons(fill = input$var,
						fill.legend = tm_legend(position = tm_pos_out("right", "center"), width = 20))
	})
}

shinyApp(ui, server)



ui <- fluidPage(
	tmapOutput("map", height = 500),
	selectInput("var", choices = vars, label = "Variable")
)

server <- function(input, output) {
	output$map <- renderTmap({
		tm_shape(World) +
			tm_polygons(fill = input$var,
						fill.legend = tm_legend(position = tm_pos_out("right", "center"), width = 20))
	})
}

shinyApp(ui, server)




world_vars <- setdiff(names(World), c("iso_a3", "name", "sovereignt", "geometry"))
tmap_mode("view")
shinyApp(
	ui = fluidPage(
		tmapOutput("map", height = "600px"), selectInput("var", "Variable", world_vars)),
	server <- function(input, output, session) {
		output$map <- renderTmap({
			tm_shape(World, id = "iso_a3") + tm_polygons(fill = world_vars[1], zindex = 401)
		})
		observe({
			var <- input$var
			tmapProxy("map", session, {
				tm_remove_layer(401) +
					tm_shape(World, id = "iso_a3") +
					tm_polygons(fill = var, zindex = 401)
			})
		})
	}, options = list(launch.browser=TRUE)
)
