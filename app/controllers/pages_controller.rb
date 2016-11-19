class PagesController < ApplicationController
	def show
      if valid_page?
        render template: "pages/#{params[:page]}"
      else
        render file: "public/404.html", status: :not_found
      end
    end

  def map
		
    if loggedIn? && currentUser.isAdmin
      redirect_to admin_index_path
    end
  end

    private
    def valid_page?
      File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
    end
end
