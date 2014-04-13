require 'will_paginate/array'

class MseriesesController < ApplicationController

  def index
    @serieses = Mseries.has_pic.order(startYear: :desc).paginate(:page => params[:page], :per_page => 10)
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