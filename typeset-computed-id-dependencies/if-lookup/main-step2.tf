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

  # Added dictionary
  dictionary {
    name = "My Dictionary"
    # dictionary is a TypeSet and has a Computed ID field called dictionary_id 
  }

}

# Added dictionary items
resource "fastly_service_dictionary_items_v1" "items" {
  service_id    = fastly_service_v1.myservice.id
  dictionary_id = lookup({ for s in fastly_service_v1.myservice.dictionary : s.name => s.dictionary_id if s.name == "My Dictionary" }, "My Dictionary", "")
}
