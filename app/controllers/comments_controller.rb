class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_article, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :check_owner?, only: [:edit, :update, :destroy]

  # GET articles/:article_id/comments
  # GET articles/:article_id/comments.json
  def index
    @comments = Comment.all
  end

  # GET articles/:article_id/comments/1
  # GET articles/:article_id/comments/1.json
  def show
    @user = User.find(@article.user_id).name
  end

  # GET articles/:article_id/comments/new
  def new
    @comment = Comment.new
    @comment.article_id = @article.id
    @comment.user_id = current_user.id
  end

  # GET articles/:article_id/comments/1/edit
  def edit
    check_owner?
  end

  # POST articles/:article_id/comments
  # POST articles/:article_id/comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = @article.id
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to article_path(@article.id), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT articles/:article_id/comments/1
  # PATCH/PUT articles/:article_id/comments/1.json
  def update
    check_owner?
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to article_path(@article.id), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE articles/:article_id/comments/1
  # DELETE articles/:article_id/comments/1.json
  def destroy
    check_owner?
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to article_path(@article.id), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def check_owner?
    if current_user.id == @comment.user_id && :authenticate_user!
      true
    else
      redirect_to article_path(@article), notice: "Sorry, you are not the publisher of this comment"
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:title, :content, :rate, :user_id, :article_id)
  end
end
