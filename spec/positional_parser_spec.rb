require "spec_helper"

module Bedi
  RSpec.describe PositionalParser do
    describe '#parse' do
      let(:file) { File.open(File.join(File.dirname(__FILE__), 'fixtures/sample_file')) }

      let(:header_schema) { { foo: { start: 0, size: 9 } } }
      let(:detail_schema) { { bar: { start: 0, size: 9 } } }
      let(:trailer_schema) { { gazonk: { start: 0, size: 12 } } }
      let(:schemas) do
        { header: header_schema, detail: detail_schema, trailer: trailer_schema }
      end

      subject { described_class.new(schemas) }

      context 'when schemas are given' do
        it 'parses the header' do
          header, * = subject.parse(file)
          expect(header).to eq({ foo: 'thisisfoo' })
        end

        it 'parses the details' do
          _, details, _ = subject.parse(file)
          expect(details).to eq([ { bar: 'thisisbar' }, { bar: 'THISISBAR' } ])
        end

        it 'parses the trailer' do
          *, trailer = subject.parse(file)
          expect(trailer).to eq({ gazonk: 'thisisgazonk' })
        end
      end
    end
  end
end
