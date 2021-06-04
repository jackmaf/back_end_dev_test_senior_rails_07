require 'rails_helper'
require 'pry'

RSpec.describe "Api Trip", type: :request do
  describe 'POST /api/v1/payments create trip' do
    
    context "1. No send params" do
      it "1.1 No send params" do
        
        post "/api/v1/trips"
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "rider_id is missing, driver_id is missing, lat_ini is missing, lng_ini is missing"
      end
    end

    context "2. Params nil" do
      let!(:params) { { rider_id: "", driver_id: "", lat_ini: "", lng_ini: "" } }
      it "2.1 Params nil" do
        
        post "/api/v1/trips", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "is missing"
      end
    end
    
    context "3. Rider no exist" do
      let!(:params) { { rider_id: 100, driver_id: 1, lat_ini: "5.0", lng_ini: "-75.50" } }
      it "3.1 Rider no exist" do
        
        post "/api/v1/trips", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "Rider no exist"
      end
    end

    context "4. Driver no exist" do
      let!(:params) { { rider_id: 1, driver_id: 100, lat_ini: "5.0", lng_ini: "-75.50" } }
      it "4.1 Driver no exist" do
        
        post "/api/v1/trips", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "Driver no exist"
      end
    end

    context "5. Latitude invalid format" do
      let!(:params) { { rider_id: 1, driver_id: 1, lat_ini: "error", lng_ini: "-75.50" } }
      it "5.1 Latitude invalid format" do
        
        post "/api/v1/trips", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "Latitude invalid format"
      end
    end

    context "6. Longitude invalid format" do
      let!(:params) { { rider_id: 1, driver_id: 1, lat_ini: "5.0", lng_ini: "error" } }
      it "6.1 Longitude invalid format" do
        
        post "/api/v1/trips", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "Longitude invalid format"
      end
    end 
   
    context "7. Correct params" do
      let!(:params) { { rider_id: 1, driver_id: 6, lat_ini: "5.0", lng_ini: "-75.50" } }
      it "7.1 creates a new trip" do
        
        post "/api/v1/trips", params: params
        #binding.pry
        expect(JSON.parse(response.body)["trip"]["rider_id"]).to eq 1
      end
    end

  end


  describe 'PUT /api/v1/trips/1 create trip' do
    
    context "1. No send params" do
      it "1.1 No send params" do
        
        put "/api/v1/trips"
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "405 Not Allowed"
      end
    end

    context "2. No exist trip" do
      let!(:params) { { rider_id: "", driver_id: "", lat_ini: "", lng_ini: "" } }
      it "2.1 No exist trip" do
        
        put "/api/v1/trips/100", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "Trip not found"
      end
    end

    context "3. Params nil" do
      let!(:params) { { minutes: "", lat_end: "", lng_end: "" } }
      it "3.1 No Params" do
        
        put "/api/v1/trips/1"#, params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "is missing"
      end
      
      it "3.2 Params nil" do
        
        put "/api/v1/trips/1", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "is missing"
      end
    end
    
    context "4. Minutes zero" do
      let!(:params) { { minutes: "0", lat_end: "5.0", lng_end: "-75.50" } }
      it "4.1 Minutes zero" do
        
        put "/api/v1/trips/1", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "Minutes can not zero"
      end

      let!(:params) { { minutes: 0, lat_end: "5.0", lng_end: "-75.50" } }
      it "4.2 Minutes zero" do
        
        put "/api/v1/trips/1", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "Minutes can not zero"
      end
    end

    context "5. Latitude invalid format" do
      let!(:params) { { minutes: 10, lat_end: "error", lng_end: "-75.50" } }
      it "5.1 Latitude invalid format" do
        
        put "/api/v1/trips/1", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "Latitude invalid format"
      end
    end

    context "6. Longitude invalid format" do
      let!(:params) { { minutes: 0, lat_end: "5.0", lng_end: "error" } }
      it "6.1 Longitude invalid format" do
        
        put "/api/v1/trips/1", params: params
        #binding.pry
        expect(JSON.parse(response.body)["error"]).to eq "Longitude invalid format"
      end
    end 
   
    context "7. Correct params" do
      let!(:params) { { minutes: 10, lat_end: "5.0", lng_end: "-75.50" } }
      it "7.1 update or end trip" do
        
        put "/api/v1/trips/1", params: params
        #binding.pry
        expect(JSON.parse(response.body)["response"]).to eq "Successfully updated trip!"
      end
    end

  end



end
