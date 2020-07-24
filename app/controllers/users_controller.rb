class UsersController < ApplicationController
  before_action :find_user

  def show
    @payments = Payment.joins(:order).where(orders: { user_id: @user.id })
    @order_items = OrderItem.joins(:order).where(orders: { user_id: @user.id })
  end

  private

  def find_user
    @user = User.find params[:id]
  end
end
