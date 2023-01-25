class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :not_auth

  def pundit_user
    UserPundit.new(current_user, { cookies: cookies, pincode: params[:pincode] })
  end

  private

  def not_auth(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:warning] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(request.referrer || root_path)
  end
end
