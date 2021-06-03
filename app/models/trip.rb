class Trip < ApplicationRecord
  belongs_to :rider
  belongs_to :driver
  has_many :payments

  after_commit :check_fee, on: [:create, :update]

  # Geocoder
  reverse_geocoded_by :lat_ini, :lng_ini

  # Autor: Jackson Florez Jimenez
  #
  # Fecha creacion: 2021-06-03
  #
  # Autor actualizacion:
  #
  # Fecha actualizacion: 0000-00-00
  #
  # Metodo: encargado de generar el los pagos a un viaje
  def check_fee
    # Metodo: encargado de revisar si ya se puede revisar las tarifas
    if trip_completed? && self.distance_km.blank? && self.base_fee.blank? && self.total_fee.blank?
      distance_km = self.distance_to([self.lat_end, self.lng_end], :km).round
      base_fee = 3500
      total_fee = ((distance_km*1000)+(200*self.minutes.to_i)+base_fee)
      self.update!(distance_km: distance_km, base_fee: base_fee, total_fee: total_fee)
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
  # Metodo: encargado de revisar si ya se puede revisar las tarifas
  def trip_completed?
    val = 0
    val += self.lat_ini.blank? ? 1 : 0
    val += self.lng_ini.blank? ? 1 : 0
    val += self.lat_end.blank? ? 1 : 0
    val += self.lng_end.blank? ? 1 : 0
    val += self.minutes.blank? ? 1 : 0
    val == 0
  end
end
