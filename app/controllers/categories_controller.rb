class CategoriesController < ApplicationController
respond_to :html, :xml, :json

	def index
		@categories = Category.all
		@category = Category.new
	end

	# New action : Creating Category 
	def new
	end

	def show
		@category = Category.find(params[:id])
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/tabs_category", :locals => { :category => @category }, :layout => false, :status => :created
				else
					redirect_to :root
				end
			end
		end
	end
	
	def create
	  @category = Category.new( params[:category] )

	  if @category.save
		respond_with do |format|
		  format.html do
			if request.xhr?
			  render :partial => "categories/show", :locals => { :category => @category }, :layout => false, :status => :created
			else
			  redirect_to :root
			end
		  end
		end
	  else
		respond_with do |format|
		  format.html do
			if request.xhr?
			  render :json => @category.errors, :status => :unprocessable_entity
			else
			  render :action => :new, :status => :unprocessable_entity
			end
		  end
		end
	  end
	end
end
