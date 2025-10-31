class UsersController < ApplicationController
  # ユーザーの詳細ページ表示のデータを受け付けるアクション
  def show
    # URLからユーザーIDを取得し、該当ユーザーを @user に代入
    @user = User.find(params[:id])
    @prototypes = @user.prototypes.order("created_at DESC")
  end
  
  # 必要に応じて、ユーザーに紐づくプロトタイプも取得
    
end