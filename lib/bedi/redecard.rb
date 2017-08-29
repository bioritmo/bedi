module Bedi
  class Redecard
    include ParsingHelpers

    Citrus.require('redecard/parser')

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
        entry01: format(batch[:Entry01]),
        entry30: format(batch[:Entry30]),
        entry40: format(batch[:Entry40]),
        trailer: format(batch[:Trailer])
      }
    end
  end
end
