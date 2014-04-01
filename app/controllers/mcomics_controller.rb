class McomicsController < ApplicationController

  def index
    @comics = Mcomic.order(onsaleDate: :desc).where.not(['image_path LIKE ?', "%image_not_available%"]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    if Mcomic.find(params[:id])
      @comic = Mcomic.find(params[:id])
    else
      Mcomic.retrieve_comic(params[:id])
      @comic = Mcomic.find(params[:id])
    end
  end

  def retrieve_chars
    @comic = Mcomic.find_by(id: params[:id])
    Mcomic.add_comic_chars(@comic)
    render :show
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

  # def search_api_cache
  #   searchstring = params[:q].gsub(/"/,' ')
  #   @comics = []
  #   Mcomic.where(['title LIKE ?', "%#{searchstring}%"]).each do |comic|
  #     @comics << comic
  #   end
  #   results = Mcomic.search_api_cache(searchstring.gsub(' ','%20'))
  #   results.each do |id|
  #     @comics << Mcomic.find(id)
  #   end
  #   render :results
  # end

end