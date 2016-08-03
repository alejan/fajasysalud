class Employee < ApplicationRecord
belongs_to :company
has_one :user, dependent: :destroy

end
