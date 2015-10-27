class BooksController < ApplicationController
  # before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  # @query = nil

  def index
      # @books = Book.includes(:authors, :groups, :languages).where(@query).order('created_at DESC').limit(20)
      # @books = Book.search(params[:q]).result

      # @q = Book.search(params[:q])
      # @books = @q.result(distinct: true)

    # @books = Book.search(params[:language], params[:author], params[:series]).order('books.created_at DESC').page params[:page]
    @featured_books = Book.includes(:authors, :groups, :languages).where(featured: true).order('created_at DESC').limit(10)
    @recommended_books = Book.includes(:authors).where(recommended: true).order('created_at DESC').limit(15)

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
      # persistence_id: 'shared_key',
      # default_filter_params: {},
      # available_filters: [],
    ) or return
    @books = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.includes(:authors, :audios, :groups, :languages, :related_books).where(id: params[:id]).first
    if @book == nil 
      respond_to do |format|
        format.html { render template: 'shared/_not_found', layout: 'layouts/application', status: 404 }
        format.all  { render nothing: true, status: 404 }
      end
    else

    @related_books = @book.related_books.unshift(@book)
    @audio_languages = ''
    # @book.audios.each do |audio|
    #   @audios_languages + audio.languages.name + " " if audio.language.name
    # end
    @options_for_audio_languages = []
      @book.audios.each do |a|
        language_option = ''
        a.languages.each_with_index do |l, index|
          if index != a.languages.count-1 
            language_option << l.name + ' and '
          elsif index == a.languages.count-1
            language_option << l.name
          end
        end
        @options_for_audio_languages << [language_option, a.id]
      end

    @options_for_book_languages = []
    @related_books.each do |rb|
      language_option = ''
      rb.languages.each_with_index do |l,index|
        if index != rb.languages.count-1 
          language_option << l.name + ' and '
        elsif index == rb.languages.count-1
          language_option << l.name
        end
      end
      @options_for_book_languages << [language_option, rb.id]
    end
  end


  end


  private
  # Use callbacks to share common setup or constraints between actions.


  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:language_ids, :group_ids, :author_ids, :audio_ids, :publisher_ids,:id, :title, :cover_img, :publisher, :description, :group, :language, :isbn_10, :isbn_13, :downloads, :draft, :series, :file, :allow_comments, :weight, :pages, :publication_date, :format, :price, :featured, :author_ids, :publisher_ids, authors_attributes: [ :id, :name, :first_name, :last_name, :brief_biography ], publishers_attributes: [ :name, :id ])
  end
end
