class Tools::OneOffsController < ApplicationController
  layout 'simple'

  def erb_haml
  end

  def convert_erb_haml
    args = [""]
    temp_name = "convert_temp.html"
    File.open(temp_name, 'w') do |file|
      file << params[:html_input]
    end
    output_name = 'haml_output.haml'
    command_string = "html2haml -r #{temp_name} > #{output_name}"
    cmd = `#{command_string}`
    logger.warn(command_string)
    logger.warn(cmd)
    output = File.open(output_name).read
    # Haml::Exec::HTML2Haml.new(args)
    render :update do |page|
      page.call('update_with', output)
    end
  end
end