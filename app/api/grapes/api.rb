module Grapes
  class API < Grape::API
    format :json
    prefix :api
    version 'v1', :path

    mount Grapes::V1::Drivers
    mount Grapes::V1::Riders
    mount Grapes::V1::Payments
    mount Grapes::V1::Trips
  end
end
