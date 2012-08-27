class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  # find the best cir based upon Environment
  # include Ccap::Cir
  # before_filter :get_best_cir

  protect_from_forgery
end

