extends KinematicBody

export var speed: float = 10.0
export var jump_force: float = 500

var _direction: Vector3 = Vector3.ZERO
var _jump: bool = false
var _run: bool = false
var _typing: bool = false

var _h_acc: float = 20
var _h_vel: Vector3 = Vector3.ZERO
var _v_acc: float = 5
var _v_vel: float = 0

export var mouse_sensitivty = 0.003

export var running_multiplier = 1.5

var _state: PlayerState = null

export(NodePath) var state_provider

onready var _head = $"./head"
onready var _raycast: RayCast = $"./head/RayCast"
onready var _hud_hint: Label = $"./hud/hint"

var _code_machine

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if state_provider == "":
		_state = PlayerState.new()
	else:
		var provider = get_node(state_provider)
		_state = provider.player_state()


func _physics_process(delta):
	var mul = 1.0
	if _run:
		mul = running_multiplier
	_h_vel = _h_vel.linear_interpolate(_direction.normalized() * speed * mul, _h_acc * delta)

	var vforce = -9.8
	if _jump and is_on_floor():
		vforce += jump_force
	_jump = false

	_v_vel = lerp(_v_vel, vforce, _v_acc * delta)
	var movement = Vector3(_h_vel.x, _v_vel, _h_vel.z)

	var _res = move_and_slide(movement, Vector3.UP, true)


func _head_direction():
	return Vector3(sin(_state.yaw), 0, cos(_state.yaw)).normalized() * (-1)


func _input(event):
	if _typing:
		if event is InputEventKey and event.pressed:
			if event.as_text() == "Escape":
				_code_machine.active = false
				_typing = false
			if event.as_text().is_valid_integer() or event.as_text() == "BackSpace" or event.as_text() == "Enter":
				_code_machine.handle_input(event.as_text())
	else:
		if event is InputEventMouseMotion:
			var delta = event.relative
			_state.yaw -= delta.x * mouse_sensitivty
			_state.pitch -= delta.y * mouse_sensitivty
			_state.pitch = clamp(_state.pitch, deg2rad(-90), deg2rad(90))


func _process(_delta):
	# poruszanie
	if not _typing:
		_head.rotation = Vector3(_state.pitch, _state.yaw, 0.0)

		var forward = _head_direction()
		var right = Vector3.UP.cross(-forward)

		_direction = Vector3.ZERO
		if Input.is_action_pressed("forward"):
			_direction += forward
		if Input.is_action_pressed("backward"):
			_direction -= forward
		if Input.is_action_pressed("leftward"):
			_direction -= right
		if Input.is_action_pressed("rightward"):
			_direction += right
		if Input.is_action_just_pressed("jump"):
			_jump = true
		if Input.is_action_just_pressed("run"):
			_run = true
		if Input.is_action_just_released("run"):
			_run = false

	_hud_hint.text = ""

	# smieci
	var collision: Node = _raycast.get_collider()
	if collision:
		if collision.get_parent().get_parent() is Garbage:
			_hud_hint.text = "[E] to collect"
			if Input.is_action_just_pressed("interact"):
				var res = collision.get_parent().get_parent().resource
				collect_a_garbage(res)
				var grandgrandparent = collision.get_parent().get_parent().get_parent()
				grandgrandparent.hide()
				grandgrandparent.queue_free()
				print("points: %d" % _state.points)
				print("inventory: ", _state.inventory)
		if collision.get_parent() is CodeMachine:
			_code_machine = collision.get_parent()
			if _code_machine.active:
				_hud_hint.text = "[Esc] to close typing mode"
			else:
				_hud_hint.text = "[E] to enter code"
				if Input.is_action_just_pressed("interact"):
					_code_machine.active = true
					_typing = true
					_direction = Vector3.ZERO


func collect_a_garbage(garbage: GarbageRes):
	_state.points += int(garbage.points)
	if _state.inventory.has(garbage.name):
		_state.inventory[garbage.name] += 1
	else:
		_state.inventory[garbage.name] = 1
