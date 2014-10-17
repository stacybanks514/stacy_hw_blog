class Post < ActiveRecord::Base
    scope :most_recent, -> { limit(10).order('published_at desc') }
    scope :unpublished, -> { where("published_at > '#{Date.today}'")}
    
    def self.search(q)
      where(['body LIKE ? OR subject LIKE ?', "%#{q}%", "%#{q}%"])
    end 
end


