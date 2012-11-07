class SubCategoriesController < ApplicationController
respond_to :html, :xml, :json

	def new
		@category = Category.find(params[:category_id])
		@sub_category = @category.sub_categories.build
		respond_with do |format|
			format.html do
				if request.xhr?
					render :partial => "shared/new_sub_category", :locals => {:category => @category, :sub_category => @sub_category}, :status => :ok
				end
			end
		end
	end

	def create
		@category = Category.find(params[:category_id])
		@sub_category = @category.sub_categories.build(params[:sub_category])
		if @sub_category.save
			respond_with do |format|
				format.html do
					if request.xhr?
						render :partial => "shared/tabs_category", :locals => {:category => @category}, :status => :created
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
