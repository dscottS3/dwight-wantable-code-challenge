class OrdersController < ApplicationController
  before_action :find_order!, only: [:show, :cancel]

  def index
    @orders = Order.all.paginate page: params[:page]
    filter_orders
  end

  def show
  end

  def cancel
    @order.canceled!
    @order.order_items.update_all(state: OrderItem::RETURNED)
    @order.payments.update_all(state: Payment::REFUNDED, refunded_at: Time.now)

    redirect_to @order, flash: { notice: 'Order was successfully canceled' }
  end

  private

  def filter_orders
    if (params.has_key?(:q) && params[:q].present?)
      @orders = @orders.search params[:q]
    end

    if (params.has_key?(:user_id) && params[:user_id].present?)
      @orders = @orders.where(user_id: params[:user_id])
    end

    if (params.has_key?(:state) && params[:state].present?)
      @orders = @orders.where(state: params[:state])
    end
  end

  def find_order!
    @order = Order.find_by!(number: params[:number])
  end
end
