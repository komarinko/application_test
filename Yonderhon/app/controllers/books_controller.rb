class BooksController < ApplicationController


	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id

		@books = Book.all
		if @book.save
    	flash[:success] = 'Book was successfully created.'
		redirect_to book_path(@book.id)
		else
		render :index
		end
	end

	def show
		@user = current_user
		@user_book = Book.find(params[:id])
		@book = Book.new
	end

	def index
		@book = Book.new
		@books = Book.all

		@user = current_user
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user.id != current_user.id
			redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		@book.user_id = current_user.id
		if @book.update(book_params)
    	flash[:success] = 'Book was successfully updated.'
		redirect_to book_path(@book.id)
		else
			render :edit
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.user_id = current_user.id
		@book.destroy
    	flash[:success] = 'Book was successfully destroyed.'
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :opinion)
	end

end
