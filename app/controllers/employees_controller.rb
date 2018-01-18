class EmployeesController < ApplicationController

  before_action :employee_logged_in, only: [:edit,
                                            :update,
                                            :home]

  def home
  end
  
  def edit 
    @employee = current_employee
    if params["fb"]
      config = request.env['omniauth.auth']['credentials']
      @graph = Koala::Facebook::API.new(config['token'])
      user = @graph.get_object('me?fields=picture,name,email,birthday')
      if user['email'] || user['birthday'] 
        @employee.update_attributes(personalemail: user['email'],
                                    dateofbirth: date_converter(user['birthday']))
        flash[:success] = "Successfully Updated the Profile with facebook details!"
        redirect_to home_path
      else
        redirect_to edit_employee_path(@employee), notice:"Updation failed"
      end
    else
      render "edit"
    end
  end
  
  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(employee_params)
      # Handle a successful update.
      flash[:success] = "Profile Updated successfully!"
      redirect_to home_path
    else
      flash.now[:error] = "updation failed!"
      redirect_to edit_employee_path(@employee)
    end
  end 

  def destroy
    Employee.find(params[:id]).destroy
    flash[:success] = "Employee deleted"
    redirect_to adminemployee_path
  end

  def login
    @employee = Employee.koala(request.env['omniauth.auth']['credentials'])
  end


  private

  def employee_params
    params.require(:employee).permit(:dateofbirth,:personalemail,:image)
  end
  
end
