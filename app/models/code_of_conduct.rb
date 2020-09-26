class CodeOfConduct < ApplicationRecord
  belongs_to :repository, optional: true
end
