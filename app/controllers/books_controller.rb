class BooksController < ApplicationController
	before_filter :login_required, :except => [:index, :show]

	def index
		@books =  Book.paginate :page => params[:page], :per_page => 8
	end

	def show
		@book = Book.find(params[:id])
		@comments = @book.comments.paginate :page => params[:page], :per_page => 5, :order => 'created_at ASC'  
	end

	def new
		@book = Book.new
	end

	# form.submit generates : POST '/books' which is routed to books#create. The POST contains the object associated with form_for as the parameter. 
	# The object as parameter in hash format i.e :book={"title" => "Wings of fire", "thoughts" => "Good One !!!"}.  
	def create
		book = Book.new(params[:book])  # form_for posts the entire model associated with it as the parameter in hash format. So we read that hash value (i.e :book) and create a book object out of it. 
		if book.save
			flash[:notice] = "#{book.title} saved."
			redirect_to book_path(book)
		else
			redirect :new			
		end                 
	end	

	def edit
		@book = Book.find(params[:id]) 
	end

	def update
		book = Book.find(params[:id])
		if book.update_attributes(params[:book])
			flash[:notice] = "#{book.title} saved."
			redirect_to book_path(book)	#This is similiar to writing -> redirect_to @book		
		else
			render :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		flash[:notice] = "#{book.title} deleted"
		redirect_to books_path
	end

	private
	def login_required
		unless current_admin
			flash[:error] = 'Only logged in admins can access this page.'
			redirect_to books_path
		end	
	end
end
