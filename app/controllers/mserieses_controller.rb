class MseriesesController < ApplicationController

  def index
    @series = Mseries.order(startYear: :desc).where.not(['image_path LIKE ?', "%image_not_available%"]).paginate(:page => params[:page], :per_page => 10)
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
    searchstring = params[:q].gsub(/"/,' ')
    @series = []
    Mseries.where(['title LIKE ?', "%#{searchstring}%"]).each do |series|
      @series << series
    end
    results = Mseries.search_api(searchstring.gsub(' ','%20'))
    results.each do |id|
      @series << Mseries.find(id)
    end
    render :results
  end

  def retrieve_comics
    @series = Mseries.find_by(id: params[:id])
    Mseries.add_series_comics(@series)
    render :show
  end

end