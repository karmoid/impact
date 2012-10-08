class Category < ActiveRecord::Base
  attr_accessible :hr, :name, :note
  has_many :sub_categories
end
