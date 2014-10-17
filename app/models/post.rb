class Post < ActiveRecord::Base
    scope :most_recent, -> { limit(10).order('published_at desc') }
    scope :unpublished, -> { where("published_at > '#{Date.today}'")}

    def self.search(q)
            result = Post.where(['body LIKE ? OR subject LIKE ?', "%#{q}%", "%#{q}%"])
            
    end 
end


