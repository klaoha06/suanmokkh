# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( classie.js )
Rails.application.config.assets.precompile += %w( cbpAnimatedHeader.js )
Rails.application.config.assets.precompile += %w( imagesloaded.pkgd.min.js )
Rails.application.config.assets.precompile += %w( isotope.pkgd.min.js )
Rails.application.config.assets.precompile += %w( home.js )
Rails.application.config.assets.precompile += %w( books.js )
Rails.application.config.assets.precompile += %w( poems.js )
Rails.application.config.assets.precompile += %w( buddhadasa.js )
Rails.application.config.assets.precompile += %w( suanmokkh.js )
Rails.application.config.assets.precompile += %w( gallery.js )
Rails.application.config.assets.precompile += %w( filterrific/filterrific-spinner.gif )
Rails.application.config.assets.precompile += %w( ckeditor/*)
