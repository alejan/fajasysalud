class Company < ApplicationRecord
has_many :employees, dependent: :destroy
has_many :roles,  dependent: :destroy

end
