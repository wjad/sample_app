class ApplicationController < ActionController::Base
  protect_from_forgery
  #the following line is to make SessionsHelper module accessable through out the application
  include SessionsHelper
end
