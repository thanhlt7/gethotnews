class EntriesController < ApplicationController
  before_action only: :index

  def index
    @entries = Entry.all.paginate(page: params[:page], per_page: 10).order('fblikes desc')
  end
 
end
