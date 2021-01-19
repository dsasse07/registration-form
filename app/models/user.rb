class User < ApplicationRecord
  has_many :addresses
  belongs_to :team

# We cannot call this custom writer addresses= because that would
# Overwrite an AR method. The original AR method assumes you would
# be taking in an array of address objects, not hash data.

# We call this new method address_attributes instead
  
  # def addresses=(array_of_addresses)
  # end

  def addresses_attributes=(addresses_attributes)
    addresses_attributes.each do |i, attribute_hash|
      byebug
      self.addresses.build(attribute_hash) unless attribute_hash[:street_1].blank?
    end
  end
  # "addresses_attributes"=>
  # {"0"=>{"street_1"=>"137 21st st", "street_2"=>"", "city"=>"NEW", "state"=>"ny", "zip_code"=>"98932", "address_type"=>"Home"},
  #  "1"=>{"street_1"=>"", "street_2"=>"", "city"=>"", "state"=>"", "zip_code"=>"", "address_type"=>"Work"}},




    # Finds team by name, if it does not find one, it will create one using the
    # Attributes in the code block
  def team_attributes=(team_attributes)
    self.team = Team.find_or_create_by(name: team_attributes[:name]) do |team|
      team.hometown = team_attributes[:hometown]
    end
  end

end
