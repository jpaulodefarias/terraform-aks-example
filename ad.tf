resource "azuread_application" "wordpress" {
  display_name = var.app_name
}

resource "azuread_service_principal" "wordpress" {
  application_id = azuread_application.wordpress.application_id
}

resource "azuread_service_principal_password" "wordpress" {
  service_principal_id = azuread_service_principal.wordpress.id
  description          = "My managed password"
  value                = var.app_password
  end_date             = "2099-01-01T01:02:03Z"
}
