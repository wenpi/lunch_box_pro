class ShopAddress < ActiveRecord::Base
  belongs_to :shop
  belongs_to :zone
  belongs_to :region
  belongs_to :city
  belongs_to :district

  
  #---start geocoder
  geocoded_by :full_addr
  after_validation :geocode , :if => :full_addr_changed?
  #---end geocoder

  #---start def attr
  def dish_count
    ShopDish.where(:shop_id => shop_id).count
  end
  #---end def attr
  #---start tokeninput
  def self.tokens(query)
    shop_addresses = where("addr like ?", "%#{query}%")
    # if authors.empty?
    #   [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    # else
    #   authors
    # end
    shop_addresses
  end

  # def self.ids_from_tokens(tokens)
  #   #tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
  #   tokens.split(',')
  # end
  #---end tokeninput
end
