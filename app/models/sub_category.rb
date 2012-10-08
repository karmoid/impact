class SubCategory < ActiveRecord::Base
  belongs_to :category
  has_many :deployments
  attr_accessible :hr, :name, :note
end
