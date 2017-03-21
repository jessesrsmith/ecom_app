class OrdersController < ApplicationController
  before_action :set_cart,       only: [:new, :create]
  before_action :set_order,      only: [:show, :edit, :update, :destroy]
  # Admin action for future functionality
  before_action :admin_user,     only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create]

  # Currently unused
  def index
    @orders = current_user.orders
  end

  # Currently unused
  def show
  end

  def new
    if @cart.line_items.empty?
      redirect_to products_url, warning: "Your cart is empty"
    end
  end

  def edit
  end

  def create
    @charge = Order.place_stripe_order(params[:stripeEmail], params[:stripeToken], @cart.price_in_cents)

    # DB Order
    @order = current_user.orders.build do |o|
      o.name = params[:stripeBillingName]
      o.total = @cart.total_price
    end

    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @charge && @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        format.html { redirect_to products_url, success: "Thanks for your order." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, warning: "Something went wrong." }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # Currently unused
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # Currently unused
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.permit(:stripeBillingName, :stripeToken, :stripeEmail)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in or #{view_context.link_to('sign up', signup_path)} to complete your order."
        redirect_to login_url
      end
    end
end
