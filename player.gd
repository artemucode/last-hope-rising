extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

var speed = 200
var jump_force = 300
var gravity = 900


func _ready():
	anim.play("idle")


func _physics_process(delta):

	# Гравитация
	if not is_on_floor():
		velocity.y += gravity * delta


	# Движение
	velocity.x = 0

	if Input.is_action_pressed("player_left"):
		velocity.x = -speed

	elif Input.is_action_pressed("player_right"):
		velocity.x = speed


	# Прыжок
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = -jump_force


	# Анимации

	# Если персонаж в воздухе
	if not is_on_floor():
		anim.play("jump")


	# Если идёт
	elif velocity.x != 0:
		anim.play("walk")

		# Поворот спрайта
		if velocity.x < 0:
			anim.flip_h = true
		else:
			anim.flip_h = false


	# Если стоит
	else:
		anim.play("idle")


	# Движение
	move_and_slide()
