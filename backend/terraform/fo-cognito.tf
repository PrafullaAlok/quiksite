resource "aws_cognito_user_pool" "fo_user_pool" {
  name = "${var.company_name}-${var.env_name}-fo"

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  admin_create_user_config {
    # Set to `true` if only the administrator is allowed to create user profiles.
    # Set to `false` if users can sign themselves up via an app.
    allow_admin_create_user_only = false
  }

  auto_verified_attributes = ["email"]

  username_attributes = ["email"]

  password_policy  {
    minimum_length = 8
    require_uppercase = true
    require_lowercase = true
    require_numbers = true
    require_symbols = true
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  verification_message_template  {
    # email_message_by_link = "Thank you for registering with ${var.company_name}. To complete the registration process, please verify your email by clicking the following link: {##Click Here##}"
    email_subject = "${var.company_name} registration"
    email_message = "Thank you for registering with ${var.company_name}. To complete the registration process, please verify your email by entering the following code in the App: {####}"
    default_email_option =  "CONFIRM_WITH_CODE"
  }

  schema {
    name =  "email"
    attribute_data_type = "String"
    required =  true
    developer_only_attribute = false
    mutable = true
    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }

}
