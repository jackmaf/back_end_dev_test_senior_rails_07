module Grapes
  class API < Grape::API
    format :json
    prefix :api
    version 'v1', :path

    mount Grapes::V1::Drivers
  end
end
