# API Gateway
This module allows creating an API with its associated API config and API gateway. It also allows you grant IAM roles on the created resources.

<!-- BEGIN TOC -->
- [Examples](#examples)
- [Basic example](#basic-example)
- [Use existing service account](#use-existing-service-account)
- [Create service account](#create-service-account)
- [Recipes](#recipes)
- [Variables](#variables)
- [Outputs](#outputs)
<!-- END TOC -->

# Examples

## Basic example
```hcl
module "gateway" {
  source     = "./fabric/modules/api-gateway"
  project_id = "my-project"
  api_id     = "api"
  region     = "europe-west1"
  spec       = <<EOT
  # The OpenAPI spec contents
  # ...
  EOT
}
# tftest modules=1 resources=4 inventory=basic.yaml
```

## Use existing service account
```hcl
module "gateway" {
  source                = "./fabric/modules/api-gateway"
  project_id            = "my-project"
  api_id                = "api"
  region                = "europe-west1"
  service_account_email = "sa@my-project.iam.gserviceaccount.com"
  iam = {
    "roles/apigateway.admin" = ["user:user@example.com"]
  }
  spec = <<EOT
  # The OpenAPI spec contents
  # ...
  EOT
}
# tftest modules=1 resources=7 inventory=existing-sa.yaml
```

## Create service account
```hcl
module "gateway" {
  source                 = "./fabric/modules/api-gateway"
  project_id             = "my-project"
  api_id                 = "api"
  region                 = "europe-west1"
  service_account_create = true
  iam = {
    "roles/apigateway.admin"  = ["user:mirene@google.com"]
    "roles/apigateway.viewer" = ["user:mirene@google.com"]
  }
  spec = <<EOT
  # The OpenAPI spec contents
  # ...
  EOT
}
# tftest modules=1 resources=11 inventory=create-sa.yaml
```
<!-- BEGIN TFDOC -->
## Recipes

- [Multi-region deployment for API Gateway](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric/blob/master/modules/api-gateway/recipe-multi-region)

## Variables

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| [api_id](variables.tf#L17) | API identifier. | <code>string</code> | ✓ |  |
| [project_id](variables.tf#L34) | Project identifier. | <code>string</code> | ✓ |  |
| [region](variables.tf#L39) | Region. | <code>string</code> | ✓ |  |
| [spec](variables.tf#L56) | String with the contents of the OpenAPI spec. | <code>string</code> | ✓ |  |
| [iam](variables.tf#L22) | IAM bindings for the API in {ROLE => [MEMBERS]} format. | <code>map&#40;list&#40;string&#41;&#41;</code> |  | <code>null</code> |
| [labels](variables.tf#L28) | Map of labels. | <code>map&#40;string&#41;</code> |  | <code>null</code> |
| [service_account_create](variables.tf#L44) | Flag indicating whether a service account needs to be created. | <code>bool</code> |  | <code>false</code> |
| [service_account_email](variables.tf#L50) | Service account for creating API configs. | <code>string</code> |  | <code>null</code> |

## Outputs

| name | description | sensitive |
|---|---|:---:|
| [api](outputs.tf#L17) | The full `google_api_gateway_api` resource object. This can be used to access all attributes of the created API. |  |
| [api_config](outputs.tf#L28) | The full `google_api_gateway_api_config` resource object, representing a specific version of the API's configuration. |  |
| [api_config_id](outputs.tf#L39) | The short, unique identifier for the created API config (e.g., 'my-api-config-v1'). |  |
| [api_id](outputs.tf#L50) | The short, unique identifier for the created API (e.g., 'my-gateway-api'). |  |
| [default_hostname](outputs.tf#L72) | The default, publicly accessible URL where the deployed API gateway can be invoked. |  |
| [gateway](outputs.tf#L83) | The full `google_api_gateway_gateway` resource object. This represents the gateway instance itself. |  |
| [gateway_id](outputs.tf#L94) | The short, unique identifier for the created API Gateway instance (e.g., 'my-gateway'). |  |
| [managed_service](outputs.tf#L61) | The unique, globally-recognized name for the API within Google Cloud's Service Infrastructure. It's used for API key restrictions, monitoring, and billing. |  |
| [service_account](outputs.tf#L105) | The full `google_service_account` resource object, if one was created by this module. Will be `null` if an existing service account was used. |  |
| [service_account_email](outputs.tf#L110) | The email address of the service account associated with the API Gateway. |  |
| [service_account_iam_email](outputs.tf#L115) | The service account email formatted for use in IAM policies (e.g., 'serviceAccount:sa@project.iam.gserviceaccount.com'). |  |
<!-- END TFDOC -->
