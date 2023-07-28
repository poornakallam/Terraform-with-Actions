variable "lambdas" {
  type = list(object({
    name    = string,
    handler = string
  }))
  default = [
    {
      name    = "node"
      handler = "index.handler"
    },
    {
      name    = "node01"
      handler = "index.test"
    }
  ]
}