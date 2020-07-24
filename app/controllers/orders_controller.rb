class OrdersController < ApplicationController
  before_action :find_order!, only: :show

  def index
    @orders = Order.all.paginate page: params[:page]
    filter_orders
  end

  def show
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
