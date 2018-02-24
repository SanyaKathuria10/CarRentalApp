class Car < ApplicationRecord
  has_many :reservations


  def self.getcurrentlyReservedCarsId
    Reservation.where("reservation_status in (\'Reserved\', \'Checked_out\')").map(& :car_id).uniq
  end
  #cars which are not checked out or reserved
  def self.get_currentlyAvailableCars
    cars = self.getcurrentlyReservedCarsId
    Car.where.not(["id in (?)",cars])
  end


  def self.get_availableCars from, to, optionalParams
    cars = Reservation.get_reservedcarsId(from,to);
    flag = optionalParams.empty?
    unless cars.all? &:nil?
      if flag
        Car.where.not(["id in (?)",cars]).where(optionalParams)
      else
        Car.where.not(["id in (?)",cars])
      end
    else
      if flag
        Car.all
      else
        Car.all.where(optionalParams)
      end
    end
  end
end
