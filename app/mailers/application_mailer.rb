class ApplicationMailer < ActionMailer::Base
  default from: ENV["smtp_gmail_user_name"]
  layout 'mailer'

  def receivers(name)
    config_class = "FormConfigs::#{name.classify}".constantize
    to = config_class.first.try(&:emails) || config_class.default_emails
    to
  end

  def new_contact_request(contact_request)
    new_request(contact_request)
  end

  def new_order_request(order_request)
    new_request(order_request)
  end

  def new_request(obj)
    init_host
    set_admin_root
    @request = obj
    resource_name = @request.class.name.underscore
    @email_title = I18n.t("mailer.#{resource_name}.title", raise: true) rescue resource_name.humanize
    mail to: receivers(resource_name), subject: @email_title, template_name: "basic_request"
  end

  def init_host
    @host = (ENV["#{Rails.env}.host_with_port"] || ENV["#{Rails.env}.host"])
  end

  def set_admin_root
    @admin_root = @host + "/admin"
  end
end
