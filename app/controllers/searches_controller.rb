class SearchesController < ApplicationController
    def search
        @model = params["model"] #選択したモデル
        @method = params["method"] #検索方法
        @content = params["content"] #検索ワード
        @records = search_for(@model,@content,@method) #上記③つを代入
    end
    
    private
  
    def search_for(model, content, method)
      
      if model == "user" #選択したモデルがUserだった場合
        if method == "perfect" #完全一致なら
          User.where(name: content)
        elsif method == "forward"  #前方一致なら
          User.where("name LIKE?","#{content}%")
        elsif method == "backward" #後方一致なら
          User.where("name LIKE?","%#{content}")
        elsif method == "partial" #部分一致なら
          User.where("name LIKE ?", "%"+content+"%")
        else
          User.all
        end
        
      elsif model == "book" #選択したモデルがBookの場合
      
        if method == "perfect" #完全一致なら
         Book.where(title: content) or Book.where(body: content) or Book.where(category: content)
        elsif method == "forward"  #前方一致なら
          Book.where("category LIKE?","#{content}%")
        elsif method == "backward" #後方一致なら
          Book.where("category LIKE?","%#{content}")
        elsif method == "partial" #部分一致なら
          Book.where("category LIKE ?", "%"+content+"%")
        else 
          Book.all
        end
        
      end
    end
      
end


適切なオブジェクト名.where(['検索したいカラム名 ? OR 検索したいカラム名 LIKE ? OR 検索したいカラム名 LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])