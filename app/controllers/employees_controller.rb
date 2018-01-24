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
      @user = @graph.get_object('me?fields=picture,name,email,birthday,hometown,location,posts') 
      @user = {} if @user.nil?
      @user['birthday'] = date_converter(@user['birthday']) if !@user['birthday'].nil?
      @employee.update_attributes(fb_logged_in: true,
                                  fb_email: @user['email'],
                                  fb_birthday: @user['birthday'],
                                  fb_name: @user['name'],
                                  picture: @user.fetch('picture',{}).fetch('data',{}).fetch('url',nil).to_s,
                                  home_town: @user.fetch('hometown', {}).fetch('name', nil),
                                  fb_location: @user.fetch('location', {}).fetch( 'name', nil),
                                  fb_posts: @user.fetch('posts', {}).fetch('data', {}).fetch(0, {}).fetch('story', nil) || @user.fetch('posts', {}).fetch('data', {}).fetch(0, {}).fetch('message', nil)
                                )
    end
    if params['logout']
      @employee.update_attributes(fb_logged_in: false)
      redirect_to edit_employee_path(@employee)
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
