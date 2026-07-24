class_name DamageData
extends Resource

@export var base_damage: float = 10.0
@export var damage_type: DamageType.Type = DamageType.Type.PHYSICAL
@export var damage_mode: DamageMode.Value = DamageMode.Value.INSTANT

# Для PERIODIC
@export var tick_interval: float = 1.0
@export var duration: float = 5.0
