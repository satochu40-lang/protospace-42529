class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # :email_confirmation は保存不要なため削除する！
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])

    # アカウント情報更新時の許可リスト
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :occupation, :position])
  end
  def after_sign_up_path_for(resource)
    prototypes_path # プロトタイプ一覧ページへのパス
  end
end