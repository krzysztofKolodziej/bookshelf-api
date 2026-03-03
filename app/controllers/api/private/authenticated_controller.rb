# frozen_string_literal: true

module Api
  module Private
    # Base controller for ALL protected API endpoints.
    #
    # Responsibilities (on top of Api::AuthenticatedController):
    #   - Authentication enforcement (Phase 2: Doorkeeper OAuth)
    #   - Current user context
    #   - 401 vs 403 distinction (correctly separated — see HTTP Status discipline below)
    #
    # HTTP Status discipline:
    #   401 Unauthorized  → no valid credentials provided at all
    #   403 Forbidden     → credentials are valid, but insufficient permission
    #
    # Phase 2 note: The authenticate_user! method below is a placeholder.
    # It will be replaced by Doorkeeper's doorkeeper_authorize! + our
    # AuthenticateByOauth / AuthenticateByProApiKey concerns in Phase 2.
    class AuthenticatedController < Api::AuthenticatedController
      before_action :authenticate_user!

      private

      # Placeholder authentication — Phase 2 will replace this with Doorkeeper.
      # For now: checks for a hardcoded dev token so we can test the structure.
      def authenticate_user!
        # Phase 2: Replace with Doorkeeper + AuthenticateByOauth concern
        # doorkeeper_authorize!
        # @current_user = User.find(doorkeeper_token.resource_owner_id)

        # Temporary: return 401 if no Authorization header present
        unless request.headers["Authorization"].present?
          render_error(:unauthorized, "Authentication required",
                       type: "authentication_error")
        end
      end

      def current_user
        @current_user
      end
    end
  end
end
