class OrdersController < APIBaseController
  authorize_resource
  before_action :auth_user

  def index
    unless current_superuser.present?
      orders = current_user.orders
      return render status: 204 if orders.empty?
    else
      orders = Order.all.order(id: :desc)
      return render status: 204 if orders.empty?
    end
    render json: orders
  end

  def show
    unless current_superuser.present?
      @order = current_user.orders.find(params[:id])
    else
        @order = Order.find(params[:id])
    end
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

  # def confirm
  #   @order = Order.find(params[:id])
  #   @order.update(confirmed: true)
  #   render json: full_order_in_json
  # end
  
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
