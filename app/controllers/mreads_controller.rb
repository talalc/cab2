class MreadsController < ApplicationController

    def create
        mcomic_id = params[:mread][:mcomic_id]

        mcomic = Mcomic.find_by(id: mcomic_id)
        user = User.find_by(id: session[:user_id])

        if user.mark_as_mread(mcomic)
            flash[:notice] = "Marked as Read!"
            redirect_to mcomics_path
        else
            flash[:notice] = "Not marked as read?"
            redirect_to mcomics_path
        end
    end

end