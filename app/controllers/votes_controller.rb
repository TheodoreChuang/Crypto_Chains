class VotesController < ApplicationController
  before_action :set_article, only: [:up_vote, :down_vote]
  before_action :authenticate_user!, only: [:up_vote, :down_vote]

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
end
