/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "api" {
  description = "The full `google_api_gateway_api` resource object. This can be used to access all attributes of the created API."
  value       = google_api_gateway_api.api
  depends_on = [
    google_project_service.service,
    google_api_gateway_api_iam_binding.api_iam_bindings,
    google_api_gateway_api_config_iam_binding.api_config_iam_bindings,
    google_api_gateway_gateway_iam_binding.gateway_iam_bindings
  ]
}

output "api_config" {
  description = "The full `google_api_gateway_api_config` resource object, representing a specific version of the API's configuration."
  value       = google_api_gateway_api_config.api_config
  depends_on = [
    google_project_service.service,
    google_api_gateway_api_iam_binding.api_iam_bindings,
    google_api_gateway_api_config_iam_binding.api_config_iam_bindings,
    google_api_gateway_gateway_iam_binding.gateway_iam_bindings
  ]
}

output "api_config_id" {
  description = "The short, unique identifier for the created API config (e.g., 'my-api-config-v1')."
  value       = google_api_gateway_api_config.api_config.api_config_id
  depends_on = [
    google_project_service.service,
    google_api_gateway_api_iam_binding.api_iam_bindings,
    google_api_gateway_api_config_iam_binding.api_config_iam_bindings,
    google_api_gateway_gateway_iam_binding.gateway_iam_bindings
  ]
}

output "api_id" {
  description = "The short, unique identifier for the created API (e.g., 'my-gateway-api')."
  value       = google_api_gateway_api.api.api_id
  depends_on = [
    google_project_service.service,
    google_api_gateway_api_iam_binding.api_iam_bindings,
    google_api_gateway_api_config_iam_binding.api_config_iam_bindings,
    google_api_gateway_gateway_iam_binding.gateway_iam_bindings
  ]
}

output "managed_service" {
  description = "The unique, globally-recognized name for the API within Google Cloud's Service Infrastructure. It's used for API key restrictions, monitoring, and billing."
  value       = google_api_gateway_api.api.managed_service
  depends_on = [
    google_project_service.service,
    google_api_gateway_api_iam_binding.api_iam_bindings,
    google_api_gateway_api_config_iam_binding.api_config_iam_bindings,
    google_api_gateway_gateway_iam_binding.gateway_iam_bindings
  ]
}

output "default_hostname" {
  description = "The default, publicly accessible URL where the deployed API gateway can be invoked."
  value       = google_api_gateway_gateway.gateway.default_hostname
  depends_on = [
    google_project_service.service,
    google_api_gateway_api_iam_binding.api_iam_bindings,
    google_api_gateway_api_config_iam_binding.api_config_iam_bindings,
    google_api_gateway_gateway_iam_binding.gateway_iam_bindings
  ]
}

output "gateway" {
  description = "The full `google_api_gateway_gateway` resource object. This represents the gateway instance itself."
  value       = google_api_gateway_gateway.gateway
  depends_on = [
    google_project_service.service,
    google_api_gateway_api_iam_binding.api_iam_bindings,
    google_api_gateway_api_config_iam_binding.api_config_iam_bindings,
    google_api_gateway_gateway_iam_binding.gateway_iam_bindings
  ]
}

output "gateway_id" {
  description = "The short, unique identifier for the created API Gateway instance (e.g., 'my-gateway')."
  value       = google_api_gateway_gateway.gateway.gateway_id
  depends_on = [
    google_project_service.service,
    google_api_gateway_api_iam_binding.api_iam_bindings,
    google_api_gateway_api_config_iam_binding.api_config_iam_bindings,
    google_api_gateway_gateway_iam_binding.gateway_iam_bindings
  ]
}

output "service_account" {
  description = "The full `google_service_account` resource object, if one was created by this module. Will be `null` if an existing service account was used."
  value       = try(google_service_account.service_account[0], null)
}

output "service_account_email" {
  description = "The email address of the service account associated with the API Gateway."
  value       = local.service_account_email
}

output "service_account_iam_email" {
  description = "The service account email formatted for use in IAM policies (e.g., 'serviceAccount:sa@project.iam.gserviceaccount.com')."
  value       = local.service_account_email == null ? null : "serviceAccount:${local.service_account_email}"
}