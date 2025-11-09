class UsersController < ApplicationController
  # ユーザーの詳細ページ表示のデータを受け付けるアクション

  def index
    # 🌟 修正点: データベースからすべてのユーザーを取得し @users に代入 🌟
    @users = User.all.order(created_at: :desc)
  end
  
  def show
    # URLからユーザーIDを取得し、該当ユーザーを @user に代入
    @user = User.find(params[:id])
    @prototypes = @user.prototypes.order("created_at DESC")
  end
 end 
  # 必要に応じて、ユーザーに紐づくプロトタイプも取得
    
