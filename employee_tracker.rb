require 'active_record'
require './lib/division'
require './lib/employee'
require './lib/project'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  system 'clear'
  puts "Welcome to the Employee Tracker Program"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Type '1' to add an Employee."
    puts "Type '2' to list employees."
    puts "Type '3' to add a Division."
    puts "Type '4' to list Divisions."
    puts "Type 'e' to exit."
    choice = gets.chomp
    case choice
    when '1'
      add_employee
    when '2'
      list_employees
    when '3'
      add_division
    when '4'
      list_divisions
    when 'e'
      puts "Good-bye!"
      sleep(1)
      system 'clear'
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def add_employee
  puts "*** ADD EMPLOYEE ***\n\n"
  puts "Please add the name of an Employee: "
  employee_name = gets.chomp
  employee = Employee.new({:name => employee_name})
  employee.save
  puts "'#{employee_name}' has been added to the list of current Employees."
end

def list_employees
  puts "*** CURRENT EMPLOYEES ***\n"
  puts "Type 'd' to delete an employee."
  puts "Type 'e' to return to the main menu.\n\n"
  employees = Employee.all
  employees.each do |employee|
    puts employee.name
  end
  puts "\n"
  choice = gets.chomp
  case choice
  when 'e'
    menu
  when 'd'
    delete_employee
  else
    puts "Sorry, that wasn't a valid option."
  end
end

def delete_employee
  puts "*** DELETE AN EMPLOYEE ***\n"
  puts "Please type the name of an Employee who you would like to delete:"
  Employee.all.each do |employee|
    puts employee.name
    puts "\n"
  end
  employee_name = gets.chomp
  deleted_employee = Employee.where({:name => employee_name}).first
  deleted_employee.destroy
  puts "#{employee_name} is no longer a Current Employee."
end

def add_division
  puts "*** ADD DIVISION ***\n\n"
  puts "Please add the name of an Division: "
  division_name = gets.chomp
  division = Division.new({:name => division_name})
  division.save
  puts "'#{division_name}' has been added to the list of current Divisions."
end



welcome
