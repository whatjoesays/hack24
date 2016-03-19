require 'base64'

class StaticController < ActionController::Base
  layout 'application' # what. the. hell.

  def test
  end

  def snap
    data = Base64.encode64(File.read(params[:our_image].tempfile)).gsub("\n", '')
    @uri  = "data:image/png;base64,#{data}"
  end
end
