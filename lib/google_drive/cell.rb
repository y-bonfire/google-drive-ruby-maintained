require 'forwardable'

module GoogleDrive

  class Cell
    attr_reader :row, :col, :value

    # @!attribute [r] properties
    #   @return [Hash] properties
    attr_reader :properties

    # @!attribute [rw] worksheet
    #   @return [Worksheet] worksheet
    attr_accessor :worksheet

    def initialize(worksheet, row, col, value, properties = {})
      @worksheet = worksheet
      @row = row
      @col = col
      @value = value
      @properties = properties || {}
    end

    def ==(other)
      case other
      when GoogleDrive::Cell
        @value == other.value
      else
        @value == other
      end
    end

    def to_s
      @value.to_s
    end

    def encoding
      @value.respond_to?(:encoding) ? value.encoding : nil
    end

    def background_color=(color)
      @worksheet.set_background_color(@row, @col, 1, 1, color)
    end

    def set_hyperlink_rich(text, hyperlink)
      @worksheet.set_hyperlink_rich(@row, @col, 1, 1, text, hyperlink)
    end

    def hyperlink
      @properties[:hyperlink]
    end
  end
end