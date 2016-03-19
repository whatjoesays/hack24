class LoginController < ActionController::Base
  layout 'application' # what. the. hell.

  def initial
  end

  def design
    data = Base64.encode64(File.read(params[:our_image].tempfile)).gsub("\n", '')
    @uri  = "data:image/png;base64,#{data}"
  end

  def do_save
    # check everything matches!
    if false
      render 'success'
    else
      @error = "Unrecognised face!"
      render 'initial'
    end
  end
end
