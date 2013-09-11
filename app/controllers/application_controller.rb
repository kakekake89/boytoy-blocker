class ApplicationController < ActionController::Base

  before_filter :block_old_ie, :block_tor

  def forem_user
    current_user
  end
  helper_method :forem_user

  protect_from_forgery

# -------------------------------------------------

private
  Browser = Struct.new(:browser, :version)

  OldIE = [
    Browser.new("Internet Explorer", "10.0")
  ]

  def block_old_ie
    user_agent = UserAgent.parse(request.user_agent)

    if OldIE.detect { |browser| user_agent < browser }
      render "layouts/block_old_ie", :layout => false
    end
  end

  # -------------------------------------------------

  def block_tor
    @tor_ips = IO.readlines("#{Rails.root}/db/tor.db").map(&:strip)

    if @tor_ips.include? request.remote_ip
      render "layouts/block_tor", :layout => false
    end
  end
end
