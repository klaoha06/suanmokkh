class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  @query = nil

  def index
      # @books = Book.includes(:authors, :groups, :languages).where(@query).order('created_at DESC').limit(20)
      # @books = Book.search(params[:q]).result

      # @q = Book.search(params[:q])
      # @books = @q.result(distinct: true)

    # @books = Book.search(params[:language], params[:author], params[:series]).order('books.created_at DESC').page params[:page]
    @featured_books = Book.includes(:authors, :groups, :languages).where(featured: true).order('created_at DESC').limit(10)
    # @featured_book = Book.order('created_at DESC').find_by(featured: true)
    # if !@featured_book
    #   @featured_book = @books.first
    # end
    # @filterrific = initialize_filterrific(
    #   Book,
    #   params[:filterrific]
    # ) or return
    # @books = @filterrific.find.page(params[:page])

    # respond_to do |format|
    #   format.html
    #   format.js
    # end
    # @search = Book.search(params[:q])
    # @books = @search.result
    #
    # @languages = Language.all

    @filterrific = initialize_filterrific(
      Book,
      params[:filterrific],
      :select_options => {
        with_language_id: Language.options_for_select,
        with_author_id: Author.options_for_select,
        with_series: Book.options_for_series,
      },
      persistence_id: 'shared_key',
      # default_filter_params: {},
      # available_filters: [],
    ) or return
    @books = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.includes(:authors, :audios, :groups, :languages).where(id: params[:id]).first
    @audio_languages = ''
    # @book.audios.each do |audio|
    #   @audios_languages + audio.languages.name + " " if audio.language.name
    # end
  end

  # GET /books/new
  # def new
  #   @book = Book.new
  # end

  # # GET /books/1/edit
  # def edit
  # end

  # # POST /books
  # # POST /books.json
  # def create
  #   @book = Book.new(book_params)

  #   respond_to do |format|
  #     if @book.save
  #       format.html { redirect_to @book, notice: 'Book was successfully created.' }
  #       format.json { render :show, status: :created, location: @book }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @book.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /books/1
  # # PATCH/PUT /books/1.json
  # def update
  #   params.permit!
  #   respond_to do |format|
  #     if @book.update(book_params)
  #       format.html { redirect_to @book, notice: 'Book was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @book }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @book.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /books/1
  # # DELETE /books/1.json
  # def destroy
  #   @book.destroy
  #   respond_to do |format|
  #     format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:language_ids, :group_ids, :author_ids, :audio_ids, :publisher_ids,:id, :title, :cover_img, :publisher, :description, :group, :language, :isbn_10, :isbn_13, :downloads, :draft, :series, :file, :allow_comments, :weight, :pages, :publication_date, :format, :price, :featured, :author_ids, :publisher_ids, authors_attributes: [ :id, :name, :first_name, :last_name, :brief_biography ], publishers_attributes: [ :name, :id ])
  end
end
