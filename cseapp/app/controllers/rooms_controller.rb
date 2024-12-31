class RoomsController < ApplicationController
  before_action :authenticate_user!

  # GET /rooms
  def index
    @room = Room.new # Yeni bir oda oluşturuluyor
    @rooms = Room.public_rooms # Yalnızca public odaları alıyoruz

    @users = User.all_except(current_user) # Şu anki kullanıcı dışında diğer kullanıcılar
    render 'index' # Bu sayfada tüm odaları gösteriyoruz
  end

  # GET /rooms/:id
  def show
    @single_room = Room.find(params[:id]) # Odayı buluyoruz
    @room = Room.new # Yeni bir oda oluşturuluyor
    @rooms = Room.public_rooms # Yalnızca public odaları alıyoruz

    @message = Message.new # Yeni bir mesaj oluşturuluyor
    @messages = @single_room.messages.order(created_at: :asc) # Odadaki tüm mesajlar sıralanıyor

    @users = User.all_except(current_user) # Şu anki kullanıcı dışında diğer kullanıcılar
    render 'show' # Bu sayfada yalnızca tek bir odayı ve mesajları gösteriyoruz
  end

  # POST /rooms
  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to @room, notice: 'Oda başarıyla oluşturuldu.'
    else
      @rooms = Room.public_rooms
      @users = User.all_except(current_user)
      render :index # Hata varsa ana sayfaya geri dönüyoruz
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :is_private) # Oda adı ve özel mi olduğu bilgilerini alıyoruz
  end
end
