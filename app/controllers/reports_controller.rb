class ReportsController < ApplicationController
  before_action :find_coupon

  def index
  end

  def sales
  end

  def coupons
    @coupons = Coupon.all
  end

  private

  def find_coupon
    if params.has_key?(:coupon_id) && params[:coupon_id].present?
      @coupon = Coupon.find params[:coupon_id]
      @order_items = @coupon.order_items
    end
  end
end
