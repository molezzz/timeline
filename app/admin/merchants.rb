# coding: utf-8 
ActiveAdmin.register Merchant do
  #menu :label => I18n.t('active_admin.labels.merchant')
  status_options = Merchant::STATUS.keys.collect{|k| 
      [I18n.t("activerecord.attributes.merchant.status_options.#{k}"),Merchant::STATUS[k]]
  }
  
  filter :name
  filter :icode
  filter :status,:as => :select,
         :collection => status_options
  filter :created_at,:label => I18n.t('active_admin.labels.created_at')
  filter :updated_at,:label => I18n.t('active_admin.labels.updated_at')
  
  form do |f|
    f.inputs do
      f.input :name,:required => true,:hint => I18n.t('activerecord.tips.merchant.name')
      f.input :status,:as => :radio,:collection => status_options
      f.input :description,:as => :text,:required => true,:hint => I18n.t('activerecord.tips.merchant.description')
      f.input :logo,:as => :file      
    end
    f.buttons
  end
  
  controller do    
    def new
      super do |format|
        @merchant = Merchant.new(:status=>Merchant::STATUS[:default])
      end
    end
    
  end
end
