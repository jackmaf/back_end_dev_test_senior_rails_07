class TripNewValidate < Dry::Validation::Contract
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
    required(:rider_id).value(:integer)
    required(:driver_id).value(:integer)
    required(:lat_ini).filled(:string)
    required(:lng_ini).filled(:string)
  end

  # Autor: Jackson Florez Jimenez
  #
  # Fecha creacion: 2021-06-03
  #
  # Autor actualizacion:
  #
  # Fecha actualizacion: 0000-00-00
  #
  # Reglas para la latitud
  rule(:lat_ini) do
    unless /^(\+|-)?(?:90(?:(?:\.0{1,6})?)|(?:[0-9]|[1-8][0-9])(?:(?:\.[0-9]{1,6})?))$/i.match?(value)
      key.failure('Latitude invalid format')
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
  # Reglas para la latitud
  rule(:lng_ini) do
    unless /^(\+|-)?(?:180(?:(?:\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\.[0-9]{1,6})?))$/i.match?(value)
      key.failure('Longitude invalid format')
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
  # Reglas rider id
  rule(:rider_id) do
    key.failure('Rider no exist') if Rider.where(id: value).count == 0
  end

  # Autor: Jackson Florez Jimenez
  #
  # Fecha creacion: 2021-06-03
  #
  # Autor actualizacion:
  #
  # Fecha actualizacion: 0000-00-00
  #
  # Reglas driver id
  rule(:driver_id) do
    key.failure('Driver no exist') if Driver.where(id: value).count == 0
  end
end
