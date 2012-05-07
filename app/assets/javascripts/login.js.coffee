$ ->
  $("#login_name").focus ->
    $("#login_name").val("") if $("#login_name").val() == "Name"
  $("#login_name").focusout ->
    $("#login_name").val("Name") if $("#login_name").val() == ""
  $("#login_username").focus ->
    $("#login_username").val("") if $("#login_username").val() == "Username"
  $("#login_username").focusout ->
    $("#login_username").val("Username") if $("#login_username").val() == ""
  $("#login_password").focus ->
    $("#login_password").val("") if $("#login_password").val() == "Password"
  $("#login_password").focusout ->
    $("#login_password").val("Password") if $("#login_password").val() == ""
