class OrdersController < ApplicationController

  def index
    @@index_columns ||= [:id, :customer, :currency, :price, :delivered, :expiration_date]
    current_page = params[:page] ? params[:page].to_i : 1
    rows_per_page = params[:rows] ? params[:rows].to_i : 10

    orders = Order.active
    orders = orders.order("#{params[:sidx]} #{params[:sord]}") if (params[:sidx] && params[:sord])
    if params[:_search] == "true"
      @@index_columns.each do |col|
        if params[col]
          if (col == :delivered)
            orders = orders.where(:delivered => true) if (['TRUE','1'].include?params[:delivered].upcase)
            orders = orders.where(:delivered => false) if (['FALSE','0'].include?params[:delivered].upcase)
          else
            orders = orders.where(col => params[col])
          end
        end
      end
    end
    @orders = orders.paginate(:page => current_page, :per_page => rows_per_page)
    total_entries = @orders.total_entries

    if request.xhr?
				render :json => @orders.to_jqgrid_json(@@index_columns, current_page, rows_per_page, total_entries)
		end
  end

  def change
    message = ""
    order_params = { :customer => params["customer"],
                     :currency => params["currency"],
                     :price => params["price"],
                     :delivered => params["delivered"],
                     :expiration_date => params["expiration_date"] }
    case params["oper"]
    when "del"
      Order.find(params["id"]).destroy
        message << t('page.orders.deleted_msg')
    when "add"
      if params["id"] == "_empty"
        order = Order.create(order_params)
        message << t('page.orders.record_added_msg') if order.errors.empty?
      else
        message << t('page.orders.add_record_error_msg')
      end
    when "edit"
      order = Order.find(params["id"])
      if order.update_attributes(order_params)
        message << t('page.orders.changed_msg')
      end
    else
      message <<  t('page.orders.unknown_action_msg')
    end
    if order && order.errors
      order.errors.entries.each do |error|
        message << "<strong>#{Order.human_attribute_name(error[0])}</strong> : #{error[1]}<br/>"
      end
    end
    render :text => "#{message}"
  end
end

