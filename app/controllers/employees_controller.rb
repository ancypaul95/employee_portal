class EmployeesController < ApplicationController
  def index
    @employee=Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end 
  
  def new
    @employee=Employee.new
  end

  def create
    @employee = Employee.new(employee_signup_params)
    if @employee.save
      # Handle a successful save.
      log_in @employee
      flash[:success] = "New employee is added!"
      #redirect_to login_path 
      redirect_to adminemployee_path
    else
      render 'new'
    end
  end
  
  def edit
     @employee = current_employee
    #@employee = Employee.find_by(params[:id])
  end
  
  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(employee_params)
    # if ((params[:employee][:designation]).blank? ? true : @employee.update_attribute(:designation, params[:employee][:designation]) ) && ((params[:employee][:email]).blank? ? true : @employee.update_attribute(:email, params[:employee][:email])) && ((params[:employee][:dateofjoin]).blank? ? true : @employee.update_attribute(:dateofjoin, params[:employee][:dateofjoin])) && ((params[:employee][:dateofbirth]).blank? ? true : @employee.update_attribute(:dateofbirth, params[:employee][:dateofbirth])) && ((params[:employee][:personalemail]).blank? ? true : @employee.update_attribute(:personalemail, params[:employee][:personalemail])) 
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
    flash[:success] = "User deleted"
    redirect_to adminemployee_path
  end

  private

  def employee_signup_params
    params.require(:employee).permit(:name, :designation,:email,:phone,:gender,:dateofjoin,:dateofbirth,:active,:username,:address,:personalemail,:password,:password_confirmation)
  end

  def employee_params
    params.require(:employee).permit(:dateofbirth,:personalemail,:image)
  end
  
end
