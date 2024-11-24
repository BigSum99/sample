class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :my_rooms]
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    if params[:address].present? || params[:keywords].present?
      @rooms = Room.looks(params)
    else
      @rooms = Room.all
    end
    @rooms_count = @rooms.count
  end

  def show
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user

    if @room.save
      redirect_to @room, notice: '施設登録しました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: '施設を編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to my_rooms_rooms_path, notice: '施設を削除しました。'
  end

  def my_rooms
    @rooms = current_user.rooms
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :price_per_night, :description, :address, :room_image)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end