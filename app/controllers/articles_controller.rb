class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :up_vote, :down_vote]
  before_action :authenticate_user!, only: [:new, :create, :up_vote, :down_vote]
  before_action :check_owner?, only: [:edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @user = User.find(@article.user_id).name
    @article.views += 1
    @article.save

    @comment = Comment.new
    @comments = @article.comments
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    check_owner?
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    check_owner?
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    check_owner?
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def up_vote
    @article.upvote_from current_user
    redirect_to @article
  end

  def down_vote
    @article.downvote_from current_user
    redirect_to @article
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  def check_owner?
    if current_user.id == @article.user_id && :authenticate_user!
      true
    else
      redirect_to articles_path, notice: "Sorry, you are not the publisher of this article"
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :description, :content, :source, :source_date, :views, :user_id)
  end
end
