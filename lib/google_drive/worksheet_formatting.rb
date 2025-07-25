require 'forwardable'

module GoogleDrive

  class Cell
    attr_reader :row, :col, :value

    def initialize(worksheet, row, col, value)
      @worksheet = worksheet
      @row = row
      @col = col
      @value = value
    end

    #
    # === 等価性
    #
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

  end

  module WorksheetFormatting

    def set_background_color_at(row, col, color)
      set_background_color(row, col, 1, 1, color)
    end

    def set_bold(row, col, enable = true)
      # 太字設定
    end

    # ... 他にも text_color, font_size など拡張しやすい
  end
end