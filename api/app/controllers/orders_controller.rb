class OrdersController < APIBaseController
  load_and_authorize_resource
  before_action :auth_user

  def index
    return render status: 204 if @orders.empty?
    render json: @orders.order(id: :desc)
  end

  def show
    render json: full_order_in_json
  end
  
  def create
    order_dishes = params[:order_dishes]
    total_price = params[:total_price]

    unless order_dishes.empty?
      @order = Order.new(
        total: total_price,
        user_id: current_user.id
      )
      order_dishes.each do |order_dish|
        @order.orders_dishes.new(dish: Dish.find(order_dish[:dish_id]), quantity: order_dish[:quantity]).save
      end
      @order.save
      render json: full_order_in_json
    else
      render json:{"order_dishes": "empty"}, status: 400
    end
  end

  def destroy
    if @order.confirmed?
      render status: 403
    else
      @order.destroy
      render status: :ok
    end
  end

  def confirm
    @order = Order.find(params[:id])
    @order.update(confirmed: true)
    render json: full_order_in_json
  end
  
  private

  def full_order_in_json
    @order.to_json( include: { 
                      order_dishes: { only: %i[quantity],
                        include:{
                          dish:{}
                        }},
                    })  
  end
end
