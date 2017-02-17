class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart,          only: [:create, :destroy, :update]
  before_action :set_line_item,     only: [:update, :destroy]

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to products_path }
        format.js   { }
        format.json { render action: "show", status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @cart, success: "Quantity updated." }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { redirect_to @cart, warning: "Something went wrong." }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      if @cart.line_items.empty?
        format.html { redirect_to products_url, warning: "Your cart is empty", success: "Product was removed from cart." }
        format.json { head :no_content }
      else
        format.html { redirect_to @cart, success: "Product was removed from cart." }
        format.json { head :no_content }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :quantity)
    end
end
