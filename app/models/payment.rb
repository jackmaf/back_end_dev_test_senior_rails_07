class Payment < ApplicationRecord
  belongs_to :trip

  # CONFIG ENVIRONMENT VARS HEROKU
  # https://es.stackoverflow.com/questions/200261/como-configurar-variable-de-entorno-en-heroku
  BASE_URL_WOMPI = ENV['BASE_URL_WOMPI']
  PUBLIC_KEY_WOMPI = ENV['PUBLIC_KEY_WOMPI']
  PRIVATE_KEY_WOMPI = ENV['PRIVATE_KEY_WOMPI']

  # Autor: Jackson Florez Jimenez
  #
  # Fecha creacion: 2021-06-01
  #
  # Autor actualizacion:
  #
  # Fecha actualizacion: 0000-00-00
  #
  # Metodo: encargado de generar una transaccion en wompi usando el valor en pesos referencia email y telefono
  def self.transactions_nequi_wompi(pesos, reference, customer_email, phone_number)
    data = {
      # Metodo: encargado de generar el token de aceptacion de abeas data necesario para trabajar con Wompi
      acceptance_token: Payment.accept_token_wompi,
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

    JSON.parse(request.body)
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
  # Payment.transactions_nequi_wompi(15000, "4", "jackmaf0@gmail.com", "3016469891")
  def self.accept_token_wompi
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
