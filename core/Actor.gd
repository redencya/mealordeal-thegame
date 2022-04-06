@tool

extends CharacterBody2D
class_name Actor
# Don't bother making exports, because they won't come up in children

var health := Health.new()
var storage := Storage.new()

# Void method for destruction
# Support polymorphism on children via a simple health check