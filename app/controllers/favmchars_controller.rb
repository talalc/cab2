class FavmcharsController < ApplicationController

    def create
        mchar_id = params[:favmchar][:mchar_id]
        mchar = Mchar.find_by(id: mchar_id)
        user = User.find_by(id: session[:user_id])
        if user.favorite_mchar(mchar)
            flash[:notice] = "Favorited Character!"
            redirect_to mchar_path(mchar)
        else
            flash[:notice] = "Not favorited?"
            redirect_to mchar_path(mchar)
        end
    end

    def destroy
        user = current_user
        mchar = Mchar.find(params[:id])
        favchar = user.favmchars.find_by(mchar_id: params[:id])
        user.cc -= 500
        if favchar.delete && user.save
            flash[:notice] = "Unfavorited!"
            redirect_to mchar_path(mchar)
        else
            flash[:notice] = "Not unfavorited?"
            redirect_to mchar_path(mchar)
        end
    end

end