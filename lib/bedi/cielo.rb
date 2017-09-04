module Bedi
  class Cielo
    include ParsingHelpers

    Citrus.require('cielo/parser')

    def parse(source)
      result = Parser.parse(source)

      formatted_batches = result[:Batch].map { |b| format_batch(b) }
      {
        batches: formatted_batches
      }
    end

    private

    def format_batch(batch)
      {
        header: format(batch[:Header]),
        entry: format(batch[:Entry]),
        trailer: format(batch[:Trailer])
      }
    end
  end
end
