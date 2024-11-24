class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :room_image

  validates :room_name, presence: true
  validates :description, presence: true
  validates :price_per_night, numericality: { only_integer: true, greater_than_or_equal_to: 1, message: 'は1以上の整数で入力してください' }
  validates :address, presence: true

  after_commit :add_default_image, on: [:create, :update]

  def self.looks(search)
    if search[:address].present? && search[:keywords]
      where("address LIKE ? AND (room_name LIKE ? OR description LIKE ?)", "%#{search[:address]}%", "%#{search[:keywords]}%", "%#{search[:keywords]}%")
    elsif search[:address].present?
      where("address LIKE ?", "%#{search[:address]}%")
    elsif search[:keywords].present?
      where("room_name LIKE ? OR description LIKE ?", "%#{search[:keywords]}%", "%#{search[:keywords]}%")
    else
      all
    end
  end

  private

  def add_default_image
    unless room_image.attached?
      self.room_image.attach(
        io: File.open(Rails.root.join("app", "assets", "images", "default_room.png")),
        filename: 'default_room.png',
        content_type: "image/png"
      )
    end
  end
end
