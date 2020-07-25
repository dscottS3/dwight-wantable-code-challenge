require 'rails_helper'

RSpec.describe Address, type: :model do
  context '#city_state_zip' do
    let(:address) { create :address }

    it 'concatenates city, state and zip' do
      result = "#{address.city}, #{address.state} #{address.zipcode}"
      expect(address.city_state_zip).to eq result
    end
  end
end
