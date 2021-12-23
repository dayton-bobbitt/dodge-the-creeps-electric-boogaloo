extends Node

export (PackedScene) var Mob
var score


func _ready():
	randomize()


func new_game():
	score = 0
	get_tree().call_group("mobs", "queue_free")
	$HUD.update_score(score)
	$HUD.show_temporary_message("Get ready!")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Music.play()


func start_game():
	$ScoreTimer.start()
	$MobTimer.start()


func end_game():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.game_over()
	$Music.stop()
	$DeathSound.play()


func spawn_enemy():
	$MobPath/MobSpawnLocation.offset = randi()
	
	var mob = Mob.instance()
	add_child(mob)
	
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)

	mob.rotation = direction
	mob.position = $MobPath/MobSpawnLocation.position
	
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)


func increment_score():
	score += 1
	$HUD.update_score(score)


func _on_Player_hit():
	end_game()


func _on_MobTimer_timeout():
	spawn_enemy()


func _on_ScoreTimer_timeout():
	increment_score()


func _on_StartTimer_timeout():
	start_game()


func _on_HUD_start_game():
	new_game()
