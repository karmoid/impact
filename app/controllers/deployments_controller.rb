class DeploymentsController < ApplicationController
respond_to :html, :xml, :json
  def index
	@categories = Category.all
	@category = Category.find(params[:category_id])
	@sub_categories = @category.sub_categories
	@sub_category = @category.sub_categories.find(params[:sub_category_id])
	respond_with do |format|
		format.html do
			if request.xhr?
				render :partial => "shared/tabs_deployments", :locals => {:category => @category, :sub_category => @sub_category, :categories => @categories, :sub_categories => @sub_categories}, :status => :ok
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

	def show
		@category = Category.find(params[:category_id])
		@sub_category = @category.sub_categories.find(params[:sub_category_id])
		@deployment = @sub_category.deployments.find(params[:id])
		@categories = Category.all
		@sub_categories = @category.sub_categories
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/show_deployment", :locals => {:category => @category, :sub_category => @sub_category, :deployment => @deployment, :categories => @categories, :sub_categories => @sub_categories}, :status => :ok
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

	def list
		@search ||= params[:search].upcase()
		@deployments = Deployment.joins(:sub_category => :category).where(
		"upper(deployments.name) similar to :parm or upper(deployments.hr) similar to :parm or upper(sub_categories.name) similar to :parm or upper(sub_categories.hr) similar to :parm ", :parm => @search).order("categories.name, sub_categories.name")
		#@deployments.each do |d|
		#	logger.info "hr:#{d.hr} name:#{d.name} sc.hr:#{d.sub_category.hr} sc.name:#{d.sub_category.name}"
		#end 
		@link = ! params[:id].nil?
		logger.info "[#{params[:id]}] @link=#{@link}"
		if @link
			@deployment = Deployment.find(params[:id])
		end	
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/list", :locals => {:deployments => @deployments, :deployment => @deployment, :link => @link}, :status => :ok
				end
			end
		end	
	end


	
	def hosts
		list_linked(true)
	end

	def conx
		list_linked(false)
	end
	
	def addconx
		@inverse = params[:inverse_val]==true.to_s
		@deployment = Deployment.find(params[:id])
		@deploymentlink = Deployment.find(params[:deployment_id])
		@deployment.connections << @deploymentlink
		logger.info "on ajoute une liaison entre id:#{params[:id]}-#{@deployment.hr} & deployment_id:#{params[:deployment_id]}-#{@deploymentlink.hr} inverse_val:#{@inverse}"
		@deployment = Deployment.find(@inverse ? params[:deployment_id] : params[:id])
		logger.info "on retourne sur id:#{@deployment.id}-#{@deployment.hr}"
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/tabs_connections_list", :locals => {:deployment => @deployment}, :status => :ok
				end
			end
		end
	end
	
	def delconx
		@inverse = params[:inverse_val]==true.to_s
		@deployment = Deployment.find(params[:id])
		@deploymentlink = Deployment.find(params[:deployment_id])
		@deployment.connections.delete(@deploymentlink)
		logger.info "on supprime la liaison entre id:#{params[:id]}-#{@deployment.hr} & deployment_id:#{params[:deployment_id]}-#{@deploymentlink.hr} inverse_val:#{@inverse}"
		@deployment = Deployment.find(@inverse ? params[:deployment_id] : params[:id])
		logger.info "on retourne sur id:#{@deployment.id}-#{@deployment.hr}"
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/tabs_connections_list", :locals => {:deployment => @deployment}, :status => :ok
				end
			end
		end
	end

	def swapconx
		@inverse = params[:inverse_val]==true.to_s
		@deployment = Deployment.find(params[:id])
		@deploymentlink = Deployment.find(params[:deployment_id])
		@deployment.connections.delete(@deploymentlink)
		@deploymentlink.connections << @deployment 
		@deployment = Deployment.find(@inverse ? params[:deployment_id] : params[:id])
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/tabs_connections_list", :locals => {:deployment => @deployment}, :status => :ok
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
						@deployments_stacked = Deployment.joins(:sub_category => :category).where(:stacked => true).order("categories.name")
						render :partial => "shared/menu_stacked" , :locals => {:stack => @deployments_stacked, :align => "pull-right" }, :status => :created
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
private
	def list_linked(hosts)
		@deployment = Deployment.find(params[:id])
		@deployments_stacked = Deployment.joins(:sub_category => :category).where(:stacked => true).order("categories.name")
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/list_deployments", :locals => {:deployment => @deployment, :hosts => hosts, :link => true}, :status => :ok
				end
			end
		end
	end
end
