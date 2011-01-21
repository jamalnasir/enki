class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :set_current_user_for_model
  
  protect_from_forgery
  after_filter :set_content_type

  rescue_from ActionController::RoutingError, :with => :render_404
  
  protected

  def render_404
    respond_to do |type|
      type.html { render :template => "errors/404", :layout => "errors", :status => 404}
    end
  end
  
  def render_500
    respond_to do |type|
      type.html { render :template => "errors/500", :layout => "errors", :status => 500}
    end
  end

  def set_content_type
    headers['Content-Type'] ||= 'text/html; charset=utf-8'
  end

  def enki_config
    @@enki_config = Enki::Config.default
  end
  
  def set_current_user_for_model
    User.current = current_user
  end
  
  helper_method :enki_config
end
