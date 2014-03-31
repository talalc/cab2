class MseriesesController < ApplicationController

  def index
    @series = Mseries.paginate(:page => params[:page], :per_page => 20)
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

  def show
    @series = Mseries.find_by(id: params[:id])
  end

end