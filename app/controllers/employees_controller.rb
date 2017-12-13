class EmployeesController < ApplicationController
  def new
    @employee=Employee.new
  end
  def show
    @employee = Employee.find(params[:id])
  end
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      # Handle a successful save.
      log_in @employee
      flash[:success] = "Welcome to the Employee Portal!"
      redirect_to @employee      
    else
      render 'new'
    end
  end

  private

    def employee_params
      params.require(:employee).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
