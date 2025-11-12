class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]
  
   # コメントの新規作成（投稿）のデータを受け付けるアクション
  def create
    # params[:prototype_id] はルーティングでネストされたURLから取得
     @prototype = Prototype.find(params[:prototype_id])
     @comment = @prototype.comments.new(comment_params) 

    if @comment.save
     redirect_to prototype_path(@prototype)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
       render 'prototypes/show', status: :unprocessable_entity
      # views/prototype/show.html.erbのファイルを参照しています。    
    end
   end 

  private
  
  def comment_params
    # 1. フォームからの入力値（:content）だけを許可
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
  
  # ... (他のアクションがあればここに記述) ...
   
end
