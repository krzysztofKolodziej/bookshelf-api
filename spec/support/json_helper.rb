# frozen_string_literal: true

# Helper for request specs — parses JSON response body automatically.
#
# Usage in request specs:
#   get "/api/books"
#   expect(json["data"]).to be_an(Array)
#   expect(json.dig("error", "type")).to eq("authentication_error")
module JsonHelper
  def json
    JSON.parse(response.body)
  end
end
