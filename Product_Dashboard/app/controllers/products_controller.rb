class ProductsController < ApplicationController
  def index
  	@products = Product.all

  end

  def show
  	@product = Product.find(params[:id])
  end

  def new
  	if params[:flash]
  		a = params[:flash]
  		@message = a[:errors]
  	else
  		@message = Array.new
  	end
  	@categories = Category.all
  end

  def create
  	a = Product.new(product_params)
  	if a.save
  		redirect_to action: 'index'
  	else
  		redirect_to action: 'new', flash: {errors: a.errors.full_messages}
  	end
  end

  def edit
  	@product = Product.find(params[:id])
  	if params[:flash]
  		a = params[:flash]
  		@message = a[:errors]
  	else
  		@message = Array.new
  	end
  	@categories = Category.all
  end

  def update
  	a = Product.find(params[:id])
  	if a.update(product_params)
  		redirect_to action: 'index'
  	else
  		redirect_to action: 'edit', flash: {errors: a.errors.full_messages}
  	end
  end

  def destroy
  	a = Product.find(params[:id])
  	a.destroy
  	redirect_to action: 'index'
  end

  private
  def product_params
  	params.require(:product).permit(:name,:description,:price,:category_id)
  end

end
