class DeployLink < ActiveRecord::Base
  attr_accessible :deployment_id, :host_id
  belongs_to :deployment  
  belongs_to :host, :class_name => 'Deployment'  
  
  def self.tree_down(roots)
	find_by_sql(%Q{
	WITH RECURSIVE conx(level, id, host_id) AS (
		SELECT 1 as level, deploy_links.id, deploy_links.deployment_id FROM deploy_links WHERE host_id in (#{roots.join(',')})
		UNION DISTINCT
		SELECT conx.level+1 as level, deploy_links.id, deploy_links.deployment_id FROM deploy_links, conx
		WHERE conx.host_id = deploy_links.host_id and
		level <8
		)
	SELECT bd.level, dl.* FROM deploy_links as dl
	join conx as bd on (bd.id = dl.id)
	order by level, host_id, deployment_id, id
	})
	end	
 
	# utilisable de la façon suivante
	# DeployLink.path_down([8]).collect do |row| row.path.split("/") end
	def self.path_down(roots)
		find_by_sql(%Q{
			WITH RECURSIVE conx(level, path, id, host_id) AS (
				SELECT 1 as level, deploy_links.host_id||'/'||deploy_links.deployment_id as path, deploy_links.id, deploy_links.deployment_id FROM deploy_links WHERE host_id in (#{roots.join(',')})
				UNION DISTINCT
				SELECT conx.level+1 as level, conx.path||'/'||deploy_links.deployment_id as path, deploy_links.id, deploy_links.deployment_id FROM deploy_links, conx
				WHERE conx.host_id = deploy_links.host_id and
				level <5
			)
			SELECT bd.level, bd.path, dl.* FROM deploy_links as dl
			join conx as bd on (bd.id = dl.id)
			order by level, host_id, deployment_id, id		
		})
	end	
end
