class Cat < ActiveRecord::Base
  validates :birth_date, :name, :user, presence: true
  validates :age, presence: true, numericality: true
  colors = %w(white black orange brown yellow calico)
  validates :color, presence: true, inclusion: { in: colors }
  validates :sex, presence: true, inclusion: { in: %w(M F) }
  has_many(
    :rentals,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id
  )

  belongs_to :user
end
