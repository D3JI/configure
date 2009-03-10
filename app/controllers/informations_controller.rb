class InformationsController < ApplicationController
  Information.content_columns.each do |c|
    in_place_edit_for :information, c.name
  end

  def index
    @user = User.find(params[:user_id])
    @information = @user.informations
  end
end
