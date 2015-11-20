ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
    
    #PAPER TRAIL
    section "Recently updated content" do
      table_for PaperTrail::Version.order('id desc').limit(20) do # Use PaperTrail::Version if this throws an error
     #column ("Item") { |v| v.name }
     column "Item" do |v|
       if v.item != nil && v.item_type.underscore.humanize == "Program"
          link_to v.item.prog_title, [:admin, v.item]  
       elsif  v.item != nil &&  v.item_type.underscore.humanize == "Course"  
          link_to v.item.title, [:admin, v.item] 
       end
     end# Uncomment to display as link
     #column ("Type") { |v| v.item.trans_type }
     column ("Record") { |v| v.item_type.underscore.humanize }
     column ("Event") { |v| v.event }
     column ("Modified at") { |v| v.created_at.to_s :long }
        column ("Admin") { |v| link_to User.find(v.whodunnit).email, [:admin, User.find(v.whodunnit)] }
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
