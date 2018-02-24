class Reservation < ApplicationRecord
  belongs_to :car, optional: true
  belongs_to :user, optional: true


  scope :by_status , lambda {|status|where :reservation_status => status}
  # scope :by_user, lambda{where :user_id => session[:id]}
  #b= Time.now + 10.hours
  #scope :reserved_cars , lambda{where "checkout_time < ? and return_time < ?",Time.now.to_datetime, b.to_datetime}
  #scope :reserved_cars , lambda{|checkin,checkout|where "checkout_time < ? and return_time < ?",checkin,checkout}#DateTime.parse(checkout), DateTime.parse(checkin)}
  def self.get_reservedcars from,to
  #Reservation.where(["reservation_status in (\"Reserved\", \"Checked_out\") and ((checkout_time <= ? and return_time >= ?) or ( checkout_time >= ? and return_time <= ?) or (checkout_time <= ? and return_time <= ?))", from,to,from,to,from,to])
  #.map(&:car).uniq
    Reservation.where.not(["return_time <= ? or checkout_time >= ?",from.to_datetime,to.to_datetime]).where("reservation_status in (\'Reserved\', \'Checked_out\')").map(& :car)
  end

  def self.get_reservedcarsId from,to
    Reservation.where.not(["return_time <= ? or checkout_time >= ?",from.to_datetime,to.to_datetime]).where("reservation_status in (\'Reserved\', \'Checked_out\')").map(& :car_id)
  end

  def self.get_userhistory user
    Reservation.where(:user_id => user)
  end

  def self.get_currentlyReservedCars
    Reservation.where("reservation_status in (\'Reserved\', \'Checked_out\')").map(& :car);
  end

  def self.get_currentlyReservedUsers
    Reservation.where("reservation_status in (\'Reserved\', \'Checked_out\')").map(& :user);
  end

  def self.get_currentReservationForUser id
    Reservation.where("reservation_status in (\'Reserved\', \'Checked_out\')").where(:user_id => id)
  end
  def check_out
    update_attributes(:reservation_status =>'Checked_out', :checkout_time => (DateTime.now - 4.hours))
  end

  def return
    c = car
    time = Time.now.to_datetime - 4.hours
    duration = ((time - checkout_time.to_datetime)*24*60*60).to_f/1.hours
    bill = c.hourly_rate.to_f * duration.to_f
    update_attributes(:reservation_status => 'Completed', :total_bill => bill.round(2), :return_time => time)
  end

  def cancel
    update_attribute(:reservation_status,'Cancelled')
  end



end
