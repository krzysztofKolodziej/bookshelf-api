# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /health", type: :request do
  subject(:call) { get "/health", headers: headers }

  let(:headers) { {} }

  it "returns 200 OK" do
    call
    expect(response).to have_http_status(:ok)
  end

  it "returns JSON content type" do
    call
    expect(response.content_type).to include("application/json")
  end

  it "returns required status fields" do
    call
    expect(json["status"]).to eq("ok")
    expect(json["environment"]).to eq("test")
    expect(json["version"]).to be_present
    expect(json["ruby_version"]).to be_present
    expect(json["timestamp"]).to be_present
  end

  it "returns a valid ISO 8601 timestamp" do
    call
    expect { Time.iso8601(json["timestamp"]) }.not_to raise_error
  end

  it "does not require an Authorization header" do
    call
    expect(response).not_to have_http_status(:unauthorized)
  end

  it "returns X-Request-ID header in the response" do
    call
    expect(response.headers["X-Request-ID"]).to be_present
  end

  context "when client sends its own X-Request-ID" do
    let(:headers) { { "X-Request-ID" => "my-trace-id-123" } }

    it "echoes back the same X-Request-ID" do
      call
      expect(response.headers["X-Request-ID"]).to eq("my-trace-id-123")
    end
  end
end
