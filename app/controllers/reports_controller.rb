class ReportsController < ApplicationController
  before_action :find_coupon, only: :coupons

  def index
  end

  def sales
    @products = Product.with_sales.group(:id).paginate(page: params[:page])
    @order_items = OrderItem.sold
    unless dates.empty?
      @products = @products.between([dates[:start_date], dates[:end_date]])
      @order_items = @order_items.between([dates[:start_date], dates[:end_date]])
    end
  end

  def coupons
    @coupons = Coupon.all
  end

  private

  def dates
    return {} if params[:start].blank? || params[:end].blank?
    start_date = %w(1 2 3).map { |e| params["start"]["(#{e}i)"].to_i }
    end_date = %w(1 2 3).map { |e| params["end"]["(#{e}i)"].to_i }
    {
      start_date: Date.new(start_date[0], start_date[1], start_date[2]),
      end_date: Date.new(end_date[0], end_date[1], end_date[2])
    }
  end

  def find_coupon
    if params.has_key?(:coupon_id) && params[:coupon_id].present?
      @coupon = Coupon.find params[:coupon_id]
      @order_items = @coupon.order_items
    end
  end
end
