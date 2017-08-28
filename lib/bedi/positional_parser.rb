module Bedi
  class PositionalParser
    attr_accessor :schemas

    def initialize(schemas)
      @schemas = schemas
    end

    def parse(file)
      lines = file.readlines
      header, *details, trailer = lines

      [
        parse_string(schemas[:header], header),
        details.map { |detail| parse_string(schemas[:detail], detail) },
        parse_string(schemas[:trailer], trailer),
      ]
    end

    private

    def parse_string(part, string)
      part.each_with_object({}) do |(field, offset), result|
        start, size = offset.values_at(:start, :size)
        result[field] = string[start, size]
      end
    end
  end
end
