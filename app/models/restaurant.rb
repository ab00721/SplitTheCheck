class Restaurant < ApplicationRecord

  before_validation :set_defaults, on: :create
  validates :name, :location, :will_split, :wont_split, presence: true

  def vote(split_check)
    if split_check
      increment!(:will_split)
    else
      increment!(:wont_split)
    end
  end

  def set_defaults
    self.will_split ||= 0
    self.wont_split ||= 0
  end
  
end
