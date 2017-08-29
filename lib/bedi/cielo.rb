module Bedi
  class Cielo
    include ParsingHelpers

    Citrus.require('cielo/parser')

    def parse(file)
      result = Parser.parse(file)

      {
        header: format(result[:Header]),
        entry: format(result[:Entry]),
        trailer: format(result[:Trailer])
      }
    end
  end
end
