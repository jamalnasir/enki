class PostsController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def index
    @tag = params[:tag]
    @posts = Post.find_recent(:tag => @tag, :include => :tags)

    raise(ActiveRecord::RecordNotFound) if @tag && @posts.empty?

    respond_to do |format|
      format.html
      format.atom { render :layout => false }
    end
  end

  def show
    @post = Post.find_by_permalink(*([:year, :month, :day, :slug].collect {|x| params[x] } << {:include => [:approved_comments, :tags]}))
    @comment = Comment.new
  end
  
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  protected

  def render_404
    respond_to do |type|
      type.html { render :template => "errors/404", :layout => "errors", :status => 404}
    end
  end
end
