module Grapes
  module V1
    class Trips < Grapes::API

      resource :trips do

        # Autor: Jackson Florez Jimenez
        #
        # Fecha creacion: 2021-06-03
        #
        # Autor actualizacion:
        #
        # Fecha actualizacion: 0000-00-00
        #
        # /api/v1/trips
        #
        # Verbo Http: GET
        #
        # Metodo: 
        desc 'Get all trips'
        get do
          Trip.all
          #{ response: "OK", trip: Trip.all}
        end

        # Autor: Jackson Florez Jimenez
        #
        # Fecha creacion: 2021-06-03
        #
        # Autor actualizacion:
        #
        # Fecha actualizacion: 0000-00-00
        #
        # /api/v1/trips/:id
        # /api/v1/trips/1
        #
        # Verbo Http: GET
        #
        # Metodo: 
        desc 'Get one trip'
        params do
          requires :id, type: Integer, desc: 'Trip ID.'
        end
        route_param :id do
          get do
            t = Trip.find(params[:id])
            #{ response: "OK", trip: t}
          rescue ActiveRecord::RecordNotFound
            error!('Trip not found',404)
          end
        end

        # Autor: Jackson Florez Jimenez
        #
        # Fecha creacion: 2021-06-03
        #
        # Autor actualizacion:
        #
        # Fecha actualizacion: 0000-00-00
        #
        # /api/v1/trips
        #
        # Verbo Http: POST
        #
        # Metodo: 
        desc 'Create trip or Begin Trip'
        params do
          requires :rider_id, type: Integer, desc: 'Id Rider'
          requires :driver_id, type: Integer, desc: 'Id Driver'
          requires :lat_ini, type: String, desc: 'Starting latitude'
          requires :lng_ini, type: String, desc: 'Starting longitude'
          optional :lat_end, type: String, desc: 'Ending latitude'
          optional :lng_end, type: String, desc: 'Ending Longitude'
          optional :distance_km, type: Integer, desc: 'Distance KM calculated by geocoder'
          optional :minutes, type: Integer, desc: 'Lapse of minutes'
          optional :base_fee, type: Integer, desc: 'Base fee default 3500'
          optional :total_fee, type: Integer, desc: 'Total fee'
        end
        post do
          declared_params = declared(params).reject{|_, v| v.blank?}

          tnv = TripNewValidate.new
          tnv = tnv.call(declared_params)
          if tnv.success?
            t = Trip.create!(declared_params)
            { response: "Successfully created trip!", trip: t}
          else
            { error: tnv.errors.first.to_s}
          end
        end

        # Autor: Jackson Florez Jimenez
        #
        # Fecha creacion: 2021-06-03
        #
        # Autor actualizacion:
        #
        # Fecha actualizacion: 0000-00-00
        #
        # /api/v1/trips/:id
        # /api/v1/trips/1
        #
        # Verbo Http: PUT
        #
        # Metodo: 
        desc 'Update trip or End Trip'
        params do
          optional :rider_id, type: Integer, desc: 'Id Rider'
          optional :driver_id, type: Integer, desc: 'Id Driver'
          optional :lat_ini, type: String, desc: 'Starting latitude'
          optional :lng_ini, type: String, desc: 'Starting longitude'
          optional :lat_end, type: String, desc: 'Ending latitude'
          optional :lng_end, type: String, desc: 'Ending Longitude'
          optional :distance_km, type: Integer, desc: 'Distance KM calculated by geocoder'
          optional :minutes, type: Integer, desc: 'Lapse of minutes'
          optional :base_fee, type: Integer, desc: 'Base fee default 3500'
          optional :total_fee, type: Integer, desc: 'Total fee'
        end
        route_param :id do
          put do
            t = Trip.find(params[:id])

            declared_params = declared(params).reject{|_, v| v.blank?}

            tuv = TripUpdateValidate.new
            tuv = tuv.call(declared_params)
            if tuv.success?
              t.update!(declared_params)
              { response: "Successfully updated trip!", trip: t}
            else
              { error: tuv.errors.first.to_s}
            end
          rescue ActiveRecord::RecordNotFound
            #error!('Trip not found',404)
            { error: 'Trip not found'}
          end
        end

        # Autor: Jackson Florez Jimenez
        #
        # Fecha creacion: 2021-06-03
        #
        # Autor actualizacion:
        #
        # Fecha actualizacion: 0000-00-00
        #
        # /api/v1/trips/:id
        # /api/v1/trips/1
        #
        # Verbo Http: DELETE
        #
        # Metodo: 
        desc 'Delete trip'
        params do
          requires :id, type: Integer, desc: 'Trip ID.'
        end
        route_param :id do
          delete do
            Trip.find(params[:id]).delete
            { response: "Successfully deleted trip!"}
          rescue ActiveRecord::RecordNotFound
            error!('Trip not found',404)
          end
        end

      end

    end
  end
end
