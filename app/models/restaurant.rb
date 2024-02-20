class Restaurant < ApplicationRecord
  def vote(split_check)
    if split_check
      increment!(:will_split)
    else
      increment!(:wont_split)
    end
  end
end
