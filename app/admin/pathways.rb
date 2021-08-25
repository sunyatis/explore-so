ActiveAdmin.register Pathway do
  menu parent: 'Manage Programs', label: 'Pathways'

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :headline, :description, :learn_your_way_text, :best_fit_link_1, :best_fit_link_2, :best_fit_link_3, :meta_description, :meta_keywords, :page_title, :landing_page
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :headline, :description, :learn_your_way_text, :best_fit_link_1, :best_fit_link_2, :best_fit_link_3, :meta_description, :meta_keywords, :page_title]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  index do
      id_column
      column :title
      column :page_title
    end
  
  
  form do |f|
  f.inputs "Pathway Page Details" do
    tabs do
      
      tab 'Pathway Page Content', {class: 'ui-tabs-active'} do
        f.li "<li><div class='aa_label'><h3>Which pathway landing page is this for??</h3</div></li>".html_safe 
        f.input :landing_page, :as => :select, :collection => ["accounting","business","computerscience_it","data_science","education", "engineering","general_studies","graduate_degrees","healthcare", "psychology", "security_studies", "index"]
        
        f.li "<li><div class='aa_label'><h3>What is the name of the pathway?</h3</div></li>".html_safe  
     f.input :title
     f.hr
      f.li "<li><div class='aa_label'><h3>What should the headline say?</h3</div></li>".html_safe 
      f.input :headline, as: :froala_editor
      f.hr
     f.li "<li><div class='aa_label'><h3>What is the pathway description?</h3</div></li>".html_safe
    f.input :description, as: :froala_editor
    f.hr
   f.li "<li><div class='aa_label'><h3>What should the Learn Your Way text say?</h3</div></li>".html_safe
  f.input :learn_your_way_text, as: :froala_editor
  
    
    
      end
      tab 'Links', {class: 'ui-tabs-active'} do
        f.li "<li><div class='aa_label'><h3>What is the best fit link #1?</h3</div></li>".html_safe  
     f.input :best_fit_link_1
     f.hr
     f.li "<li><div class='aa_label'><h3>What is the best fit link #2?</h3</div></li>".html_safe  
     f.input :best_fit_link_2
  f.hr
   f.li "<li><div class='aa_label'><h3>What is the best fit link #3?</h3</div></li>".html_safe  
   f.input :best_fit_link_3
f.hr
       
      end
      
      tab 'Page Metadata', {class: 'ui-tabs-active'} do
        f.li "<li><div class='aa_label'><h3>What is the page meta_description?</h3</div></li>".html_safe  
     f.input :meta_description
     f.hr
     f.li "<li><div class='aa_label'><h3>What is the page meta_keywords?</h3</div></li>".html_safe  
     f.input :meta_keywords
  f.hr
   f.li "<li><div class='aa_label'><h3>What is the page title?</h3</div></li>".html_safe  
   f.input :page_title
f.hr
      end

  end    
  f.actions
    end
  

  
end

end