class CodeOfConduct < ApplicationRecord
  belongs_to :repository
  belongs_to :code_of_conduct_type
end
