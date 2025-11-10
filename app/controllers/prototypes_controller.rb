class PrototypesController < ApplicationController

    # 🌟 ログイン状態を確認する 🌟
    # new, create, edit, update, destroyアクションのみ、ログインを必須とする
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :move_to_index, except: [:index, :show]

  def index
    @prototypes = Prototype.all.order(created_at: :desc)
  end

  def new
    @prototype = Prototype.new
  end 

  def create
    @prototype= Prototype.create(prototype_params)
    
    if @prototype.save
      redirect_to root_path # '/' より root_path の方が一般的です

    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
  
    # 2. 🌟 ここに @comment を定義する
    @comment = Comment.new 

    # 3. 関連コメントを取得 (フォームの下に表示するために必要)
    # @prototype に紐づくコメントを全て取得します
    @comments = @prototype.comments.includes(:user) 
  end

  # 1. 編集ページを表示するアクション
  def edit
    @prototype = Prototype.find(params[:id])
  end

  # 2. データを更新するアクション
  def update
    # 1. データの取得: どの投稿を更新するか特定する
    @prototype = Prototype.find(params[:id]) 
    
    # 2. データの更新と条件分岐
    # @prototype.update で更新を試みる
    if @prototype.update(prototype_params)
      # 🌟 成功時：詳細ページへリダイレクト
      redirect_to prototype_path(@prototype) 
    else
      # 🌟 失敗時：編集ページに戻る（render）
      # render :edit を使うと、入力データとエラーメッセージを保持したまま edit.html.erb を再表示できる
      render :edit, status: :unprocessable_entity 
    end
  end
   
  def destroy
    # 1. データの取得
    @prototype = Prototype.find(params[:id]) 
    
    # 2. データの削除
    @prototype.destroy
    
    # 3. トップページへのリダイレクト
    redirect_to root_path
  end

    def move_to_index
      unless user_signed_in?
      redirect_to action: :index
    end
  
  private
  
  def prototype_params
    # フォームから受け取るキーを指定し、現在のユーザーIDをマージ
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end 
end

  
