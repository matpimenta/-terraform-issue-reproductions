terraform {
  required_providers {
    fastly = {
      source = "fastly/fastly"
    }
  }
  required_version = ">= 0.13"
}

provider "fastly" {
}

resource "fastly_service_v1" "myservice" {
  name          = "test-service"
  force_destroy = true

  domain {
    name = "demo.000000001-notexample.com"
  }

  backend {
    address = "127.0.0.1"
    name    = "backend"
  }

  response_object {
    name         = "WAF_Response"
    status       = "403"
    response     = "Forbidden"
    content_type = "text/html"
  }

  # Added WAF 
  waf {
    response_object = "WAF_Response"
    # waf is a TypeList and has a Computed ID field called waf_id 
  }

}

# Added WAF configuration
resource "fastly_service_waf_configuration" "waf" {
  waf_id = fastly_service_v1.myservice.waf[0].waf_id
}
