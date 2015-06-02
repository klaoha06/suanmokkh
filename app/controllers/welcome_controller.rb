class WelcomeController < ApplicationController
  def index
  	@books = [{title: 'yoyoyo', img: 'book12.jgp'}]
  end
end
