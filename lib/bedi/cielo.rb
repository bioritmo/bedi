module Bedi
  class Cielo
    Citrus.require('cielo/parser')

    def parse(file)
      result = Parser.parse(file)

      header = format(result[:Header].first)
      entries = result[:Entry].map { |entry| format(entry) }
      trailer = format(result[:Trailer].first)

      [header, entries, trailer]
    end

    private

    def format(match)
      match.captures.each_with_object({}) do |(key, val), result|
        next if (Numeric === key) || (key.to_s =~ /^([A-Z]|ignore|newline)/)
        result[key] = val.first
      end
    end
  end
end
