# [Godot V4.5] Rotational Player With Momentum

This godot project is an implementation for CharacterBody2D with momentum. 

## Motivation

My dear girlfriend and I were struguling to implement a CharacterBody2D that use rotation with momentum. So we were thinking of publishing the code once it done. And so it is. You are free to use, study and redistribuate this piece of code as long as you respect the licence. 

## Player Movement 

There is two axis : linear up/down axis and polar left/right axis.

Thoses axis are local to the CharacterBody2D and are not corolated to global position.

This mean that you can go forward and backward and that to turn, you have to rotate over the CharacterBody2D

`Movement along Up/Down axis` :
![](./doc/videos/UD_Axis.webm)
`Movement along Left/Right axis` :
![](./doc/videos/LR_Axis.webm)
`Movement along both axis` :
![](./doc/videos/UDLR_Axis.webm)

## Player Implementation (overview)

[Player script](./scripts/playerWithMomentum.gd)
[General function to handle movement and momentum](./scripts/playerWithMomentum.gd#L80)
[Player movement along Up/Down axis](./scripts/playerWithMomentum.gd#L71)
[Player rotation along Left/Right axis](./scripts/playerWithMomentum.gd#L60)
[Movement momentom along Up/Down axis](./scripts/playerWithMomentum.gd#L38)
[Rotation momentom along Left/Right axis](./scripts/playerWithMomentum.gd#51)
