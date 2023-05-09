extends Node2D

onready var _round = $legendas/lblRound
onready var tempo = $legendas/rounds
onready var intervalo = $intervalo

var PRE_inimigo = preload("res://src/ingame/stage/minigame2/fighters/enemy.tscn")

var round_atual = 1
var fim_round = false
var _position

func _ready():
	Global.pos_fighter = $fighters/position.global_position

func _process(delta):
	contagem()
	_round.set_text(str("Round ",round_atual))

func rounds():
	$intervalo/intervalo.start()
	if (round_atual == 5):
		round_atual = 0
		get_tree().change_scene("res://src/interface/fim_prototipo.tscn")
	
func contagem():
	var minutes = tempo.time_left / 60
	var seconds = fmod(tempo.time_left, 60)
	var msg = "%02d:%02d" % [minutes, seconds]
	$legendas/lblTimer.set_text(msg)

func _on_tutorial_timer_timeout():
	$tutorial.hide()
	invocaMonkey()
	
	tempo.start()
	$fighters/delay.start()
	

func invocaMonkey():
	var enemies = get_tree().get_nodes_in_group("enemies").size()
	var inimigo = PRE_inimigo.instance()
	
	if(enemies != 3):
		get_parent().add_child(inimigo)
		inimigo.position = Global.pos_fighter

func perdeVida():
	$legendas/life.rect_size.x -= 70/10 #tam/(vida/dano) 
	
func _on_delay_timeout():
	Global.pos_fighter = $fighters/fighter.global_position

func _on_rounds_timeout():
	rounds()
	round_atual += 1
	
	intervalo.show()
	get_tree().paused = true
	
func _on_intervalo_timeout():
	invocaMonkey()
	intervalo.hide()
	get_tree().paused = false
