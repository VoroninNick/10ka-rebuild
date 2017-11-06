class FormsController < ApplicationController

  def contact_request
    basic_request(ContactRequest)
  end

  def order_request
    basic_request(OrderRequest)
  end

  def basic_request(request_class)
    request_params = params.require(request_class.name.underscore.to_sym).permit(:role, :name, :phone, :email, :address, :comment)
    r = request_class.new(request_params)
    r.referer = request.referer
    r.session_id = session.id
    r.save
    r.notify_admin

    render json: {}
  end
end