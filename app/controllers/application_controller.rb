# frozen_string_literal: true

class ApplicationController < ActionController::API
  # Force JSON responses for all API endpoints
  before_action :ensure_json_request

  private

  def ensure_json_request
    return if request.format == :json || request.format == "*/*"

    render json: { error: { type: "not_acceptable", message: "Only JSON format is supported" } },
           status: :not_acceptable
  end
end
