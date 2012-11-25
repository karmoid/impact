class Deployment < ActiveRecord::Base
  belongs_to :sub_category
  has_many :deploy_links  
  has_many :hosts, :through => :deploy_links  
  has_many :inverse_deploy_links, :class_name => "DeployLink", :foreign_key => "host_id"
  has_many :connections, :through => :inverse_deploy_links, :source => :deployment  
  attr_accessible :hr, :name, :note, :stacked
  
# comments = Comment.find_by_sql(%Q{
#     with recursive tree(id) as (
#         select c.id, c.column1, ...
#         from comments c
#         where c.id in (#{roots.join(',')})
#         union all
#         select c.id, c.column1, ...
#         from comments c
#         join tree on c.parent_id = tree.id
#     )
#     select id, column1, ...
#     from tree
# })  
  
  
end
