class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,  only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = Product.order(:title)
  end

  def show
  end

  # Currently unused
  def new
    @product = Product.new
  end

  # Currently unused
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, success: "Product created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # Currently unused
  def edit
  end

  # Currently unused
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, success: "Product updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # Currently unused
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, success: "Product destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def product_params
      params.require(:product).permit(:title, :description, :price)
    end

    def set_product
      @product = Product.find(params[:id])
    end
end
