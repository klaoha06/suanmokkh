class BooksController < ApplicationController
  def index
    @robot_img = 'http://www.bia.or.th/en/images/photo/08dec.jpg'
    @title = 'Book Library - Suan Mokkh'
    @featured_books = Book.includes(:authors, :groups, :languages).where(featured: true, draft: false).order('created_at DESC').limit(10)
    @recommended_books = Book.includes(:authors).where(recommended: true, draft: false).order('created_at DESC').limit(15)
    @filterrific = initialize_filterrific(
      Book,
      params[:filterrific],
      :select_options => {
        with_language_id: Language.options_for_select,
        with_author_id: Author.options_for_select,
        with_series: Book.options_for_series,
      },
      # default_filter_params: [],
      # persistence_id: 'shared_key',
      # available_filters: [],
    ) or return
    @books = @filterrific.find.page(params[:page]).where(draft: false)
    # @books = @books.where(draft: false)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.includes(:authors, :audios, :groups, :languages, :related_books).where(id: params[:id], draft: false).first
    if @book.blank?
      respond_to do |format|
        format.html { render template: 'shared/_not_found', layout: 'layouts/application', status: 404 }
        format.all  { render nothing: true, status: 404 }
      end
      return
    elsif !@book.blank?
      @title = @book.title.to_s + " by " + (@book.authors.first.name.to_s if @book.authors.first) + " - Suan Mokkh"
      if !@book.external_cover_img_link.blank?
        @img =  @book.external_cover_img_link
      elsif !@book.cover_img.url.blank?
        @img = 'http://www.suanmokkh.org' + @book.cover_img.url
      else
        @img = 'http://www.thaipulse.com/photos/thailand-buddhism/hl/images/suan-mokkh-buddha-statue-whole-leaves-blurred.jpg'
      end
      @related_books = @book.related_books.unshift(@book)
      @audio_languages = ''
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
      @languages = []
      @related_books.each do |rb|
        language_option = ''
        rb.languages.each_with_index do |l,index|
          if index != rb.languages.count-1 
            language_option << l.name + ' and '
          elsif index == rb.languages.count-1
            language_option << l.name
            @languages << l.name
          end
        end
        @options_for_book_languages << [language_option, rb.id]
      end
    end

    if !@languages.blank?
      @languages.uniq!
    end

    @additional_info = Hash.new
     @book.attributes.each do |k,v| 
       if k == 'series' ||  k == 'isbn_10' || k == 'isbn_13' || k == 'publication_date' || k == 'format' || k == 'weight' || k == 'price' || k == 'pages' || k == 'transcriber'
         if v == nil || v == "" 
         else 
            @additional_info[k.capitalize] = v  
         end 
       end 
     end

    @authors = []
    @book.authors.each do |author| 
      if author.name != ''
        @authors << author.name
      end 
    end 
    @additional_info['Authors'] = @authors

    @publishers = []
    @book.publishers.each do |pub|
      if pub.name != ''
        @publishers << pub.name
      end
    end
    @additional_info['Publishers'] = @publishers
  end


  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:language_ids, :group_ids, :author_ids, :audio_ids, :publisher_ids,:id, :title, :cover_img, :publisher, :description, :group, :language, :isbn_10, :isbn_13, :downloads, :draft, :series, :file, :allow_comments, :weight, :pages, :publication_date, :format, :price, :featured, :author_ids, :publisher_ids, authors_attributes: [ :id, :name, :first_name, :last_name, :brief_biography ], publishers_attributes: [ :name, :id ])
  end
end
