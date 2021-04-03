class DishesController < APIBaseController
  authorize_resource except: %i[index show]

  before_action :auth_user

  def index
    if current_superuser.present?
      dishes = Dish.all
    else
      dishes = Dish.where(visible: true)
    end
    if dishes.empty?
      render status: 204
    else
      render json: dishes
    end
  end

  def show
    @dish = Dish.find(params[:id])
    if @dish.errors.blank?
      render json: @dish, status: :ok
    else
      render json: @dish.errors, status: :bad_request
    end
  end

  def update
    @dish = Dish.find(params[:id])
    if params[:file_name].present?
      @dish.remove_picurl!
      @dish.save
      @redis.set('file_name', params[:file_name])
    else
      @redis.set('file_name', "picture")
    end
    @dish.update(update_dish_params)
    @dish.categories = params[:dish][:categories]
    @dish.save
    if @dish.errors.blank?
      render json: @dish, status: :ok
    else
      render json: @dish.errors, status: :bad_request
    end
  end

  def create
    @dish = Dish.new(create_dish_params)
    @dish.categories = params[:dish][:categories]
    @dish.save
    if @dish.errors.blank?
      render json: @dish, status: :ok
    else
      render json: @dish.errors, status: :bad_request
    end
  end

  def destroy
    @dish = Dish.find(params[:id])
    if @dish.errors.blank?
      @dish.delete
      @dish.remove_picture!
      @dish.save
      render status: :ok
    else
      render json: @dish.errors, status: :bad_request
    end
  end

  protected

  def default_dish_fields
    %i[name description picture price visible]
  end

  def update_dish_params
    params.required(:dish).permit(
      *default_dish_fields
    )
  end

  def create_dish_params
    params.required(:dish).permit(
      *default_dish_fields
    )
  end
end
