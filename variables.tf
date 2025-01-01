variable "name" {}

variable "description" {
  default = null
}

variable "body" {
  default = null
}

variable "policy_statement" {
  type = list(object({
    principal = optional(string, "*")
    action    = optional(string, "execute-api:Invoke")
    effect    = string
    condition = any
  }))
  default = null
}


variable "zone_id" {
  default = null
}

variable "domain_names" {
  type = map(object({
    zone_id    = string
    stage_name = string
  }))
}


variable "vpc_endpoint" {
  type = object({
    region     = string
    vpc_id     = string
    subnet_ids = set(string)
    type       = optional(string, "Interface")
  })
  default = null
}

variable "authorizers" {
  type = map(object({
    type          = optional(string, "COGNITO_USER_POOLS")
    provider_arns = set(string)
  }))
  default = {}
}

variable "resources" {
  type = map(object({
    parent_id = optional(string)
    path_part = optional(string)
    methods = optional(map(object({
      authorization      = optional(string, "NONE")
      authorizer_id      = optional(string)
      request_parameters = optional(any)
      integrations = map(object({
        type               = string
        uri                = string
        connection_type    = optional(string)
        connection_id      = optional(string)
        request_parameters = optional(any)
      }))
    })))
  }))
  default = {}
}

variable "deployments" {
  type = map(object({
    triggers = map(any)
    stages = map(object({
      variables = optional(map(string))
    }))
  }))
  default = {}
}