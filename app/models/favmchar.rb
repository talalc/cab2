class Favmchar < ActiveRecord::Base
  belongs_to :user
  belongs_to :mchar
end
