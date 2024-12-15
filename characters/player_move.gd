extends CharacterBody2D

# 定义角色移动速度，单位是像素/秒，这里设置为400，可根据实际需求调整
#@export var speed = 400  
# 定义网格像素大小，用于控制角色每次移动的距离，这里设置为32像素，方便实现基于网格的移动逻辑
@export var grid_pix = 16  
# 布尔变量，用于标记角色当前是否正在移动，初始值为false，表示角色初始处于静止状态
var is_moving = false  
# 用于存储角色移动的目标位置，初始值为未定义，会在确定移动方向后进行赋值
var target_position  
# 新增变量，用于记录当前正在移动的方向，初始化为空字符串，表示尚未开始移动或者移动已结束
var current_moving_direction = ""  

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta):
	# 在每帧物理处理过程中执行以下逻辑
	if is_moving:
		# 如果角色当前正在移动，创建一个补间动画（Tween）对象来处理移动动画效果
		var tween = get_tree().create_tween()#.set_parallel(true)
		# 设置补间动画的过渡类型为正弦过渡（TRANS_SINE），使移动动画更加平滑自然
		tween.set_trans(Tween.TRANS_SINE)
		# 设置补间动画的缓动效果为淡入淡出（EASE_IN_OUT），让移动开始和结束时的速度变化更柔和
		tween.set_ease(Tween.EASE_IN_OUT)
		# 通过补间动画将角色的当前位置（"position"属性）逐渐改变到目标位置（target_position），动画时长设置为0.2秒
		tween.tween_property(self, "position", target_position, 0.5)
		#tween.tween_property(self, "position", target_position, 0.5)

		# 移动动画完成后，将角色的移动状态标记为false，表示角色已停止移动
		is_moving = false
		# 清空当前移动方向记录，以便下次能正确响应新的方向键输入
		current_moving_direction = ""  
	
		animation_player.play("walk")
	else:
		# 角色当前处于静止状态，开始处理方向键输入逻辑
		# 检测向右方向键是否刚刚被按下，并且当前没有正在进行的移动操作（即current_moving_direction为空字符串）
		if Input.is_action_just_pressed("right") && current_moving_direction == "":
			# 如果满足条件，计算角色向右移动后的目标位置，基于当前位置在x轴方向增加grid_pix个像素
			target_position = position + Vector2(grid_pix, 0)
			# 将角色的移动状态标记为true，表示角色即将开始移动
			is_moving = true
			# 记录当前正在进行的移动方向为"right"，方便后续判断和避免其他方向键干扰
			current_moving_direction = "right"  
		# 检测向左方向键是否刚刚被按下，并且当前没有正在进行的移动操作（即current_moving_direction为空字符串）
		elif Input.is_action_just_pressed("left") && current_moving_direction == "":
			# 如果满足条件，计算角色向左移动后的目标位置，基于当前位置在x轴方向减少grid_pix个像素
			target_position = position + Vector2(-grid_pix, 0)
			# 将角色的移动状态标记为true，表示角色即将开始移动
			is_moving = true
			# 记录当前正在进行的移动方向为"left"，方便后续判断和避免其他方向键干扰
			current_moving_direction = "left"  
		# 检测向上方向键是否刚刚被按下，并且当前没有正在进行的移动操作（即current_moving_direction为空字符串）
		elif Input.is_action_just_pressed("up") && current_moving_direction == "":
			# 如果满足条件，计算角色向上移动后的目标位置，基于当前位置在y轴方向减少grid_pix个像素
			target_position = position + Vector2(0, -grid_pix)
			# 将角色的移动状态标记为true，表示角色即将开始移动
			is_moving = true
			# 记录当前正在进行的移动方向为"up"，方便后续判断和避免其他方向键干扰
			current_moving_direction = "up"  
		# 检测向下方向键是否刚刚被按下，并且当前没有正在进行的移动操作（即current_moving_direction为空字符串）
		elif Input.is_action_just_pressed("down") && current_moving_direction == "":
			# 如果满足条件，计算角色向下移动后的目标位置，基于当前位置在y轴方向增加grid_pix个像素
			target_position = position + Vector2(0, grid_pix)
			# 将角色的移动状态标记为true，表示角色即将开始移动
			is_moving = true
			# 记录当前正在进行的移动方向为"down"，方便后续判断和避免其他方向键干扰
			current_moving_direction = "down"  
