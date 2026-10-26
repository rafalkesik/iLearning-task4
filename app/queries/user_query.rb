class UserQuery
  STATUSES = %w[active blocked].freeze
  DIRECTIONS = %w[ASC DESC].freeze
  REGEX_FILTERS = {
    name_regex:  "full_name",
    job_regex:   "job_position",
    email_regex: "email"
  }.freeze

  def initialize(params, scope: User.all)
    @params = params
    @scope  = scope
  end

  def call
    users = @scope
    users = apply_regex_filters(users)
    users = apply_status_filter(users)
    users = apply_last_seen_filter(users)
    apply_sort(users)
  end

  private

    def apply_regex_filters(users)
      REGEX_FILTERS.each do |param, column|
        value = @params[param]
        next if value.blank?

        users = users.where("#{column} ~* ?", value)
      end
      users
    end

    def apply_status_filter(users)
      status = @params[:status]
      return users if status.blank?

      users.where(status: status)
    end

    def apply_last_seen_filter(users)
      from = @params[:last_seen_start]
      to   = @params[:last_seen_end]

      users = users.where("current_sign_in_at >= ?", Time.zone.parse(from)) if from.present?
      users = users.where("current_sign_in_at <= ?", Time.zone.parse(to)) if to.present?
      users
    end

    def apply_sort(users)
      column, direction = Array(@params[:sort_by])
      return users if column.blank?

      users.order(Arel.sql("#{column} #{direction}"))
    end
end