require 'rails_generator'
require 'rails_generator/commands'
require 'RMagick'

module Canonical #:nodoc:
  module Generator #:nodoc:
    module Commands #:nodoc:
      module Create
        def generate_corner_graphics(background_color, radius, color, destination)
          radius = Integer(radius)-1
          size = radius * 2

          canvas = Magick::Image.new(size, size)   {self.background_color = background_color}
          canvas.units = Magick::PixelsPerInchResolution
          canvas.x_resolution = 300
          canvas.y_resolution = 300
          gc = Magick::Draw.new

          # Draw ellipse
          gc.fill(color)
          gc.fill_opacity 1

          gc.circle(radius-1, radius-1, radius-1, 0)
          gc.draw(canvas)

          puts "      create " + File.join(destination, 'top-left.gif')
          canvas.crop(0, 0, radius, radius).write(File.join(destination, 'top-left.gif'))

          puts "      create " + File.join(destination, 'top-right.gif')
          canvas.crop(radius, 0, radius, radius).write(File.join(destination, 'top-right.gif'))

          puts "      create " + File.join(destination, 'bot-left.gif')
          canvas.crop(0, radius, radius, radius).write(File.join(destination, 'bot-left.gif'))

          puts "      create " + File.join(destination, 'bot-right.gif')
          canvas.crop(radius, radius, radius, radius).write(File.join(destination, 'bot-right.gif'))
        end
      end

      module Destroy
        def generate_corner_graphics(background_color, radius, color, destination)
          # delete everything from destination
        end
      end

      module List
        def generate_corner_graphics(background_color, radius, color, destination)
          # list everything in destination
        end
      end

      module Update
        def generate_corner_graphics(background_color, radius, color, destination)
          # Huh?
        end
      end
    end
  end
end

Rails::Generator::Commands::Create.send   :include,  Canonical::Generator::Commands::Create
Rails::Generator::Commands::Destroy.send  :include,  Canonical::Generator::Commands::Destroy
Rails::Generator::Commands::List.send     :include,  Canonical::Generator::Commands::List
Rails::Generator::Commands::Update.send   :include,  Canonical::Generator::Command