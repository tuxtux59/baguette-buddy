class Unit < ApplicationRecord

  validates :name, presence: true
  validates :plural, presence: true
  validates :abbreviation, presence: true

  validate :name_plural_not_the_same

  def name_plural_not_the_same
    if self.name == self.plural
      errors.add(:plural, "can't be the same as name")
    end
  end

end
