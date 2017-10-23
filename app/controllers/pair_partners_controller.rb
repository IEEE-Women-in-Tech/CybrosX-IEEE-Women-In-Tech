class PairPartnersController < ApplicationController

  before_action :require_login

  def index
    @extended_profile = current_user.extended_profile
    if current_user.extended_profile
      @pair_partners = ExtendedProfile.pair_partners - [current_user.extended_profile]
    else
      @pair_partners = ExtendedProfile.pair_partners
    end
  end

end