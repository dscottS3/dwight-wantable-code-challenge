require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'pagination' do
    let(:created_orders) { create_list :order, 30 }
    let(:orders) { Order.all }

    it 'paginates per 10 records' do
      expect(orders.paginate(page: 1)).to eq orders.first(10)
      expect(orders.paginate(page: 3)).to eq orders.last(10)
    end
  end

  context '#color_class' do
    it 'has a state of building' do
      order = create :order, :building
      expect(order.color_class).to eq 'info'
    end

    it 'has a state of arrived' do
      order = create :order, :arrived
      expect(order.color_class).to eq 'success'
    end

    it 'has a state of canceled' do
      order = create :order, :canceled
      expect(order.color_class).to eq 'danger'
    end

    it 'has a different state' do
      order = create :order, state: 'something'
      expect(order.color_class).to eq 'primary'
    end
  end

  context '.search' do
    let(:order) { create :order }
    let!(:order2) { create :order }
    let(:user) { order.user }

    it 'searches by order number' do
      expect(Order.search(order.number).count).to eq 1
      expect(Order.count).to eq 2
    end

    it 'searches by order id' do
      expect(Order.search(order.id.to_s).count).to eq 1
      expect(Order.count).to eq 2
    end

    it 'searches by user email address' do
      expect(Order.search(user.email).count).to eq 1
      expect(Order.count).to eq 2
    end

    it 'searches by user name' do
      expect(Order.search(user.name).count).to eq 1
      expect(Order.count).to eq 2
    end

    it 'does fuzzy search on name' do
      expect(Order.search(user.name.first(4))).to_not be_empty
      expect(Order.count).to eq 2
    end

    it 'does fuzzy search on email' do
      expect(Order.search(user.name.first(5))).to_not be_empty
      expect(Order.count).to eq 2
    end
  end

  context 'delegations' do
    let(:order) { create :order }
    let(:user) { order.user }

    it 'delegates user_name' do
      expect(order.user_name).to eq user.name
    end

    it 'delegates user_email' do
      expect(order.user_email).to eq user.email
    end
  end
end
