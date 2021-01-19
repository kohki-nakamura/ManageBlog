class ApplicationController < ActionController::Base
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
end
