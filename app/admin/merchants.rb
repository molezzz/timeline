# coding: utf-8 
ActiveAdmin.register Merchant do   
  #menu :label => I18n.t('active_admin.labels.merchant')
  status_options = Merchant::STATUS.keys.collect{|k| 
      [I18n.t("activerecord.attributes.merchant.status_options.#{k}"),Merchant::STATUS[k]]
  }
  
  filter :name
  filter :icode
  filter :category_id,:as => :select
  filter :status,:as => :select,
         :collection => status_options
  filter :created_at,:label => I18n.t('active_admin.labels.created_at')
  filter :updated_at,:label => I18n.t('active_admin.labels.updated_at')
  
  form(:html => { :multipart => true }) do |f|
    f.inputs do
      f.input :name,:required => true,:hint => I18n.t('activerecord.tips.merchant.name')
      f.input :category,:as => :select,:collection => Category.to_options
      f.input :status,:as => :radio,:collection => status_options
      f.input :description,:as => :text,:required => true,:hint => I18n.t('activerecord.tips.merchant.description')
      f.input :logo,:as => :file,
              :hint => f.object.logo.url.blank? ? '' : f.template.image_tag(f.object.logo.url(:thumb))      
    end
    f.buttons
  end
  
  index do |m|
    column :id,:sortable => :id
    column :logo,:sortable => false do |m|
      image_tag(m.logo.url(:mobile))
    end
    column :name do |m|
      link_to m.name,admin_merchant_path(m)
    end
    column :icode,:sortable => false
    column :category_id do |m|
      m.category.blank? ? '-' : m.category.name
    end
    column :status,:sortable => :status
    column :created_at
    column :updated_at
    default_actions    
  end
  
  controller do        
    def new
      super do |format|
        @merchant = Merchant.new(:status=>Merchant::STATUS[:default])
      end
    end
    
  end
end
