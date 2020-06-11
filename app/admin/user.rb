ActiveAdmin.register User do

  filter :id
  filter :username
  filter :email
  filter :blocked
  filter :admin

  form do |f|
    f.inputs "User Details" do
    f.input :username
    f.input :email
    f.input :password
    f.input :password_confirmation
    f.input :admin, :label => "Administrator"
    f.input :blocked, :label => "Blocked"
  end
  f.actions
  end

 index :title => "Пользователи" do
    selectable_column
    column :id
    column :username
    column :email
    column :blocked
    column :admin
    column :created_at
    column :updated_at
    column do |user|
      links = []
      links << link_to("Открыть",  admin_user_path(user.id) , action: "show", id: user.id)
      links << link_to("Изменить",  edit_admin_user_path(user.id), action: "edit", id: user.id)
      links << link_to("Удалить", admin_user_path(user.id), method: :delete)
      links.join(' ').html_safe
    end
  end


  create_or_edit = Proc.new {
    @user = User.where(id: params[:id]).first_or_create
    @user.admin = permitted_params[:user][:admin]
    @user.attributes = permitted_params[:user].delete_if do |key, value|
      (key == "admin") ||
      (["password", "password_confirmation"].include?(key) &&
        value.empty? && !@user.new_record?)
    end

    if @user.save
      redirect_to :action => :show, :id => @user.id
    else
      render active_admin_template((@user.new_record? ? 'new' : 'edit') + '.html.erb')
    end
  }

  member_action :create, :method => :post, &create_or_edit
  member_action :update, :method => :put, &create_or_edit

  permit_params :username, :email, :password, :password_confirmation, :admin, :blocked
end
