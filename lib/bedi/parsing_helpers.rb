module Bedi
  module ParsingHelpers
    def parse_file(path)
      parse(File.open(path))
    end

    private

    def format(matches)
      matches.map { |m| remove_artifacts(m) }
    end

    def remove_artifacts(match)
      match.captures.each_with_object({}) do |(key, val), result|
        next if (Numeric === key) || (key.to_s =~ /^([A-Z]|ignore|newline)/)
        result[key] = val.first
      end
    end
  end
end
