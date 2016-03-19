class StaticController < ActionController::Base
  def test
  end

  def snap
    render text: params.inspect
  end
end
