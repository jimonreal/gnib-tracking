# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#  locale     :string(255)      default("pt-BR")
#

class User < ApplicationRecord
	validates_presence_of :email, :name
	validates :eula, acceptance: true
  validates :email, email: {domain: true, mx: true}

  has_many :trackings
end
