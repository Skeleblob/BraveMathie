extends Node

var a: int = 1
var b: int = 0
var c: int = 0
var functionType = ""

func calculateDamage():
	match functionType:
		"ax+b":
			return a * 5 + b
		"ax^2+bx+c":
			return a * pow(5,2) + b * 5 + c
		_:
			return 1
