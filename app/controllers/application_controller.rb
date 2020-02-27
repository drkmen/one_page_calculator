class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :error_render_method

  def error_render_method
    @error = { message: 'error' }

    respond_to do |format|
      format.js { render @error }
    end
  end
end
