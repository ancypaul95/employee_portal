class AdminController < ApplicationController
  def new
  end

  def index
    @employee=Employee.all
  end

end
