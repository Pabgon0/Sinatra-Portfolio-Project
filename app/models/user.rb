class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  validates :username, presence: true, uniqueness: true

  def slug
    username.downcase.strip.gsub(" ","-").gsub(/[^\w-]/, "")
  end

  def self.find_by_slug(slug)
    self.all.detect{|i| i.slug == slug}
  end
end
