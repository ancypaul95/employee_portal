class EmployeesController < ApplicationController
  def show
    @employee = Employee.find_by(params[:id])
  end
  
  def new
    @employee=Employee.new
  end

  def create
    @employee = Employee.new(employee_signup_params)
    if @employee.save
      # Handle a successful save.
      log_in @employee
      flash[:success] = "Welcome to the Employee Portal!"
      #redirect_to login_path 
      redirect_to login_path
    else
      render 'new'
    end
  end
  
  def edit
    @employee = current_employee
    #@employee = Employee.find_by(params[:id])
  end

  def update
    @employee = current_employee
    if @employee.update_attributes(employee_params)
      # Handle a successful update.
      flash[:success] = "Updated!"
      redirect_to @employee
    else
      render 'edit'
    end
  end

  private

  def employee_signup_params
    params.require(:employee).permit(:name, :designation,:email,:gender,:dateofjoin,:dateofbirth,:address,:personalemail,:password,:password_confirmation)
  end

    def employee_params
      params.require(:employee).permit(:name, :designation,:email,:gender,:dateofjoin,:dateofbirth,:address,:personalemail)
    end
end
