extends Node

signal login_succeeded
signal login_failed(message: String)

var is_logged_in: bool = false


func _ready() -> void:
	# Listen for login results
	Supabase.auth.signed_in_anonymous.connect(_on_login_success)
	Supabase.auth.error.connect(_on_login_error)

	# Automatically log in
	Supabase.auth.sign_in_anonymous()


func _on_login_success(signed_user: SupabaseUser) -> void:
	is_logged_in = true
	print("Anonymous login successful!")
	login_succeeded.emit()


func _on_login_error(error_message) -> void:
	is_logged_in = false
	print("Login failed: ", error_message)
	login_failed.emit(str(error_message))
