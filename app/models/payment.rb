class Payment < ApplicationRecord
  belongs_to :trip

  # CONFIG ENVIRONMENT VARS HEROKU
  # https://es.stackoverflow.com/questions/200261/como-configurar-variable-de-entorno-en-heroku
  BASE_URL_WOMPI = ENV['BASE_URL_WOMPI']
  PUBLIC_KEY_WOMPI = ENV['PUBLIC_KEY_WOMPI']
  PRIVATE_KEY_WOMPI = ENV['PRIVATE_KEY_WOMPI']

  after_commit :pay_wompi, on: [:create, :update]

  # Autor: Jackson Florez Jimenez
  #
  # Fecha creacion: 2021-06-03
  #
  # Autor actualizacion:
  #
  # Fecha actualizacion: 0000-00-00
  #
  # Metodo: encargado de hacer el pago a la pasarela de pagos wompi
  def pay_wompi
    # se revisa si el viaje tiene ya un valor y tiene un viaje asignado y el id wompi status esten vacios no se halla ya enviado a wompi
    if !self.trip.total_fee.blank? && !self.trip.nil? && self.id_wompi.blank? && self.status.blank?
      # Metodo: encargado de generar una transaccion en wompi usando el valor en pesos referencia email y telefono
      transactions_nequi_wompi(self.trip.total_fee, self.trip.id.to_s, self.trip.rider.email, self.trip.rider.phone_number)
    end
  end

  # Autor: Jackson Florez Jimenez
  #
  # Fecha creacion: 2021-06-01
  #
  # Autor actualizacion:
  #
  # Fecha actualizacion: 0000-00-00
  #
  # Metodo: encargado de generar una transaccion en wompi usando el valor en pesos referencia email y telefono
  # Payment.transactions_nequi_wompi(25000, "5", "jackmaf0@gmail.com", "3016469891")
  def transactions_nequi_wompi(pesos, reference, customer_email, phone_number)
    data = {
      # Metodo: encargado de generar el token de aceptacion de abeas data necesario para trabajar con Wompi
      acceptance_token: accept_token_wompi,
      amount_in_cents: pesos.to_i*100,# se agregan 2 ceros para los los centavos
      currency: "COP",
      customer_email: customer_email,
      reference: reference,
      payment_method: {
        type: "NEQUI",
        phone_number: phone_number
      }
    }

    require 'uri'
	  require 'net/http'
    
    uri = URI.parse(BASE_URL_WOMPI+'transactions')
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri, initheader = {'Content-Type' =>'application/json'})

    request['Accept'] = 'application/json'
    request['Accept-language'] = 'en'
    request['authorization']   = PRIVATE_KEY_WOMPI

    request.body = data.to_json
    request = https.request(request)

    response = JSON.parse(request.body)
    add_amount = response["data"]["amount_in_cents"].to_i/100
    self.update!(id_wompi: response["data"]["id"], amount: add_amount, status: response["data"]["status"])
    # update amount driver
    current_amount = self.trip.driver.amount.to_i
    self.trip.driver.update(amount: (add_amount+current_amount))

    response
  end

  # Autor: Jackson Florez Jimenez
  #
  # Fecha creacion: 2021-06-01
  #
  # Autor actualizacion:
  #
  # Fecha actualizacion: 0000-00-00
  #
  # Metodo: encargado de generar el token de aceptacion de abeas data necesario para trabajar con Wompi
  # https://docs.wompi.co/docs/en/tokens-de-aceptacion
  # https://sandbox.wompi.co/v1/merchants/pub_test_jwJdxSIDNMPwvlCL1mgDSGYTvwhLhzyz
  def accept_token_wompi
    require 'uri'
	  require 'net/http'
    
    url = URI(BASE_URL_WOMPI+'merchants/'+PUBLIC_KEY_WOMPI)

	  http = Net::HTTP.new(url.host, url.port)
	  http.use_ssl = true
	  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

	  request = Net::HTTP::Get.new(url)

    response = http.request(request)

    token = JSON.parse(response.read_body)
    token["data"]["presigned_acceptance"]["acceptance_token"]
  end

end
