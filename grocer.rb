require 'pry'

def consolidate_cart(cart)
  cart_return = {}
  cart.each do |item|
    item.each do |item_name, item_details|
      if item_name != cart_return.keys.join()
        cart_return[item_name] = {:price=>item_details[:price], :clearance=>item_details[:clearance], :count=>1}
      elsif item_name == cart_return.keys.join()
        cart_return[item_name][:count] += 1
      end
    end
  end
  return cart_return
end


def apply_coupons(cart, coupons)
  # binding.pry
  # cart_return = {}
  # cart.each do |item, item_details|
  #   if item == coupons[0][:item]
  #     # cart_return
  #     cart_return[item + " W/COUPON"] = {price: coupons[0][:cost], :clearance=>item_details[:clearance], :count=>item_details[:count] - coupons[0][:num] + 1}
  #       # :clearance=>[item_details][:clearance], :count=>[item_details][:count] - coupons[0][:num]}
  #   end
  # end
  # return cart_return
  # coupons.each do |coupon|
  #   item_name = coupon[:item]
  #   if cart[item_name] && cart[item_name][:count] >= coupon[:num]
  #     if cart["#{item_name} W/COUPON"]
  #       cart["#{item_name} W/COUPON"][:count] += 1
  #     else
  #       cart["#{item_name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
  #       cart["#{item_name} W/COUPON"][:clearance] = cart[item_name][:clearance]
  #     end
  #     cart[item_name][:count] -= coupon[:num]
  #   end
  # end
  # cart
  coupons.each do |coupon|
   name = coupon[:item]
   if cart[name] && cart[name][:count] >= coupon[:num]
     if cart["#{name} W/COUPON"]
       cart["#{name} W/COUPON"][:count] += 1
     else
       cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
       cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
     end
     cart[name][:count] -= coupon[:num]
   end
 end
 cart
end


def apply_clearance(cart)
  # code here
  cart.each do |item, properties|
    if properties[:clearance]
      new_price = properties[:price] * 0.8
      properties[:price] = new_price.round(2)
    end
  end
  cart
end


def checkout(cart, coupons)
  # code here
  consol_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consol_cart, coupons)
  total_cart = apply_clearance(coupon_cart)
  the_total = 0
  total_cart.each do |item_name, item_properties|
    the_total += item_properties[:price] * item_properties[:count]
  end
  the_total = the_total * 0.9 if the_total > 100
  the_total
end
