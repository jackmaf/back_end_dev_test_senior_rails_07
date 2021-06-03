module Grapes
  module V1
    class Drivers < Grapes::API

      resource :drivers do

        # Autor: Jackson Florez Jimenez
        #
        # Fecha creacion: 2021-06-03
        #
        # Autor actualizacion:
        #
        # Fecha actualizacion: 0000-00-00
        #
        # /api/v1/drivers
        #
        # Verbo Http: GET
        #
        # Metodo: 
        desc 'Get all drivers'
        get do
          Driver.all
          #{ response: "OK", driver: Driver.all}
        end

        # Autor: Jackson Florez Jimenez
        #
        # Fecha creacion: 2021-06-03
        #
        # Autor actualizacion:
        #
        # Fecha actualizacion: 0000-00-00
        #
        # /api/v1/drivers/:id
        # /api/v1/drivers/1
        #
        # Verbo Http: GET
        #
        # Metodo: 
        desc 'Get one driver'
        params do
          requires :id, type: Integer, desc: 'Driver ID.'
        end
        route_param :id do
          get do
            d = Driver.find(params[:id])
            #{ response: "OK", driver: d}
          rescue ActiveRecord::RecordNotFound
            error!('Driver not found',404)
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
        # /api/v1/drivers
        #
        # Verbo Http: POST
        #
        # Metodo: 
        desc 'Create driver'
        params do
          requires :name, type: String, desc: 'Name Driver'
          requires :plate_vehicle, type: String, desc: 'Plate Vehicle'
        end
        post do
          d = Driver.create!(declared(params).reject{|_, v| v.blank?})
          { response: "Successfully created driver!", driver: d}
        end

        # Autor: Jackson Florez Jimenez
        #
        # Fecha creacion: 2021-06-03
        #
        # Autor actualizacion:
        #
        # Fecha actualizacion: 0000-00-00
        #
        # /api/v1/drivers/:id
        # /api/v1/drivers/1
        #
        # Verbo Http: PUT
        #
        # Metodo: 
        desc 'Update driver'
        params do
          requires :name, type: String, desc: 'Name Driver'
          requires :plate_vehicle, type: String, desc: 'Plate Vehicle'
        end
        route_param :id do
          put do
            d = Driver.find(params[:id])
            d.update!(declared(params).reject{|_, v| v.blank?})
            { response: "Successfully updated driver!", driver: d}
          rescue ActiveRecord::RecordNotFound
            error!('Driver not found',404)
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
        # /api/v1/drivers/:id
        # /api/v1/drivers/1
        #
        # Verbo Http: DELETE
        #
        # Metodo: 
        desc 'Delete driver'
        params do
          requires :id, type: Integer, desc: 'Driver ID.'
        end
        route_param :id do
          delete do
            Driver.find(params[:id]).delete
            { response: "Successfully deleted driver!"}
          rescue ActiveRecord::RecordNotFound
            error!('Driver not found',404)
          end
        end

      end

    end
  end
end
