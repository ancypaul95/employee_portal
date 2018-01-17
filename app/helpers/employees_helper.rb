module EmployeesHelper
  def date_converter(dates)
    birthday = dates.split('/')
    birthday[0], birthday[1] = birthday[1], birthday[0]
    birthday.join('/')
  end
end
