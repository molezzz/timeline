# coding: utf-8 
class Merchant < ActiveRecord::Base
  STATUS = {
    :normal => 'normal',
    :locked => 'locked',
    :invalid => 'invalid'
  }
  STATUS.default='locked'
  
  
end
