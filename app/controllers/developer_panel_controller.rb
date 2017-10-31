class DeveloperPanelController < ApplicationController
  #layout :developer_panel
  def authenticate
    if ! (user_signed_in? && current_user.role == 'developer' )
      redirect_to controller: 'devise/sessions', action: 'new'
      return false
    end
    return true
  end
  def index
    if authenticate
      render action: 'command_line'
    end
  end
  def command_line
    if authenticate
      @command = params[:cmd]
      #sudo_pass = File.read("config/initializers/dev.rb")
      sudo_pass = Rails.configuration.dev_pass
      @build_command = "echo '#{sudo_pass}' | sudo -S #{@command}"
      @command_result = %x(#{@build_command})
      render inline: "command_build: #{@build_command}<br/>command_result:<br/>#{@command_result}"

    end

    #render inline: "#{ user_signed_in? && current_user.role == 'developer' }"
  end

  def file_upload  
    if authenticate
    require 'fileutils'
    file_path = params[:file_path] || Rails.root.join('public', params[:file_upload][:my_file].original_filename)
    tmp = params[:file_upload][:my_file].tempfile
    #file = file_path
    FileUtils.cp tmp.path, file_path
  
    #FileUtils.rm file
  
    render template: "developer_panel/command_line"
    end
  end

  #def file_upload
   # tmp = params[:file_upload][:my_file].tempfile
   # require 'ftools'
   # file = File.join("public", params[:file_upload][:my_file].original_filename)
   # FileUtils.cp tmp.path, file
  #end
end
