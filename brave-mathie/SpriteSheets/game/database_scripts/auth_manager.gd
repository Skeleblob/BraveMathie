extends Node

const SAVE_PATH = "user://auth.cfg"

var is_logged_in: bool = false
signal login_succeeded

func _ready() -> void:
	Supabase.auth.signed_in_anonymous.connect(_on_login_success)
	Supabase.auth.token_refreshed.connect(_on_token_refreshed)
	Supabase.auth.error.connect(_on_auth_error)

	var saved_token = _load_refresh_token()

	if saved_token != "":
		print("Attempting to restore session...")
		Supabase.auth.restore_session(saved_token)
	else:
		print("No saved session. Creating anonymous account...")
		Supabase.auth.sign_in_anonymous()


func _on_login_success(user: SupabaseUser) -> void:
	is_logged_in = true
	_save_refresh_token(user.refresh_token)

	login_succeeded.emit()
	DatabaseManager.load_player_data()


func _on_token_refreshed(user: SupabaseUser) -> void:
	if not is_logged_in:
		is_logged_in = true
	print("Session restored successfully!")

	login_succeeded.emit()
	DatabaseManager.load_player_data()

func _on_auth_error(auth_error) -> void:
	is_logged_in = false
	print("Authentication error: ", auth_error)

	# If restoration failed, start a new anonymous session.
	# Avoid doing this for errors during an already established session.
	if Supabase.auth.client == null:
		Supabase.auth.sign_in_anonymous()


func _save_refresh_token(token: String) -> void:
	var config = ConfigFile.new()
	config.set_value("auth", "refresh_token", token)
	config.save(SAVE_PATH)


func _load_refresh_token() -> String:
	var config = ConfigFile.new()

	if config.load(SAVE_PATH) != OK:
		return ""

	return config.get_value("auth", "refresh_token", "")
