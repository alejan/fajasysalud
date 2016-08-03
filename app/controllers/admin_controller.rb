class AdminController < ApplicationController
before_action :load_roles
skip_before_action :verify_authenticity_token
helper_method :user_helper, :paginacion
  def index
    
  end

  def new_company
    if Company.first
   @company = Company.first 
    else
   @company =Company.new
   end
  end

  def create_company
    @company = Company.new(com_params)

         if @company.save
          redirect_to admin_url
        else
        render 'admin'
        end
  end
  def update_company

       @company=Company.first
    if @company.update(com_params)
      redirect_to admin_path
    else
      render 'admin'
    end

  end
  def list_employee
     com=Company.first
   
      show=params['show'].to_i==0? 2 :  params['show'].to_i
      cont= show==0? 0 :  params['pages'].to_i 
  
   
    if params['order']!='user'
      if params['desc']
       
    @employees=Employee.order(params['order']=>"desc").limit(show).offset(show*cont)
    
    else
    if params['order'].nil?
     @employees=com.employees.order('created_at DESC').limit(show).offset(show*cont) 
    else
     @employees=Employee.order(params['order']).limit(show).offset(show*cont)
    end
    end
    
    end
  
   
end
  def new_employee

  com = Company.first
  @employee =com.employees.new
  end

def create_employee

 @employee = Employee.new(emp_params)
  respond_to do |format|
    if @employee.save
      format.html {redirect_to employees_list_path, notice:"thank you"}
    else
      format.html {render 'employees/list'}
    end
  end
end
def show_employee
  params_id=params[:id]
  @employee=Employee.find(params_id)

end
def edit_employee

@employee=Employee.find(empid_params['id'])
if @employee.update(emp_params)
  redirect_to employees_list_path
else
 render 'employees/list'
end
end
def destroy_employees
   
   if params[:id]
   prm=params[:id]  
     if prm.length==1
       ep=Employee.find(prm[0])
       redirect_to employees_list_path if ep.destroy
       
     else if prm.length >1
    
   count = 0 
    while count <= prm.length-1 do 
       pmr=Employee.find(prm[count])
       count+=1 
       pmr.destroy 
   redirect_to employees_list_path   if   count == prm.length-1
     end
    end
    end
    else
      redirect_to employees_list_path 
    end
    
    
   
end

def new_user
  
if params['uid']=="crear"
@user=User.new
@user.employee_id=params['eid']
else
  @user=User.find_by(username:params['uid'])
end
end

def create_user
user=User.new(user_params)
if user.save
  redirect_to employees_list_path
else
  render 'employees/list'
end
end
def update_user
  user = User.find(user_id['id'])
  if user.update(user_params)
    redirect_to employees_list_path
  else
    render 'employees/list'
  end
end
def destroy_user
  
 @user = User.find(user_id['id'])
 if @user.destroy
    redirect_to employees_list_path
  else
    render 'employees/list'
  end
end
def roles_list
  @roles=Role.all
  pmr=params['id']
  @user=User.find(pmr)
 
    
  
end

def add_roles
   
  user=User.find(params['id'])
   
   
  if params['compras']=='1'
    role= Role.find_by(name:"compras")
    
    user.roles<< role  if !user.roles.include?(role)
  else 
      role= Role.find_by(name:"compras") 
  user.roles.destroy(role.id) if user.roles.include?(role)
  end
  
  
  if params['ventas']=='1'
    role= Role.find_by(name:"ventas")
    user.roles<< role if !user.roles.include?(role)
  else
   role= Role.find_by(name:"ventas")
   user.roles.destroy(role.id) if user.roles.include?(role)
  end
  if params['admin']=='1'
    role=Role.find_by(name:"admin")
    user.roles<< role if !user.roles.include?(role)
    else
        role=Role.find_by(name:"admin")
        user.roles.destroy(role.id) if user.roles.include?(role)
  end
  if params['personal']=='1'
    
  role=Role.find_by(name:"personal")
    user.roles<< role if !user.roles.include?(role) 
    else
     role=Role.find_by(name:"personal")
       user.roles.destroy(role.id)  if user.roles.include?(role) 
  end
  if params['contabilidad']=='1'
    role=Role.find_by(name:"contabilidad")
    user.roles<< role if !user.roles.include?(role)   
  else
     role=Role.find_by(name:"contabilidad")
      user.roles.destroy(role.id) if user.roles.include?(role)
  end
  user.save
  redirect_to employees_list_path
  
end

def user_helper(role,user)
  usr =User.find(user.id)
   if usr.roles.include?(Role.find_by(name:role))
    return true
    else
      return false
  end
end
  private
def load_roles
  if Role.all.size<1
  com = Company.first
  rol=["compras","ventas","admin","personal","contabilidad"]
  rol.each { |e| com.roles.create(name:e)  }
end
end
def paginacion(show)
   
 
 num=Employee.count/show.to_f
 num=num.ceil
 
count=0;
pag=''
ant= num>2? '<li ><a onclick="goAnt(this)" href="">anterior</a></li>' : ''
sig= num>2? "<li ><a id=sig onclick='goSig(this)' data-value=#{num} href="">siguiente</a></li>" :''
 while count<num do 
   pag+="<li><a onclick='rLoad()' href=?show=#{show}&pages=#{count}>#{count+1}</a></li>"
   count+=1
 end
 "<ul class='pagination' style='position:absolute; left:35%'>#{ant+pag+sig}</ul>".html_safe
end
 


  def com_params
    params.require(:company).permit(:name,:nit,:website,:email,:phone,:address)

end

def emp_params
   params.require(:employee).permit(:name,:last,:phone,:address,:email,:company_id)
end
def empid_params
  params.require(:employee).permit(:id)
end
def user_params
  params.require(:user).permit(:username,:password,:password_confirmation,:employee_id)
end
def user_id
  params.require(:user).permit(:id)

end
end
