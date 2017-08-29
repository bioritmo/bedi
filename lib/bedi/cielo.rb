module Bedi
  class Cielo
    include ParsingHelpers

    Citrus.require('cielo/parser')

    def parse(source)
      result = Parser.parse(source)

      {
        header: format(result[:Header]),
        entry: format(result[:Entry]),
        trailer: format(result[:Trailer])
      }
    end
  end
end
