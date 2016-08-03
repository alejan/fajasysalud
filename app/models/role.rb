class Role < ApplicationRecord
belongs_to :company
has_many :tasks, dependent: :destroy
has_many :users , through: :tasks
end
