# frozen_string_literal: true

# Health check endpoint — GET /health
#
# Returns 200 if the application is operational.
# Phase 8 enhancement: will check DB, Redis, and external API connectivity.
#
# No authentication required — must be reachable by load balancers.
class HealthController < ApplicationController
  skip_before_action :ensure_json_request

  def show
    render json: {
      status: "ok",
      version: Rails.version,
      ruby_version: RUBY_VERSION,
      environment: Rails.env,
      # Phase 8: expand with real checks:
      # checks: {
      #   db: db_healthy?,
      #   redis: redis_healthy?,
      #   open_library: open_library_healthy?
      # }
      timestamp: Time.current.iso8601
    }, status: :ok
  end
end
