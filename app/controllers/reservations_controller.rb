class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index
    @reservations = current_user.reservations
  end

  def show
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user

    if @reservation.valid?
      # 支払い金額を計算してセッションに保存
      session[:reservation_params] = @reservation.attributes.merge(sum_price: @reservation.calculate_sum_price)
      redirect_to reservations_confirm_path
    else
      flash[:alert] = '予約情報が不足しています。'
      render 'rooms/show', locals: { room: @room }
    end
  end

  def confirm
    @reservation = Reservation.new(session[:reservation_params])
    @room = @reservation.room
  end

  def complete
    @reservation = Reservation.new(session[:reservation_params])
    
    if @reservation.save
      session.delete(:reservation_params)
      redirect_to reservations_path, notice: '予約が完了しました。'
    else
      render :confirm
    end
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to reservations_path, notice: '再予約が完了しました。'
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_path, notice: '予約を削除しました。'
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:room_id, :start_date, :end_date, :people, :sum_price)
  end
end
