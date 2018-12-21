class Article < ApplicationRecord
  # Modules
  include Publishing
  include Deletions
  include Features
  include Ordering
  include Timing

  # Slug
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Attributes
  attr_accessor :style

  # Scopes
  scope :active_approved, -> { is_active.is_published }
  scope :active_featured, -> { is_active.is_published.is_featured }

  # Query
  def self.admin_search(term, page)
    if term
      is_active
      .where('articles.name ilike ?', "%#{term}%")
      .paginate(page: page, per_page: 25)
    else
      all_active
      .paginate(page: page, per_page: 25)
    end
  end

  # Cache
  after_commit :article_cache_clear
  after_destroy :article_cache_clear

  def article_cache_clear
    Rails.cache.delete('Article.active')
    Rails.cache.delete('Article.published')
    Rails.cache.delete('Article.featured')
    Rails.cache.delete("Article.#{slug}")
  end

  # Article.all_active
  def self.all_active
    Rails.cache.fetch('Article.active', expires_in: 1.day) do
      is_active.created_desc.to_a
    end
  end

  # Article.all_approved
  def self.all_approved
    Rails.cache.fetch('Article.published', expires_in: 1.day) do
      active_published.name_asc.to_a
    end
  end

  # Article.all_featured
  def self.all_featured
    Rails.cache.fetch('Article.featured', expires_in: 1.day) do
      active_featured.name_asc.to_a
    end
  end

  # Article.slugged(params[:id])
  def self.slugged(id)
    Rails.cache.fetch("Article.#{id}", expires_in: 1.day) { friendly.find(id) }
  end
end
