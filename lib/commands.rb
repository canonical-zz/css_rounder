require 'rails_generator'
require 'rails_generator/commands'

module Canonical #:nodoc:
  module Generator #:nodoc:
    module Commands #:nodoc:
      module Create
        def generate_corner_graphics(radius, color, destination)
          radius = Integer(radius)
          size = radius * 2

          canvas = Magick::Image.new(size, size)
          gc = Magick::Draw.new

          # Draw ellipse
          gc.fill(color)

          gc.circle(radius-1, radius-1, radius-1, 0)
          gc.draw(canvas)

          puts "      create " + File.join(destination, 'top-left.png')
          canvas.crop(0, 0, radius, radius).write(File.join(destination, 'top-left.png'))

          puts "      create " + File.join(destination, 'top-right.png')
          canvas.crop(radius-1, 0, radius, radius).write(File.join(destination, 'top-right.png'))

          puts "      create " + File.join(destination, 'bot-left.png')
          canvas.crop(0, radius-1, radius, radius).write(File.join(destination, 'bot-left.png'))

          puts "      create " + File.join(destination, 'bot-right.png')
          canvas.crop(radius-1, radius-1, radius, radius).write(File.join(destination, 'bot-right.png'))
        end
      end

      module Destroy
        def generate_corner_graphics(radius, color, destination)
          # delete everything from destination
        end
      end

      module List
        def generate_corner_graphics(radius, color, destination)
          # list everything in destination
        end
      end

      module Update
        def generate_corner_graphics(radius, color, destination)
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