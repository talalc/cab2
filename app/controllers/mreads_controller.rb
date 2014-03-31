class MreadsController < ApplicationController

    def create
        mcomic_id = params[:mread][:mcomic_id]

        mcomic = Mcomic.find_by(id: mcomic_id)
        user = User.find_by(id: session[:user_id])

        if user.mark_as_mread(mcomic)
            flash[:notice] = "Marked as Read!"
            redirect_to mcomic_path(mcomic)
        else
            flash[:notice] = "Not marked as read?"
            redirect_to mcomic_path(mcomic)
        end
    end

    def destroy
        mread = Mread.find(params[:id])
        mcomic = mread.mcomic
        user = current_user
        user.cc -= 100
        if mread.delete && user.save
            flash[:notice] = "Unmarked as Read!"
            redirect_to mcomic_path(mcomic)
        else
            flash[:notice] = "Not unmarked?"
            redirect_to mcomic_path(mcomic)
        end

    end

end