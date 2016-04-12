class StoreController < ApplicationController
  def index
    @goods = Good.order(:title)
  end
end
