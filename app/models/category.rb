# encoding: utf-8
class Category < ActiveRecord::Base
  has_many :merchants
  has_many :children,:foreign_key=>"parent_id", :class_name=>'Category',:dependent => :delete_all
  belongs_to :parent,:class_name => 'Category'
  
  validates_presence_of :name
  validate :child_can_not_has_child
  
  #生成select标签使用的数组
  #options children <boolean>  是否包含子分类
  def self.to_options(children=true)
    #TODO cache
    options = []
    root = self.where('parent_id < 1').order('id ASC').all
    root.each do |parent|
      options << ["#{parent.name}",parent.id]      
      parent.children.each do |child|
        options << ["├ #{child.name}",child.id]
      end if children      
    end
    options
  end
  
  protected
  #只允许二级分类
  def child_can_not_has_child
    errors.add(:parent_id,I18n.t('activerecord.errors.category.child_can_not_has_child')) if self.parent_id > 0
  end
end
