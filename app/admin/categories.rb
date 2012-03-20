ActiveAdmin.register Category,{:sort_order => 'parent_id_asc'} do
  
  form do |f|
    f.inputs do
      f.input :parent_id,:as => :select,:collection => Category.to_options(false),
              :hint => I18n.t('activerecord.tips.category.parent_id_on_edit')
      f.input :name,:required => true,:hint => I18n.t('activerecord.tips.category.name')
      f.input :remark,:as => :text
    end
    f.buttons
  end
  
  index do |r|
    column :id,:sortable => :id
    column :name do |c|
      c.parent_id < 1 ? "+ #{c.name}" : "- #{c.name}"
    end
    column :remark,:sortable => false
    column :created_at
    column do |c|
      links = link_to I18n.t('active_admin.view'),admin_category_path(c),
                      :class => "member_link view_link"
      links += link_to I18n.t('active_admin.edit'),edit_admin_category_path(c),
                       :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), admin_category_path(c),
                       :method => :delete, 
                       :confirm => I18n.t('active_admin.delete_confirmation'), 
                       :class => "member_link delete_link" 
      #非子类显示添加子类按钮
      links += link_to I18n.t('active_admin.labels.add_new_child_category'),new_admin_category_path(:parent_id => c.id),
                       :class => "member_link" if c.parent_id < 1                       
      links     
    end
  end
  
  controller do        
    def new
      super do |format|
        @category = Category.new(:parent_id => params[:parent_id].to_s)
      end
    end    
  end
  
end
