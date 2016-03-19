class SignupController < ActionController::Base
  layout 'application' # what. the. hell.

  def initial
  end

  def design
    data = Base64.encode64(File.read(params[:our_image].tempfile)).gsub("\n", '')
    @uri  = "data:image/png;base64,#{data}"
  end

  def do_save
    # save all inputs to user and generate face tag
    render 'thanks', flash: 'Thanks for signing up!'
  end
end
