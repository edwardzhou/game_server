class SessionsController < WebsocketRails::BaseController
  # To change this template use File | Settings | File Templates.

  def sign_in
    username = message[:username].try(:downcase)
    user = User.find_by_username(username)
    unless user
      trigger_failure({:error_message => "user #{username} do not exists!"})
      return
    end

    password_md5 = Digest::MD5.hexdigest("" << message[:password] << user.password_salt)

    if password_md5.eql?(user.password_digest)
      trigger_success({:message => "login ok"})
    else
      trigger_failure({:error_message => "password incorrect!"})
    end


  end

  def sign_up
    username = message[:username].downcase

    if User.exists?(:username => username)
      trigger_failure({:error_message => "user #{username} exists already!"})
    else
      new_user = User.new
      new_user.password_salt = Guid.new.hexdigest
      new_user.username = username
      new_user.password_digest = Digest::MD5.hexdigest("" << message[:password] << new_user.password_salt)
      new_user.save

      trigger_success({:user => new_user})
    end

  end

  def sign_out

  end

end