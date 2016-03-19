class LoginController < ActionController::Base
  layout 'application' # what. the. hell.

  def initial
  end

  def design
    data = Base64.encode64(File.read(params[:our_image].tempfile)).gsub("\n", '')
    @uri  = "data:image/png;base64,#{data}"

    result = recognise_face
    if result === true
      # cool
    else
      @error = result
      render 'initial'
    end
  end

  def do_save
    # check everything matches!
    pin_matches = params[:choice][:hat] == USER_TABLE[0][:pin][0] &&
       params[:choice][:eye] == USER_TABLE[0][:pin][1] &&
       params[:choice][:mouth] == USER_TABLE[0][:pin][2] &&
       params[:choice][:neck] == USER_TABLE[0][:pin][3]

    if pin_matches
      render 'success'
    else
      @error = "I don't recognise your get-up!"
      render 'initial'
    end
  end

  private

  def recognise_face
    return true

    client = Face.get_client(api_key: ENV['FACE_KEY'], api_secret: ENV['FACE_SECRET'])
    recognised = client.faces_recognize(uids: USER_TABLE[0][:uid], file: File.new(params[:our_image].tempfile.path, 'rb'))

    if recognised['photos'][0]['tags'].size > 0
      if recognised['photos'][0]['tags'][0]['uids'].size > 0
        if recognised['photos'][0]['tags'][0]['uids'][0] == USER_TABLE[0][:uid]
          # fine!
          return true
        else
          return { error: 'Face does not look like yours!' }
        end
      else
        return { error: 'Faces found, but not recognised... ' }
      end
    else
      return { error: 'No faces found' }
    end
  end
end
