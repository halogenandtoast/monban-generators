# Add Lockable Fields to Monban Configuration
Monban::Configuration.instance_eval do
  attr_accessor :maximum_failed_login_attempts
  attr_accessor :unlock_time_in_secs
end

# Set Default Configuration values to Lockable Fields
Monban.configure do |config|
  config.maximum_failed_login_attempts = 5
  config.unlock_time_in_secs = 1800
end

Monban::Services::Authentication.class_eval do
  # Perform the service
  #
  # @return [User] if authentication succeeds
  # @return [false] if authentication fails
  def perform
    if authenticated?
      @user.unlock_access
      @user
    else
      if @user
        @user.increment_failed_logins_count_and_lock_access!
      end
      false
    end
  end

  def authenticated?
    @user &&
      active_for_authentication? &&
      Monban.compare_token(@user.send(token_store_field), @undigested_token)
  end

  def active_for_authentication?
    if !!Monban.config.maximum_failed_login_attempts ||
        !!Monban.config.unlock_time_in_secs
      @user.active?
    else
      true
    end
  end
end
