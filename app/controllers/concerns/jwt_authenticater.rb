module JwtAuthenticater
  require "jwt"

  SECRET_KEY = Rails.env.development? Rails.application.secrets.secret_key_base : ENV["SECRET_KEY_BASE"]

  def encode(user_id)
    expires_in = 1.week.from_now.to_i 
    preload = { user_id: user_id, exp: expires_in }
    JWT.encode(preload, SECRET_KEY, 'HS256')
  end

  def decode(encoded_token)
    decoded_dwt = JWT.decode(encoded_token, SECRET_KEY, true, algorithm: 'HS256')
    decoded_dwt.first
  end

end