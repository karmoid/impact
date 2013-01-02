class SubCategoriesController < ApplicationController
respond_to :html, :xml, :json

	def show
		@category = Category.find(params[:category_id])
		@sub_category = @category.sub_categories.find(params[:id])
		@categories = Category.all
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/tabs_deployments", :locals => { :category => @category, :sub_category => @sub_category, :categories => @categories }, :layout => false, :status => :ok
				else
					redirect_to :root
				end
			end
		end
	end

	def index
		@categories = Category.all
		@category = Category.find(params[:category_id])
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/tabs_sub_category", :locals => { :category => @category, :sub_categories => @category.sub_categories, :categories => @categories }, :layout => false, :status => :ok
				else
					redirect_to :root
				end
			end
		end
	end
	

	def new
		@category = Category.find(params[:category_id])
		@sub_category = @category.sub_categories.build
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/form_sub_category", :locals => {:category => @category, :sub_category => @sub_category}, :status => :ok
				end
			end
		end
	end
	
	def edit
		@category = Category.find(params[:category_id])
		@sub_category = @category.sub_categories.find(params[:id])
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/form_sub_category", :locals => {:category => @category, :sub_category => @sub_category}, :status => :ok
				end
			end
		end
	end
	

	def create
		@category = Category.find(params[:category_id])
		@sub_category = @category.sub_categories.build(params[:sub_category])
		@categories = Category.all
		if @sub_category.save
			respond_with do |format|
				format.html do
					if request.xhr?
						render :partial => "shared/tabs_sub_category", :locals => { :category => @category, :sub_categories => @category.sub_categories, :categories => @categories }, :layout => false, :status => :ok
					else
						redirect_to :root
					end
				end
			end
		else
			respond_with do |format|
				format.html do
					if request.xhr?
						render :json => @sub_category.errors, :status => :unprocessable_entity
					else
						render :action => :new, :status => :unprocessable_entity
					end
				end
			end
		end
	end

	def destroy
		@sub_category = SubCategory.find(params[:id])
		@category = @sub_category.category
		@categories = Category.all
		if @sub_category.destroy 
			@category.reload
			respond_with do |format|
				format.html do
					if request.xhr?
						render :partial => "shared/tabs_sub_category", :locals => { :category => @category, :sub_categories => @category.sub_categories, :categories => @categories }, :layout => false, :status => :ok
					else
						redirect_to :root
					end
				end
			end
		else
			respond_with do |format|
				format.html do
					if request.xhr?
						render :json => @sub_category.errors, :status => :unprocessable_entity
					else
						render :action => :new, :status => :unprocessable_entity
					end
				end
			end
		end
	end
	
	
	def update
		@category = Category.find(params[:category_id])
		@sub_category = @category.sub_categories.find(params[:id])
		@categories = Category.all
		if @sub_category.update_attributes(params[:sub_category])  
			respond_with do |format|
				format.html do
					@sub_categories = @category.sub_categories
					if request.xhr?
						render :partial => "shared/tabs_deployments", :locals => {:category => @category, :sub_category => @sub_category, :categories => @categories, :sub_categories => @sub_categories}, :status => :ok
					else
						redirect_to :root
					end
				end
			end
		else
			respond_with do |format|
				format.html do
					if request.xhr?
						render :json => @sub_category.errors, :status => :unprocessable_entity
					else
						render :action => :new, :status => :unprocessable_entity
					end
				end
			end
		end
	end
end
