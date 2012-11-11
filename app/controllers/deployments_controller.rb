class DeploymentsController < ApplicationController
respond_to :html, :xml, :json
  def index
	@category = Category.find(params[:category_id])
	@sub_category = @category.sub_categories.find(params[:sub_category_id])
	respond_with do |format|
		format.html do
			if request.xhr?
				render :partial => "shared/tabs_deployments", :locals => {:category => @category, :sub_category => @sub_category}, :status => :ok
			end
		end
	end
  end
end
