class ApplicationController < ActionController::Base
    def not_found_method
      render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
    end
  end