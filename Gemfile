source "https://rubygems.org"

# ─── Core ─────────────────────────────────────────────────────────────────────
gem "rails", "~> 8.1.2"
gem "mysql2", "~> 0.5"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[ windows jruby ]

# ─── CORS ─────────────────────────────────────────────────────────────────────
gem "rack-cors"

# ─── Domain boundaries (Packwerk — by Shopify) ────────────────────────────────
gem "packwerk", "~> 3.2"
gem "graphwerk", require: false   # dependency graph visualisation
gem "benchmark"                   # removed from Ruby stdlib in 4.0, required by packwerk

# ─── Serialization / Response ─────────────────────────────────────────────────
# Protocol objects (POROs) — no gem needed; added here for documentation only

# ─── Validation ───────────────────────────────────────────────────────────────
gem "dry-validation"              # preferred for new code over Strong Params

# ─── Database / Cache / Jobs (Phase 1: solid defaults, replaced by Redis in Phase 6) ──
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# ─── Authentication (Phase 2) — Doorkeeper OAuth 2.0 ─────────────────────────
# gem "doorkeeper"                 # uncomment in Phase 2

# ─── Rate Limiting (Phase 6) — Rack::Attack + Redis ──────────────────────────
# gem "rack-attack"                # uncomment in Phase 6
# gem "redis", "~> 5.0"           # uncomment in Phase 6

# ─── Pagination (Phase 5) — Kaminari ─────────────────────────────────────────
# gem "kaminari"                   # uncomment in Phase 5

# ─── Observability (Phase 8) — Datadog + Lograge + Sentry ────────────────────
# gem "ddtrace", "~> 2.10"        # uncomment in Phase 8
# gem "lograge"                   # uncomment in Phase 8
# gem "sentry-rails"              # uncomment in Phase 8

# ─── Resilience (Phase 7) — Circuitbox ───────────────────────────────────────
# gem "circuitbox"                 # uncomment in Phase 7
# gem "faraday"                    # uncomment in Phase 7

# ─── Development & Test ────────────────────────────────────────────────────────
group :development, :test do
  gem "rspec-rails", "~> 7.0"
  gem "factory_bot_rails"
  gem "faker"                      # realistic seed/test data
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "rubocop-rails-omakase", require: false
end

group :test do
  gem "shoulda-matchers"           # cleaner model/controller spec matchers
  gem "vcr"                        # record/replay external HTTP calls (Phase 7+)
  gem "webmock"                    # stub HTTP requests in tests
end
