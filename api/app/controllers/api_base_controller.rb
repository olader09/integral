class APIBaseController < ActionController::API
  before_action :init_redis
  include Knock::Authenticable

  def current_ability
    @current_ability ||= if current_superuser.present?
                           Ability.new(current_superuser)
                         else
                           Ability.new(current_user)
                         end
  end

  protected

  def auth_user
    if current_superuser.present?
      authenticate_superuser
    else
      authenticate_user
    end
  end

  def init_redis
    @redis = Redis.new(host: 'redis', port: 6379, db: 15)
    @redis.set('temp_users_push_tokens', []) if @redis.get('temp_users_push_tokens').nil?
  end

  rescue_from ActiveRecord::RecordNotFound, with: :render_error_404
  rescue_from CanCan::AccessDenied, with: :render_error_403

  def render_error_404
    render json: {"error": "Not found"}, status: :not_found
  end

  def render_error_403
    render json: {"error": "You are not authorized to access this page"}, status: 403
  end
end
