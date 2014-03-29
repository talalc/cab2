class McomicsController < ApplicationController

  def index
    @comics = Mcomic.paginate(:page => params[:page], :per_page => 20)
  end

  def search_api
    searchstring = params[:q].gsub(/"/,' ')
    @comics = []
    Mcomic.where(['title LIKE ?', "%#{searchstring}%"]).each do |comic|
      @comics << comic
    end
    results = Mcomic.search_api(searchstring.gsub(' ','%20'))
    results.each do |id|
      @comics << Mcomic.find(id)
    end
    render :results
  end

  def show
    @comic = Mcomic.find(params[:id])
  end

end