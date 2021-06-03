module Grapes
  module V1
    class Riders < Grapes::API

      resource :riders do

        # Autor: Jackson Florez Jimenez
        #
        # Fecha creacion: 2021-06-03
        #
        # Autor actualizacion:
        #
        # Fecha actualizacion: 0000-00-00
        #
        # /api/v1/riders
        #
        # Verbo Http: GET
        #
        # Metodo: 
        desc 'Get all riders'
        get do
          Rider.all
          #{ response: "OK", rider: rider.all}
        end

        # Autor: Jackson Florez Jimenez
        #
        # Fecha creacion: 2021-06-03
        #
        # Autor actualizacion:
        #
        # Fecha actualizacion: 0000-00-00
        #
        # /api/v1/riders/:id
        # /api/v1/riders/1
        #
        # Verbo Http: GET
        #
        # Metodo: 
        desc 'Get one rider'
        params do
          requires :id, type: Integer, desc: 'Rider ID.'
        end
        route_param :id do
          get do
            r = Rider.find(params[:id])
            #{ response: "OK", rider: r}
          rescue ActiveRecord::RecordNotFound
            error!('Rider not found',404)
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
        # /api/v1/riders
        #
        # Verbo Http: POST
        #
        # Metodo: 
        desc 'Create rider'
        params do
          requires :name, type: String, desc: 'Name Rider'
          requires :email, type: String, desc: 'Email'
          requires :phone_number, type: String, desc: 'Phone Number' 
        end
        post do
          r = Rider.create!(declared(params))
          { response: "Successfully created rider!", rider: r}
        end

        # Autor: Jackson Florez Jimenez
        #
        # Fecha creacion: 2021-06-03
        #
        # Autor actualizacion:
        #
        # Fecha actualizacion: 0000-00-00
        #
        # /api/v1/riders/:id
        # /api/v1/riders/1
        #
        # Verbo Http: PUT
        #
        # Metodo: 
        desc 'Update rider'
        params do
          requires :name, type: String, desc: 'Name Rider'
          requires :email, type: String, desc: 'Email'
          requires :phone_number, type: String, desc: 'Phone Number'
        end
        route_param :id do
          put do
            r = Rider.find(params[:id])
            r.update!(declared(params))
            { response: "Successfully updated rider!", rider: r}
          rescue ActiveRecord::RecordNotFound
            error!('Rider not found',404)
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
        # /api/v1/riders/:id
        # /api/v1/riders/1
        #
        # Verbo Http: DELETE
        #
        # Metodo: 
        desc 'Delete rider'
        params do
          requires :id, type: Integer, desc: 'Rider ID.'
        end
        route_param :id do
          delete do
            Rider.find(params[:id]).delete
            { response: "Successfully deleted rider!"}
          rescue ActiveRecord::RecordNotFound
            error!('Rider not found',404)
          end
        end

      end

    end
  end
end
