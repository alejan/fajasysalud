Rails.application.routes.draw do
root 'session#new'
  controller :admin do
    get 'admin' => :index
    get 'companies' => :new_company, :as => :company
    post 'companies' => :create_company
    match 'companies' =>:update_company, via: [:put,:patch]
    get   'employees/list' =>:list_employee
    delete 'employees/list'=>:destroy_employees
      get  'employees/edit' =>:show_employee, :as => :employee
    match 'employees/edit' =>:edit_employee, via: [:put,:patch]
    get   'employees' => :new_employee
    post  'employees' => :create_employee
    get   'users'  => :new_user
    post  'users' => :create_user
    match 'users' => :update_user, via: [:put,:patch], :as => :user
    delete 'users' =>:destroy_user
    get   'roles' => :roles_list
    post  'roles' => :add_roles
   

  end

  controller :session do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
