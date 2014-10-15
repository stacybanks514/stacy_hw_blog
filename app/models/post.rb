class Post < ActiveRecord::Base
    scope :most_recent, -> { limit(10).order('published_at desc') }
end
