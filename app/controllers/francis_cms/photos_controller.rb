require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class PhotosController < FrancisCmsController
    before_action :require_login, except: [:index, :show]

    def index
      photos
    end

    def show
      require_login unless photo.published_at?
    end

    def new
      @photo = Photo.new(PhotoInput.new(params).to_h)
    end

    def create
      @photo = Photo.new(PhotoInput.new(params).to_h)

      if @photo.save
        redirect_to @photo, notice: 'Successfully saved your new photo! Here’s what it looks like.'
      else
        render 'new'
      end
    end

    def edit
      photo
    end

    def update
      if photo.update_attributes(PhotoInput.new(params).to_h)
        redirect_to @photo, notice: 'Success! Here’s what your updated photo looks like.'
      else
        render 'edit'
      end
    end

    def destroy
      photo.destroy

      redirect_to photos_path, notice: 'You’ve successfully deleted that photo. It’s gone for good!'
    end

    private

    def photos
      @photos ||= Photo.entries_for_page({ include_drafts: __logged_in__, page: params['page'] })
    end

    def photo
      @photo ||= Photo.find(params[:id])
    end
  end
end
