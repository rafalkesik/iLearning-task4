module Api
  class UsersController < ApplicationController
    TOP_LIMIT = 5

    def index
      users = UserQuery.new(users_params).call

      count     = users.count            if params[:count].present?
      top_users = users.limit(TOP_LIMIT) if params[:list].present?

      render json: {
        count: count,
        users: top_users.as_json(only: %i[full_name job_position email status current_sign_in_at])
      }
    end

    private

      def users_params
        params.permit(
          :name_regex, :job_regex, :email_regex, :status,
          :last_seen_start, :last_seen_end, :list, :count,
          sort_by: []
        )
      end
  end
end
