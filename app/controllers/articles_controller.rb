class ArticlesController < InheritedResources::Base
	before_action :set_article, only: [:show, :edit, :update, :destroy]

	# GET /articles
	# GET /articles.json
	def index
	  @robot_img = 'http://www.bia.or.th/en/images/photo/08dec.jpg'
	  @title = 'Articles - Suan Mokkh'
	  # @featured_books = Book.includes(:authors, :groups, :languages).where(featured: true, draft: false).order('created_at DESC').limit(10)
	  # @recommended_books = Book.includes(:authors).where(recommended: true, draft: false).order('created_at DESC').limit(15)
	  @filterrific = initialize_filterrific(
	    Article,
	    params[:filterrific],
	    :select_options => {
	      with_language_id: Language.options_for_select,
	      with_author_id: Author.options_for_select,
	      with_series: Article.options_for_series,
	    },
	    # default_filter_params: [],
	    # persistence_id: 'shared_key',
	    # available_filters: [],
	  ) or return
	  @articles = @filterrific.find.page(params[:page]).where(draft: false)

	  respond_to do |format|
	    format.html
	    format.js
	  end
	end

	# GET /articles/1
	# GET /articles/1.json
	def show
		@article = Article.includes(:authors, :languages).where(id: params[:id], draft: false).first
		if @article.blank?
		  respond_to do |format|
		    format.html { render template: 'shared/_not_found', layout: 'layouts/application', status: 404 }
		    format.all  { render nothing: true, status: 404 }
		  end
		  return
		elsif !@article.blank?
		  @title = @article.title + " by " + (@article.authors.first.name if @article.authors.first) + " - Suan Mokkh"
		  if !@article.external_cover_img_link.blank?
		    @img = @article.external_cover_img_link
		  elsif !@article.cover_img.url.blank?
		    @img = 'http://www.suanmokkh.org' + @article.cover_img.url
		  else
		    @img = 'http://www.thaipulse.com/photos/thailand-buddhism/hl/images/suan-mokkh-buddha-statue-whole-leaves-blurred.jpg'
		  end
		end
	end

	# GET /articles/new
	def new
	  @article = Article.new
	end

	# GET /articles/1/edit
	def edit
	end

	# POST /articles
	# POST /articles.json
	def create
	  @article = Article.new(article_params)

	  respond_to do |format|
	    if @article.save
	      format.html { redirect_to @article, notice: 'article was successfully created.' }
	      format.json { render :show, status: :created, location: @article }
	    else
	      format.html { render :new }
	      format.json { render json: @article.errors, status: :unprocessable_entity }
	    end
	  end
	end

	# PATCH/PUT /articles/1
	# PATCH/PUT /articles/1.json
	def update
	  params.permit!
	  respond_to do |format|
	    if @article.update(article_params)
	      format.html { redirect_to @article, notice: 'article was successfully updated.' }
	      format.json { render :show, status: :ok, location: @article }
	    else
	      format.html { render :edit }
	      format.json { render json: @article.errors, status: :unprocessable_entity }
	    end
	  end
	end

	# DELETE /articles/1
	# DELETE /articles/1.json
	def destroy
	  @article.destroy
	  respond_to do |format|
	    format.html { redirect_to articles_url, notice: 'article was successfully destroyed.' }
	    format.json { head :no_content }
	  end
	end

	private
	  # Use callbacks to share common setup or constraints between actions.
	  def set_article
	    @article = Article.find(params[:id])
	  end

	  # Never trust parameters from the scary internet, only allow the white list through.
	  def article_params
	    params.require(:article).permit(:id, :title, :cover_img, :publisher, :description, :group, :language, :draft, :series, :file, :allow_comments, :publication_date, :featured, :author_ids, :publisher_ids, authors_attributes: [ :id, :name, :first_name, :last_name, :brief_biography ], publishers_attributes: [ :name, :id ])
	  end
end

