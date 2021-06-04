require 'rails_helper'
require 'pry'

RSpec.describe "Api Payment", type: :request do
  describe 'POST /api/v1/payments create payment' do
    
    context "1. No send params" do
      it "1.1 No send params" do
        
        post "/api/v1/payments"
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "trip_id is missing"
      end
    end

    context "2. Params nil" do
      let!(:params) { { trip_id: "" } }
      it "2.1 Params nil" do
        
        post "/api/v1/payments", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "is missing"
      end
    end
    
    context "3. Trip no exist" do
      let!(:params) { { trip_id: "100" } }
      it "3.1 Trip no exist" do
        
        post "/api/v1/payments", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "Trip no exist"
      end
    end

    context "4. Correct params" do
      let!(:params) { { trip_id: "1" } }
      it "4.1 creates a new driver" do
        
        post "/api/v1/payments", params: params
        #binding.pry
        expect(JSON.parse(response.body)["payment"]["trip_id"]).to eq 1
      end
    end

  end
end
