class EntriesController < ApplicationController
  before_action only: :index

  def index
  	if params[:category].blank?
    	@entries = Entry.all.paginate(page: params[:page], per_page: 6).order('fblikes desc')
    else
    	@category_id = Category.find_by(name: params[:category]).id 
    	@entries = Entry.where(category_id: @category_id).paginate(page: params[:page], 
    		per_page: 6).order('fblikes desc')
    end
  end
 
end
