require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET index' do
    it 'assigns @orders' do
      order = create :order

      get :index
      expect(assigns(:orders)).to eq([order])
    end

    it 'filters order by state' do
      10.times { create :order }

      get :index, params: { state: Order::ARRIVED }
      expect(assigns(:orders).collect(&:state).uniq.first).to eq Order::ARRIVED
      expect(Order.count).to eq 10
    end

    it 'filters order by user' do
      10.times { create :order }

      get :index, params: { user_id: Order.first.user.id }
      expect(assigns(:orders)).to eq Order.first.user.orders
      expect(Order.count).to eq 10
    end

    it 'filters order when searching' do
      10.times { create :order }

      get :index, params: { q: Order.last.number }
      expect(assigns(:orders)).to eq [Order.last]
      expect(Order.count).to eq 10
    end
  end

  describe 'PATCH cancel' do
    let(:order) { create :order, :building }

    it 'cancels the order' do
      patch :cancel, params: { number: order.number }
      expect(assigns(:order).canceled?).to eq true
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET show' do
    it 'assigns @order' do
      10.times { create :order }
      order = Order.order('RANDOM()').first

      get :show, params: { number: order.number }
      expect(assigns(:order).number).to eq order.number
    end
  end
end
