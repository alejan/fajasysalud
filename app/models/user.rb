class User < ApplicationRecord
belongs_to :employee
has_many :tasks, dependent: :destroy
has_many :roles, through: :tasks
has_secure_password
end
