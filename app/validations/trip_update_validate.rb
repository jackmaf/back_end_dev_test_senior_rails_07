class TripUpdateValidate < Dry::Validation::Contract
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
    required(:minutes).value(:integer)
    required(:lat_end).filled(:string)
    required(:lng_end).filled(:string)
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
  rule(:lat_end) do
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
  rule(:lng_end) do
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
  # Reglas driver id
  rule(:minutes) do
    key.failure('Minutes can not zero') if value == 0
  end
end
