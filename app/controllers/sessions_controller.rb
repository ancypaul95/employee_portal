class SessionsController < ApplicationController
  def new
  end

  def create
    employee = Employee.find_by(email: params[:session][:email].downcase)
    if employee && employee.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in employee
      #remember employee
      params[:session][:remember_me] == '1' ? remember(employee) : forget(employee)     
      redirect_to home_path
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
