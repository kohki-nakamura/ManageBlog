class ApplicationController < ActionController::Base
	layout :layout_by_resource

	def after_sign_in_path_for(resource)
		if current_user.is_admin?
			admin_root_path
		else
			root_path
		end
	end

	def after_sign_out_path_for(resource)
    new_user_session_path # ログアウト後に遷移するpathを設定
  end

	protected

  def layout_by_resource
    if devise_controller?
      "devise/layouts/application"
    else
      "application"
    end
  end
end
