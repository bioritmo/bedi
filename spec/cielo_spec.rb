require 'spec_helper'

module Bedi
  RSpec.describe Cielo do
    describe '#parse' do
      let(:file) { fixture_file('cielo_retorno_de_vendas') }

      subject { described_class.new.parse(file) }

      it 'parses the header fields' do
        header = subject[:header]
        expect(header).to include(
          tipo_de_registro: '00',
          data_do_deposito: '31082017',
          numero_do_resumo_de_operacoes: '0000666',
          reservado: ' ' * 10,
          numero_do_estabelecimento: '1111111111',
          codigo_da_moeda: '986',
          indicador_do_processo: 'P',
          indicador_de_venda: 'V',
          indicacao_de_estabelecimento_especial: ' ',
        )
      end

      it 'parses the details fields' do
        entries = subject[:entry]
        expect(entries).to eq(
          [
            {
              tipo_de_registro: '01',
              numero_do_comprovante_de_venda: '5555555',
              numero_do_cartao: '0001111222233334444',
              codigo_de_autorizacao: '888888',
              data_da_venda: '31082017',
              opcao_da_venda: '0',
              valor_da_venda: '000000000007990',
              quantidade_de_parcelas: '000',
              valor_financiado: '0' * 15,
              valor_entrada: '0' * 15,
              taxa_embarque: '0' * 15,
              valor_parcela: '0' * 15,
              numero_do_resumo_de_operacoes: '0000666',
              numero_do_estabelecimento: '2' * 10,
              reservado: '1234567890' * 3,
              codigo_de_retorno: '74',
              data_prevista_de_liquidacao: '05092017',
              validade_do_cartao: '2402',
              codigo_do_erro: ' ' * 4,
              referencia: ' ' * 11,
              cartao_novo: ' ' * 19,
              vencimento_novo: ' ' * 4,
            }
          ]
        )
      end

      it 'parses the trailer fields' do
        trailer = subject[:trailer]
        expect(trailer).to include(
          tipo_de_registro: '99',
          quantidade_de_registros: '0000001',
          valor_total_bruto: '000000000007990',
          valor_total_aceito: '000000000007990',
          valor_total_liquido: '000000000007990',
          data_prevista_de_credito: '05092017',
        )
      end

      context 'when the file has CRLF line terminators' do
        let(:file) { fixture_file('cielo_retorno_de_vendas_with_crlf_terminators') }

        subject { described_class.new.parse(file) }

        it 'does not raise errors' do
          expect { subject }.not_to raise_error
        end

        it 'parses the file correctly' do
          header = subject[:header]
          expect(header).to include(
            tipo_de_registro: '00',
            data_do_deposito: '31082017',
            numero_do_resumo_de_operacoes: '0000666',
            reservado: ' ' * 10,
            numero_do_estabelecimento: '1111111111',
            codigo_da_moeda: '986',
            indicador_do_processo: 'P',
            indicador_de_venda: 'V',
            indicacao_de_estabelecimento_especial: ' ',
          )
        end
      end
    end
  end
end
