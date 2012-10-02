class Comment < ActiveRecord::Base
  attr_accessible :author, :text
  belongs_to :book
end
