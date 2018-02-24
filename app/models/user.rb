class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # attr_reader :password
  # validates_presence_of :name, :email, :password
  # validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  # validates_confirmation_of :password
  validates_format_of :contact, :with => /\A[0-9]{10}\Z/i
  validates_format_of :name, :with => /\A[a-zA-Z0-9_]+\Z/i

  has_many :reservations

  def self.get_currentlyReservedUsersId id
    userID = Reservation.get_currentlyReservedUsers.map(& :id)
    return userID.include? id.to_i
  end
end
