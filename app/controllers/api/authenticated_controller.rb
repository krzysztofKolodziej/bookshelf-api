# frozen_string_literal: true

module Api
  # Base controller for ALL API endpoints.
  #
  # Responsibilities:
  #   - JSON-only responses
  #   - Consistent error handling (rescue_from)
  #   - Request ID tracking (X-Request-ID header)
  #
  # Does NOT enforce authentication — subclasses do that.
  # For authenticated endpoints use Api::Private::AuthenticatedController.
  class AuthenticatedController < ApplicationController
    # Enforce JSON-only API responses
    before_action :set_request_id

    # ── Error handling ──────────────────────────────────────────────────────────

    rescue_from ActiveRecord::RecordNotFound do |_e|
      render_error(:not_found, "Resource not found")
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_error(:unprocessable_entity, e.message)
    end

    rescue_from ActionController::ParameterMissing do |e|
      render_error(:bad_request, e.message)
    end

    private

    # ── Request ID ──────────────────────────────────────────────────────────────
    # Generates or propagates a correlation ID for every request.
    # Clients can pass their own X-Request-ID — we echo it back.
    # This allows end-to-end tracing from client → API → logs → observability tools.
    def set_request_id
      request_id = request.headers["X-Request-ID"] || SecureRandom.uuid
      Thread.current[:request_id] = request_id
      response.set_header("X-Request-ID", request_id)
    end

    def current_request_id
      Thread.current[:request_id]
    end

    # ── Response helpers ────────────────────────────────────────────────────────

    # Standard success envelope.
    # Usage: render_success({ id: 1, title: "..." })
    # Usage: render_success({ id: 1 }, status: :created)
    def render_success(data, status: :ok, meta: {})
      payload = { data: data }
      payload[:meta] = meta if meta.present?
      render json: payload, status: status
    end

    # Standard error envelope.
    # Format: { error: { type, message } }
    # Usage: render_error(:not_found, "Book not found")
    # Usage: render_error(:unprocessable_entity, "Validation failed", input_errors: { title: ["can't be blank"] })
    def render_error(status, message, type: nil, input_errors: nil)
      error_type = type || status.to_s
      payload = {
        error: {
          type: error_type,
          message: message
        }
      }
      payload[:error][:input_errors] = input_errors if input_errors.present?
      render json: payload, status: status
    end
  end
end
