require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class ArchivesController < FrancisCmsController
    include FrancisCms::ApplicationHelper

    def index
      @years = parent_class.years
    end

    def show
      year

      @results = parent_class.for_year(@year)
    end

    private

    def parent_class
      @parent_class ||= "FrancisCms::#{resource_type.classify}".constantize
    end

    def year
      @year ||= params[:year]
    end
  end
end
