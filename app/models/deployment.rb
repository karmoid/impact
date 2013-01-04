class Deployment < ActiveRecord::Base
  belongs_to :sub_category
  has_many :deploy_links  
  has_many :hosts, :through => :deploy_links  
  has_many :inverse_deploy_links, :class_name => "DeployLink", :foreign_key => "host_id"
  has_many :connections, :through => :inverse_deploy_links, :source => :deployment  
  attr_accessible :hr, :name, :note, :stacked
  
  def self.tree_down(roots)
	DeployLink.tree_down(roots)
  end
  
  def self.path_down(roots)
	DeployLink.path_down(roots)
  end
  

# WITH RECURSIVE conx(id, parent_id) AS (
#   SELECT host_id, deployment_id FROM deploy_links WHERE host_id = 8
#   UNION
#   SELECT deploy_links.host_id, deploy_links.deployment_id FROM deploy_links, conx
#   WHERE conx.parent_id = deploy_links.host_id)
# SELECT d.id, c.hr, sc.hr, d.hr, d1.id, c1.hr, sc1.hr, d1.hr FROM conx as bd
# join deployments as d on (d.id = bd.id)
# join sub_categories as sc on (sc.id = d.sub_category_id)
# join categories as c on (c.id = sc.category_id)
# join deployments as d1 on (d1.id = bd.parent_id)
# join sub_categories as sc1 on (sc1.id = d1.sub_category_id)
# join categories as c1 on (c1.id = sc1.category_id)

	def register_item(item, indices, leaf)
		if ! indices.empty?
			current = indices.pop.to_i
			# logger.info "#{indices} restant avec item courant = [#{current}]"
			nextleaf = nil
			leaf.each do |l|
				# logger.info "verification que current_pop:[#{current}] == l[:node].id [#{l[:node].id}-#{l[:node].hr}]"
				if l[:node].id == current
					# logger.info "[#{current}] trouve, on passe #{indices} a son premier child "
					nextleaf = l
				end 
			end
			if nextleaf.nil?
				# logger.info "[#{current}] non trouve, on cree un item et on lui passe #{indices}"
				nextleaf = {:node => item.deployment, :parent => leaf, :child => [], :id => item.host.id, :level => item.level}
				leaf << nextleaf
			end
			register_item(item, indices, nextleaf[:child])
		end	
	end

	def expand_xml(tree)
		work = ""
		tree.each do |t|
			work = work + "<node name='#{t[:node].name}'>#{t[:node].hr}" + expand_xml(t[:child]) + "</node>"
		end
		work
	end

	def expand_rows(tree)
		key = ""
		if ! tree.nil?
			tree.each do |t|
				# logger.info t.inspect
				# logger.info "t[:parent].nil? = #{t[:parent].nil?}"
				if ! t[:parent].nil?
					key = t[:level]+"-"+t[:id].to_s
				end	
				# logger.info "clef = #{key}"
				if t[:child].empty?
					@work << ["#{t[:node].id}-#{t[:node].hr}", key, "#{t[:node].name}"]
				else
					@work << [{:v => (t[:level].to_i+1).to_s+"-"+t[:node].id.to_s, 
					           :f => t[:node].id.to_s+"-"+t[:node].hr}, 
							   key, "#{t[:node].name}"]
				end				
				expand_rows(t[:child])
			end
		end	
	end
	
	def get_xml_tree
		Deployment.path_down([id]).each do |row|
			@tree ||= [{:node => row.host, :parent => nil, :child => [], :id => nil, :level => "0"}]
			indices = row.path.split("/").reverse!
			register_item(row, indices, @tree)
		end
		@tree
		@work = []
		expand_rows(@tree)
		@work
	end
	
end
