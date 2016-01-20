module MonbanLockable
  extend ActiveSupport::Concern

  def active?
    !access_locked?
  end

  def access_locked?
    lock_expires_at? && lock_expires_at >= Time.current
  end

  def increment_failed_logins_count_and_lock_access!
    increment_failed_logins_count!
    lock_access
  end

  def increment_failed_logins_count!
    unless access_locked?
      update_column(:lock_expires_at, nil)
      increment!(:failed_logins_count)
    end
  end

  def lock_access
    if failed_logins_count > Monban.config.maximum_failed_login_attempts
      update_column(:lock_expires_at, Time.current + Monban.config.unlock_time_in_secs)
    end
  end

  def unlock_access
    if failed_logins_count > 0
      update_columns(lock_expires_at: nil, failed_logins_count: 0)
    end
  end

  def has_lockable_fields?
    respond_to?(:failed_logins_count) && respond_to?(:lock_expires_at)
  end
end
