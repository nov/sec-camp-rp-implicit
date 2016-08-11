class ApplicationController < ActionController::Base
  include Concerns::Authentication
  protect_from_forgery with: :exception

  rescue_from StandardError, with: :render_error

  def render_error(e)
    @error = e
    render '/error'
  end
end
