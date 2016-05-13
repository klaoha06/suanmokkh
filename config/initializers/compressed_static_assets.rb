# namespace :assets do
#   desc "Create .gz versions of assets"
#   task :gzip => :environment do
#     zip_types = /\.(?:css|html|js|otf|svg|txt|xml)$/

#     public_assets = File.join(
#       Rails.root,
#       "public",
#       Rails.application.config.assets.prefix)

#     Dir["#{public_assets}/**/*"].each do |f|
#       next unless f =~ zip_types

#       mtime = File.mtime(f)
#       gz_file = "#{f}.gz"
#       next if File.exist?(gz_file) && File.mtime(gz_file) >= mtime

#       File.open(gz_file, "wb") do |dest|
#         gz = Zlib::GzipWriter.new(dest, Zlib::BEST_COMPRESSION)
#         gz.mtime = mtime.to_i
#         IO.copy_stream(open(f), gz)
#         gz.close
#       end

#       File.utime(mtime, mtime, gz_file)
#     end
#   end

#   # Hook into existing assets:precompile task
#   Rake::Task["assets:precompile"].enhance do
#     Rake::Task["assets:gzip"].invoke
#   end
# end

# require 'action_dispatch/middleware/static'

# module Middleware
#   class FileHandler < ActionDispatch::FileHandler
#     def initialize(root, assets_path, cache_control)
#       @assets_path = assets_path.chomp('/') + '/'
#       super(root, cache_control)
#     end

#     def match?(path)
#       path.start_with?(@assets_path) && super(path)
#     end
#   end

#   class CompressedStaticAssets
#     def initialize(app, path, assets_path, cache_control=nil)
#       @app = app
#       @file_handler = FileHandler.new(path, assets_path, cache_control)
#     end

#     def call(env)
#       if env['REQUEST_METHOD'] == 'GET'
#         request = Rack::Request.new(env)
#         encoding = Rack::Utils.select_best_encoding(
#           %w(gzip identity), request.accept_encoding)

#         if encoding == 'gzip'
#           pathgz = env['PATH_INFO'] + '.gz'
#           if match = @file_handler.match?(pathgz)
#             # Get the filehandler to serve up the gzipped file,
#             # then strip the .gz suffix
#             env["PATH_INFO"] = match
#             status, headers, body = @file_handler.call(env)
#             path = env["PATH_INFO"] = env["PATH_INFO"].chomp('.gz')

#             # Set the Vary HTTP header.
#             vary = headers["Vary"].to_s.split(",").map { |v| v.strip }
#             unless vary.include?("*") || vary.include?("Accept-Encoding")
#               headers["Vary"] = vary.push("Accept-Encoding").join(",")
#             end

#             headers['Content-Encoding'] = 'gzip'
#             headers['Content-Type'] =
#               Rack::Mime.mime_type(File.extname(path), 'text/plain')
#             headers.delete('Content-Length')

#             return [status, headers, body]
#           end
#         end
#       end

#       @app.call(env)
#     end
#   end
# end