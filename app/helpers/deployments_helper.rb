module DeploymentsHelper

	def flag_helper( deploy )
		if deploy.stacked
			link_to raw(' <i class="icon-tag"></i>'), deployment_path(deploy, "deployment[stacked]" => false), :method => :put, :remote => true
		else	
			link_to raw(' <i class="icon-flag"></i>'), deployment_path(deploy, "deployment[stacked]" => true), :method => :put, :remote => true, :style => "display: none;"
		end
	end
end
