# frozen_string_literal: true

require_relative 'dependencies'

# Comienzo del.juego 
# 1- Mensaje de bienvenida
#    - mostrar colores disponibles
# 2- Son uno o dos jugadores ?
#    - ingresa el nombre del jugador
#    - color de la pieza con que juega
#    - quitar el color seleccionado para el proximo jugador 
#    - implementar jugador autonomo
# 3- Dos jugadore 
#    - primer jugador nombre y color de la pieza con la que jugara
#    - segundo jugador repite paso anterior
# 4- Creamos la clase Tablero
# 5- Creamos la clase Game con sus argumentos
# 6- Ejecutamos el método

game_settings = GameSettings.new
game_settings.before_starting

game = Game.new(Board.new, game_settings.player_one, game_settings.player_two)
game.play
