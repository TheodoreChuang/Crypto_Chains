json.extract! article, :id, :title, :description, :content, :source, :source_date, :views, :user_id, :created_at, :updated_at
json.url article_url(article, format: :json)
