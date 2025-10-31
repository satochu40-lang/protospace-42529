class Comment < ApplicationRecord
    
  # このコメントは、一人のユーザーに「属する」
  belongs_to :user
  
  # このコメントは、一つのプロトタイプに「属する」
  belongs_to :prototype

  # ... (バリデーションなどをここに書く) ...
  # content カラムにデータが入っていることをチェックする
  validates :content, presence: true
end


