class PaymentNewValidate < Dry::Validation::Contract
  # Autor: Jackson Florez Jimenez
  #
  # Fecha creacion: 2021-06-03
  #
  # Autor actualizacion:
  #
  # Fecha actualizacion: 0000-00-00
  #
  # parametros de entrada
  #
  params do
    required(:trip_id).value(:integer)
  end

  # Autor: Jackson Florez Jimenez
  #
  # Fecha creacion: 2021-06-03
  #
  # Autor actualizacion:
  #
  # Fecha actualizacion: 0000-00-00
  #
  # Reglas trip id
  rule(:trip_id) do
    key.failure('Trip no exist') if Trip.where(id: value).count == 0
  end
end
