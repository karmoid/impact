class DeploymentsController < ApplicationController
respond_to :html, :xml, :json
  def index
	@categories = Category.all
	@category = Category.find(params[:category_id])
	@sub_category = @category.sub_categories.find(params[:sub_category_id])
	respond_with do |format|
		format.html do
			if request.xhr?
				render :partial => "shared/tabs_deployments", :locals => {:category => @category, :sub_category => @sub_category, :categories => @categories}, :status => :ok
			end
		end
	end
  end
  
	def edit
		@category = Category.find(params[:category_id])
		@sub_category = @category.sub_categories.find(params[:sub_category_id])
		@deployment = @sub_category.deployments.find(params[:id])
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/form_deployment", :locals => {:category => @category, :sub_category => @sub_category, :deployment => @deployment}, :status => :ok
				end
			end
		end
	end

	def stack
		@deployment = Deployment.find(params[:id])
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/stack_deployment", :locals => {:deployment => @deployment}, :status => :ok
				end
			end
		end
	end
	
	def new
		@category = Category.find(params[:category_id])
		@sub_category = @category.sub_categories.find(params[:sub_category_id])
		@deployment = @sub_category.deployments.build
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/form_deployment", :locals => {:category => @category, :sub_category => @sub_category, :deployment => @deployment}, :status => :ok
				end
			end
		end
	end

	def create
		@category = Category.find(params[:category_id])
		@sub_category = @category.sub_categories.find(params[:sub_category_id])
		@deployment = @sub_category.deployments.build(params[:deployment])
		if @deployment.save  
			respond_with do |format|
				format.html do
					if request.xhr?
						render :partial => "shared/tabs_deployment_list" , :locals => {:category => @category, :sub_category => @sub_category}, :status => :created
					else
						redirect_to :root
					end
				end
			end
		else
			respond_with do |format|
				format.html do
					if request.xhr?
						render :json => @deployment.errors, :status => :unprocessable_entity
					else
						render :action => :new, :status => :unprocessable_entity
					end
				end
			end
		end
	end

	def update
		# @category = Category.find(params[:category_id])
		# @sub_category = @category.sub_categories.find(params[:sub_category_id])
		@deployment = Deployment.find(params[:id])
		if @deployment.update_attributes(params[:deployment])  
			respond_with do |format|
				format.html do
					if request.xhr?
						render :partial => "shared/tabs_deployment_list" , :locals => {:category => @category, :sub_category => @sub_category}, :status => :created
					else
						redirect_to :root
					end
				end
			end
		else
			respond_with do |format|
				format.html do
					if request.xhr?
						render :json => @deployment.errors, :status => :unprocessable_entity
					else
						render :action => :new, :status => :unprocessable_entity
					end
				end
			end
		end
	end
  
end
