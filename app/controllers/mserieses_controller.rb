require 'will_paginate/array'

class MseriesesController < ApplicationController

  def index
    @serieses = Mseries.order(startYear: :desc).where.not(['image_path LIKE ?', "%image_not_available%"]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    if Mseries.find_by(id: params[:id])
      @series = Mseries.find(params[:id])
    else
      Mseries.retrieve_series(params[:id])
      @series = Mseries.find_by(id: params[:id])
    end
  end

  def search_api
    @serieses = Mseries.search_api(params[:q].gsub(/"/,' ').gsub(' ','%20')).paginate(:page => params[:page], :per_page => 10)
    render :index
  end

  def retrieve_comics
    @series = Mseries.find_by(id: params[:id])
    Mseries.add_series_comics(@series)
    render :show
  end

end