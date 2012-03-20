# coding: utf-8
require 'carrierwave/orm/activerecord'
 
class Merchant < ActiveRecord::Base
  STATUS = {
    :normal => 'normal',
    :locked => 'locked',
    :invalid => 'invalid'
  }
  STATUS.default='locked'
  
  belongs_to :category
  
  mount_uploader :logo,MerchantLogoUploader
  after_create :generate_icode
  
  protected
  #生成商家唯一识别码
  def generate_icode
    
  end
  
end
