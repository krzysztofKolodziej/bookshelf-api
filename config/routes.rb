# frozen_string_literal: true

Rails.application.routes.draw do
  # ── Health check ──────────────────────────────────────────────────────────────
  # Used by load balancers, Kubernetes liveness probes, StatusCake monitoring.
  # Must NOT require authentication — checked by infra before routing real traffic.
  # Phase 8: will return { status, checks: { db, redis, open_library } }
  get "/health", to: "health#show"

  # Rails built-in health (keep for completeness)
  get "up" => "rails/health#show", as: :rails_health_check

  # ── API namespace ─────────────────────────────────────────────────────────────
  # Phase 1: Basic structure — building the skeleton.
  # Phase 2: Doorkeeper authentication enforced via Api::Private::AuthenticatedController.
  # Phase 3: X-API-Version header versioning via RouteVersionConstraint wraps these routes.
  namespace :api do
    namespace :private do
      # Phase 2+: resources will be added here as we progress through phases.
      # resources :books
      # resources :reviews
    end
  end
end
