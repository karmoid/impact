class DeployLink < ActiveRecord::Base
  attr_accessible :deployment_id, :host_id
  belongs_to :deployment  
  belongs_to :host, :class_name => 'Deployment'  
end
