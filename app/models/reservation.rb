class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, :people, presence: true
  validates :people, numericality: { greater_than_or_equal_to: 1 }
  validate :start_date_cannot_be_in_the_past
  validate :end_date_after_start_date

  before_save :set_sum_price

  def calculate_sum_price
    number_of_nights = (end_date - start_date).to_i
    room.price_per_night * number_of_nights * people
  end

  private

  def set_sum_price
    self.sum_price = calculate_sum_price
  end

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "は今日以降の日付である必要があります")
    end
  end

  def end_date_after_start_date
    if end_date.present? && start_date.present? && end_date < start_date
      errors.add(:end_date, "はチェックイン日以降の日付である必要があります")
    end
  end
end
