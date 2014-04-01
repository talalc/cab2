class McharsController < ApplicationController

  def index
    @chars = Mchar.all
  end

  def show
    @char = Mchar.find(params[:id])
  end

end