module Bedi
  class Redecard
    include ParsingHelpers

    Citrus.require('redecard/parser')

    def parse(file)
      result = Parser.parse(file)

      {
        header: format(result[:Header]),
        entry01: format(result[:Entry01]),
        entry30: format(result[:Entry30]),
        entry40: format(result[:Entry40]),
        trailer: format(result[:Trailer])
      }
    end
  end
end
