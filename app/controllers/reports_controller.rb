class ReportsController < ApplicationController
  before_action :find_coupon, only: :coupons

  def index
  end

  def sales
    @order_items = OrderItem.sold
    @products = Product.with_sales

    unless dates.empty?
      @products = @products.between([dates[:start], dates[:end]])
      @order_items = @order_items.between([dates[:start], dates[:end]])
    end

    @products = @products.group(:id).paginate(page: params[:page])
  end

  def coupons
    @coupons = Coupon.all
  end

  private

  def dates
    return {} if params[:start].blank? || params[:end].blank?
    starting = %w(1 2 3).map { |d| params["start"]["(#{d}i)"].to_i }
    ending = %w(1 2 3).map { |d| params["end"]["(#{d}i)"].to_i }
    {
      start: Date.new(starting[0], starting[1], starting[2]).beginning_of_day,
      end: Date.new(ending[0], ending[1], ending[2]).end_of_day
    }
  end

  def find_coupon
    if params.has_key?(:coupon_id) && params[:coupon_id].present?
      @coupon = Coupon.find params[:coupon_id]
      @order_items = @coupon.order_items
    end
  end
end
