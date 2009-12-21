require 'RMagick'

class RoundedDivGenerator < Rails::Generator::NamedBase

  attr_accessor :radius, :name, :body_color

  def manifest
    record do |m|
      @name = file_name

      @radius = Integer(args[0] || 5)
      @body_color = args[1] || 'blue'
      @image_directory = "public/images/#{@name}"

      puts "**************************************************************************************************"
      puts ""
      puts "Generating rounded div formatting with a corner radius of #{@radius} and a color of #{@body_color}"
      puts ""
      puts "  In your view template use the following markup:"
      puts "  note: the structure of this markup must be followed for proper formatting"
      puts ""
      puts "     <div id='#{@name}'>"
      puts "       <h2> ... </h2>"
      puts "       <p>"
      puts "         ..."
      puts "       </p>"
      puts "       <p class=\"more\">"
      puts "         <a href=\"#\">...</a>"
      puts "       </p>"
      puts "    </div>"
      puts ""
      puts "Don't forget to include the generated stylesheet in your layout or view,"
      puts "use the :pullquote symbol to automatically gather all of the generated stylesheets"
      puts "instead of manually including each one (use the :cache=>true option)"
      puts ""
      puts "  <%= stylesheet_link_tag :pullquote  %>"
      puts ""

      m.directory "public/stylesheets/#{@name}"
      m.directory @image_directory
      m.template 'css_template.erb', "public/stylesheets/#{@name}/pullquote.css"

      m.generate_corner_graphics @radius, @body_color, @image_directory

    end
    

    
  end

  def banner
    "Usage: #{$0} #{spec.name} css_id_name corner_radius svg_color"
    ""
    "  note: use SVG Color Names (http://www.w3.org/TR/SVG/types.html#ColorKeywords)"
  end



end