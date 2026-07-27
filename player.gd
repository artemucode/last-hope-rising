extends CharacterBody2D

var speed = 200
var jumpForce = 300  # Исправлено опечаточное название (было jumpForse)
var gravity = 900

# vel не нужна, используем встроенную velocity

@onready var imagePlayer = get_node("player")

func _physics_process(delta):
    # 1. Применяем гравитацию (если не на полу)
    if not is_on_floor():
        velocity.y += gravity * delta

    # 2. Горизонтальное движение (сброс перед вводом)
    velocity.x = 0
    if Input.is_action_pressed("player_left"):
        velocity.x -= speed
    elif Input.is_action_pressed("player_right"):
        velocity.x += speed

    # 3. Прыжок
    if Input.is_action_just_pressed("player_jump") and is_on_floor():
        velocity.y = -jumpForce

    # 4. Движение
    move_and_slide()

    if velocity.x < 0:
        imagePlayer.flip_h = true
    elif velocity.x > 0:
        imagePlayer.flip_h = false