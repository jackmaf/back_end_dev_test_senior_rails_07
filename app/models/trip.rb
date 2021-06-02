class Trip < ApplicationRecord
  belongs_to :rider
  belongs_to :driver
  has_many :payments
end
