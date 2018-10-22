class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET articles/:article_id/comments
  # GET articles/:article_id/comments.json
  def index
    @comments = Comment.all
  end

  # GET articles/:article_id/comments/1
  # GET articles/:article_id/comments/1.json
  def show
  end

  # GET articles/:article_id/comments/new
  def new
    @comment = Comment.new
  end

  # GET articles/:article_id/comments/1/edit
  def edit
  end

  # POST articles/:article_id/comments
  # POST articles/:article_id/comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to article_path(param[:article_id]), notice: "Comment was successfully created." }
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
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
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
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:title, :content, :rate, :user_id, :article_id)
  end
end
