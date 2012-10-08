class Deployment < ActiveRecord::Base
  belongs_to :sub_category
  has_many :deploy_links  
  has_many :hosts, :through => :deploy_links  
  has_many :inverse_deploy_links, :class_name => "DeployLink", :foreign_key => "host_id"
  has_many :connections, :through => :inverse_deploy_links, :source => :deployment  
  attr_accessible :hr, :name, :note
end
