/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "Project ID for Private Service Connect."
  type        = string
}

variable "region" {
  description = "(Private Service Connect Endpoints for Published Services) Region to create the regional forwarding rule in."
  type        = string
  default = null
}

variable "network_self_link" {
  description = "Network self link for Private Service Connect."
  type        = string
}

variable "dns_code" {
  description = "(Private Service Connect for Google APIs) Code to identify DNS resources in the form of {dns_code}-{dns_type}"
  type        = string
  default     = "dz"
}

variable "forwarding_rule_name" {
  description = <<EOT
  Private Service Connect Forwarding Rule resource name.
  (Private Service Connect for Published Services) Follow regular GCE naming pattern: https://docs.cloud.google.com/compute/docs/naming-resources#resource-name-format. Defaults to `{region}-psc-endpoint`.
  (Private Service Connect for Google APIs) This must be a 1-20 characters string with lowercase letters and numbers and must start with a letter. Defaults to `globalrule`;
EOT
  type        = string
  default     = "globalrule"
}

variable "private_service_connect_name" {
  description = "**Deprecated** use address_name instead; Private Service Connect address name. Defaults to `global-psconnect-ip`."
  type        = string
  default     = "global-psconnect-ip"
}

variable "address_name" {
  description = "Private Service Connect address name. Defaults to global-psconnect-ip for Private Service Connect for Google APIs Defaults to {region}-psc-ip for PSC Endpoints."
  type        = string
  default = var.forwarding_rule_target=="all-apis"||var.forwarding_rule_target=="vpc-sc"? "global-psconnect-ip":"{region}-psc-ip"
}

variable "private_service_connect_ip" {
  description = <<EOT
Set this value to the internal IP to be used for Private Service Connect;
(Private Service Connect Endpoints for Published Services) GCP will pick an address if left unset.
(Private Service Connect for Google APIs) IP must be specified; IPv6 is not supported.
EOT
  type        = string
}

variable "ip_version" {
  description = "(Private Service Connect Endpoints for Published Services) “IPv4” or “IPv6”. Only set this field when private_service_connect_ip is unset. If both private_service_connect_ip and ip_version are unset, GCP will pick an IPv4 address."
  type        = string
  default     = "IPV4"
}

variable "forwarding_rule_target" {
  description = "The target Service Attachment URL for Private Service Connect for Published Service, or the target API bundle name (“all-apis” or “vpc-sc”) for Private Service Connect for Google APIs."
  type        = string
}

variable "service_directory_namespace" {
  description = "Service Directory namespace to register the forwarding rule under."
  type        = string
  default     = null
}

variable "service_directory_region" {
  description = "(Private Service Connect for Google APIs) Service Directory region to register this Private Service Connection endpoint under. Defaults to us-central1 if not defined."
  type        = string
  default     = null
}

variable "psc_global_access" {
  description = "(Private Service Connect Endpoints for Published Services) Whether to allow Private Service Connect global access. Default to false."
  type        = bool
  default     = false
}
