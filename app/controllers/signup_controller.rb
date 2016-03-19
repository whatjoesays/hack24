class SignupController < ActionController::Base
  layout 'application' # what. the. hell.

  def initial
  end

  def design
    data = Base64.encode64(File.read(params[:our_image].tempfile)).gsub("\n", '')
    @uri  = "data:image/png;base64,#{data}"

    result = save_face
    if result === true
      # great!
    else
      @error = result
      render 'photo'
    end
  end

  def do_save
    # save all inputs to user and generate face tag
    render 'thanks', flash: 'Thanks for signing up!'
  end

  private

  def save_face
    client = Face.get_client(api_key: ENV['FACE_KEY'], api_secret: ENV['FACE_SECRET'])
    detected = client.faces_detect(file: File.new(params[:our_image].tempfile.path, 'rb'))
    tags = detected['photos'][0]['tags']
    if tags.length == 1
      @tid = tags[0]['tid']
      client.tags_save(uid: USER_TABLE[0][:uid], tids: @tid)
      client.faces_train(uids: USER_TABLE[0][:uid])
      return true
    elsif tags.length == 0
      return 'No faces found :('
    else
      return "#{tags.length} faces recognised, we can only work with one"
    end
  end
end
