class Restaurant < ApplicationRecord

  has_many :votes
  has_many :comments
  has_many :favorites

  before_validation :set_defaults, on: :create

  validates :name, :location, :will_split, :wont_split, presence: true
  validates :name, uniqueness: { scope: :location, message: "has already been taken at this location." }

  def set_defaults
    self.will_split = 0 if will_split.blank?
    self.wont_split = 0 if wont_split.blank?
  end

  def vote(split_check)
    if split_check
      increment!(:will_split)
    else
      increment!(:wont_split)
    end
  end

  def self.search(search)
    if search
      @restaurants = Restaurant.where("name LIKE :search OR location LIKE :search", search: "%#{search}%")
    else
      @restaurants = Restaurant.all
    end
  end

end
