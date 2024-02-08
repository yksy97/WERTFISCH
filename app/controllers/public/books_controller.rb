class Public::BooksController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @book_comments = @book.book_comments.order(created_at: :desc)
  end

 def index
  @q = Book.ransack(params[:q])
  @books = @q.result(distinct: true).order(created_at: :desc)
  @book = Book.new
end

  
def create
  @book = Book.new(book_params)
  @book.customer_id = current_customer.id
  # respond_toブロックといえば、formatメゾット
  # formatメゾットで特定のリクエスト形式（htmlやjs、json）に対する具体的な処理を記述する
  # respond_toブロックはformatメゾットによって異なるリクエスト形式に対する応答を処理する
  respond_to do |format|
    if @book.save
      format.html { redirect_to books_path, notice: "投稿が完了しました" }
      format.js { @books = Book.all }
    else
      format.html { redirect_to books_path, alert: "投稿に失敗しました" }
      format.js { @books = Book.all }
    end
  end
end


  def edit
  end
  
  def genre
    genre = Genre.find(params[:id])
    @books = genre.books
  end

def update
  respond_to do |format|
    if @book.update(book_params)
      format.html { redirect_to book_path(@book), notice: "You have updated book successfully." }
      format.js   # update.js.erb を呼び出す
    else
      format.html { render "edit" }
      format.js   # errors.js.erb を呼び出してエラーメッセージを表示する
    end
  end
end

def destroy
  @book.destroy
  respond_to do |format|
    format.html { redirect_to books_path, notice: "Book was successfully destroyed." }
    format.js   # destroy.js.erb を呼び出す
  end
end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.customer == current_customer
      redirect_to books_path
    end
  end
end
