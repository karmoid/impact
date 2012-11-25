module DeploymentsHelper

	def flag_helper( deploy )
		if deploy.stacked
			link_to raw(' <i class="icon-tag"></i>'), deployment_path(deploy, "deployment[stacked]" => false), :method => :put
		else	
			link_to raw(' <i class="icon-flag"></i>'), deployment_path(deploy, "deployment[stacked]" => true), :method => :put, :class => "auto-hide", :style => "display: none;"
		end
	end
end
