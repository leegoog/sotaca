ActiveAdmin.register Category do
  index do
    column :id
    column :name 
    column :parent_id
    default_actions
  end
  
  filter :name
  filter :parent_id, :label => "Only child categories of"
  
end
