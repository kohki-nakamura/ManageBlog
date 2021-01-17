class Admin::ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :check_admin_user
	layout "admin/layouts/application"

	private
	def check_admin_user
		redirect_to root_path unless current_user.is_admin?
	end
end
