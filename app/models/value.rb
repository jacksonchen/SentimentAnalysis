class Value < ActiveRecord::Base
  validates :word, :value, presence: true
end
