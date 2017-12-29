class AdminController < ApplicationController
  def new
  end
 
  def index
    #@employee=Employee.all
    @employee = Employee.order("created_at DESC").paginate(page: params[:page], :per_page => 10)
  end

  def edit    
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id]) 
    if @employee.update_attributes(employee_updparams) 
      flash[:success] = "Profile Updated!"
      redirect_to adminemployee_path
    else
      flash.now[:error] = "updation failed!"
      redirect_to adminedit_path
    end
  end

  private

  def employee_updparams
    params.require(:employee).permit(:name,:designation,:email,:phone,:gender,:dateofjoin,:address,:active)
  end
end
