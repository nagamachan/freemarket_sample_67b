class ProductsController < ApplicationController
  before_action :set_product

  def show 
    @parents = Category.all.order("id ASC").limit(13)
    @parent = Category.find(params[:id])
  end

  def new
    @product = Product.new
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end
 
  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

 
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def destroy
    product.destroy
    @users = User.all
    if @product.destroy
      render template: "user/:id"
    else
      logger.error e 
      logger.error e.backtrace.join("\n") 
    end
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end
end
