class Repository < ApplicationRecord
  has_many :code_of_conducts
  belongs_to :repository_set
end
