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
    customer = ChargeService.create_customer(params[:stripeEmail], params[:stripeToken])
    @charge = ChargeService.place_order(customer, @cart.total_in_cents)
    @order = current_user.orders.build(order_params)
    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @charge && @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        format.html { redirect_to orders_url, success: "Thanks for your order." }
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
      if @order.update(update_params)
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
      {
        billing_name:     params[:stripeBillingName],
        billing_country:  params[:stripeBillingAddressCountryCode],
        billing_zip:      params[:stripeBillingAddressZip],
        billing_address:  params[:stripeBillingAddressLine1],
        billing_city:     params[:stripeBillingAddressCity],
        billing_state:    params[:stripeBillingAddressState],
        shipping_name:    params[:stripeShippingName],
        shipping_country: params[:stripeShippingAddressCountryCode],
        shipping_zip:     params[:stripeShippingAddressZip],
        shipping_address: params[:stripeShippingAddressLine1],
        shipping_city:    params[:stripeShippingAddressCity],
        shipping_state:   params[:stripeShippingAddressState],
        total:            @cart.total_in_cents
      }
    end

    def update_params
      {
        billing_name:     params[:stripeBillingName],
        billing_country:  params[:stripeBillingAddressCountryCode],
        billing_zip:      params[:stripeBillingAddressZip],
        billing_address:  params[:stripeBillingAddressLine1],
        billing_city:     params[:stripeBillingAddressCity],
        billing_state:    params[:stripeBillingAddressState],
        shipping_name:    params[:stripeShippingName],
        shipping_country: params[:stripeShippingAddressCountryCode],
        shipping_zip:     params[:stripeShippingAddressZip],
        shipping_address: params[:stripeShippingAddressLine1],
        shipping_city:    params[:stripeShippingAddressCity],
        shipping_state:   params[:stripeShippingAddressState],
        total:            params[:total]
      }
    end
      

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in or #{view_context.link_to('sign up', signup_path)} to complete your order."
        redirect_to login_url
      end
    end
end
