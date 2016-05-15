# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.suanmokkh.org"
SitemapGenerator::Sitemap.compress = true
SitemapGenerator::Sitemap.create do
  routes = Rails.application.routes.routes.map do |route|
    {alias: route.name, path: route.path.spec.to_s, controller: route.defaults[:controller], action: route.defaults[:action]}
  end

  banned_controllers = ["rails/info", nil, "/admin", "admin", "admin/", "404"]
  banned_actions = ["new", "edit", "destroy", "update", "create"]
   routes.reject! {|route| banned_controllers.include?(route[:controller])}
   routes.reject! {|route| banned_actions.include?(route[:action])}
   routes.reject! {|route| (route[:path]).include?('admin')}
   routes.reject! {|route| (route[:path]).include?('mailers')}
   routes.reject! {|route| (route[:path]).include?('id')}
  # sitemap_generator includes root by default; prevent duplication
   routes.reject! {|route| route[:path] == '/'}

   routes.each {|route| add route[:path][0..-11]} # Strips off '(.:format)

  # Add '/books'
  #
    add books_path, :priority => 0.7, :changefreq => 'weekly'
  #
  # Add all books:
  #
    Book.find_each do |book|
      add book_path(book), :lastmod => book.updated_at
    end

  # Add '/retreat_talks'
  #
    add books_path, :priority => 0.7, :changefreq => 'weekly'
  #
  # Add all retreat talks:
  #
    RetreatTalk.find_each do |retreat_talk|
      add retreat_talk_path(retreat_talk), :lastmod => retreat_talk.updated_at
    end

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
end
