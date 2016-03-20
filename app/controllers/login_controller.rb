class LoginController < ActionController::Base
  layout 'application' # what. the. hell.

  def initial
  end

  def design
    @uri  = params[:our_image]

    result = recognise_face
    if result === true
      # cool
    else
      @error = result
      render 'initial'
    end
  end

  def do_save
    @uri = params[:image_uri]
    # check everything matches!
    pin_matches = params[:choice][:hat] == USER_TABLE[0][:pin][0].to_s &&
       params[:choice][:eye] == USER_TABLE[0][:pin][1].to_s &&
       params[:choice][:mouth] == USER_TABLE[0][:pin][2].to_s &&
       params[:choice][:neck] == USER_TABLE[0][:pin][3].to_s

    if true || pin_matches #FAKERY
      render 'success'
    else
      @error = "I don't recognise your get-up!"
      render 'initial'
    end
  end

  private

  def recognise_face
    return true # FAKERY

    client = Face.get_client(api_key: ENV['FACE_KEY'], api_secret: ENV['FACE_SECRET'])
    recognised = client.faces_recognize(uids: USER_TABLE[0][:uid], file: @uri)

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
