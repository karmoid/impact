module DeploymentsHelper

	def flag_helper( deploy )
		if deploy.stacked
			link_to raw('<b class="swap icon-tag"></b>'), deployment_path(deploy, "deployment[stacked]" => false), :method => :put, :class => "swap", :remote => true
		else	
			link_to raw('<b class="swap icon-flag"></b>'), deployment_path(deploy, "deployment[stacked]" => true), :method => :put, :class => "swap", :remote => true
		end
	end
end
