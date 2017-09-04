require 'spec_helper'

module Bedi
  RSpec.describe Redecard do
    describe '#parse' do
      context 'when the file has only one batch' do
        let(:file) { fixture_file('redecard_transacao_de_credito') }

        subject { described_class.new.parse(file)[:batches].first }

        it 'parses the header fields' do
          header = subject[:header]
          expect(header).to include(
            tipo_de_registro: '00',
            codigo_da_empresa: '1234567890',
            nome_da_empresa: 'ACME INC LTDA                 ',
            numero_de_sequencia_movimento: '0001',
            data_de_gravacao: '170831',
            hora_de_gravacao: '223344',
            produto: '3',
            numero_de_sequencia_no_lote: '555',
            numero_do_lote: '77777',
            data_do_protocolo: '170831',
            data_para_o_credito: '170901',
            status_do_movimento: 'A',
            numero_de_sequencia_do_registro: '00001',
          )
        end

        it 'parses the type 01 entry fields' do
          entries01 = subject[:entry01]
          expect(entries01).to include(
            tipo_de_registro: '01',
            numero_referencia: '1234567890123',
            codigo_da_transacao: '101',
            numero_do_cartao_de_credito: '01111222233334444',
            numero_da_maquineta: '123456789',
            numero_da_autorizacao: '666666',
            numero_do_comprovante_de_venda: '12345678',
            valor_da_venda: '000000000007990',
            valor_servico: '000000000000000',
            valor_total_da_operacao: '000000000007990',
            data_da_venda: '170831',
            numero_de_parcelas: '01',
            sequencia_do_registro_no_lote: '001',
            numero_do_lote: '00001',
            valor_venda_calculado: '000000000000000',
            valor_servico_calculado: '000000000000000',
            valor_deconto_calculado: '000000000000000',
            valor_total_operacao_calculado: '000000000000000',
            data_prevista_do_credito: '000000',
            codigo_do_retorno: '99',
            numero_atual_do_cartao: ' ' * 16,
            validade_atual_do_cartao: ' ' * 4,
            validade_do_cartao: '1224',
            s_ou_n: 'S',
            reservado: ' ' * 12,
            numero_de_sequencia_do_registro: '00002',
          )
        end

        it 'parses the type 30 entry fields' do
          entries30 = subject[:entry30]
          expect(entries30).to include(
            tipo_de_registro: '30',
            numero_referencia: '9' * 13,
            codigo_da_transacao: '101',
            numero_do_rv_gerado: '12345678',
            numero_da_maquineta: '123456789',
            data_do_resumo_de_vendas: '170831',
            valor_total_de_vendas_do_lote: '000000000007990',
            valor_total_servicos: '0' * 15,
            valor_deconto_do_lote: '0' * 15,
            liquido_no_lote: '000000000007990',
            numero_de_transacoes_do_lote: '00001',
            sequencia_do_registro_no_lote: '001',
            numero_do_lote: '00001',
            valor_total_de_vendas_no_lote: '000000000007990',
            valor_total_de_gorjetas_no_lote: '0' * 15,
            valor_desconto_no_lote: '0' * 15,
            valor_total_das_transacoes_do_lote: '000000000007990',
            data_de_credito: '170901',
            numero_de_sequencia_do_registro: '00003',
          )
        end

        it 'parses the type 40 entry fields' do
          entries40 = subject[:entry40]
          expect(entries40).to include(
            tipo_de_registro: '40',
            numero_referencia: '9' * 13,
            codigo_da_transacao: '101',
            numero_da_centralizadora_de_pagamento: '123456789',
            valor_total_de_vendas_nos_lotes: '000000000007990',
            valor_total_de_servicos_nos_lotes: '0' * 15,
            valor_total_de_decontos_nos_lotes: '0' * 15,
            valor_total_das_transacoes_nos_lotes: '000000000007990',
            sequencia_do_registro_no_lote: '001',
            numero_do_lote: '00001',
            total_de_vendas_no_lote: '000000000007990',
            total_de_gorjetas_no_lote: '0' * 15,
            total_de_descontos_no_lote: '0' * 15,
            total_das_transacoes_do_lote: '000000000007990',
            data_de_credito: '170901',
            numero_de_sequencia_do_registro: '00004',
          )
        end

        it 'parses the trailer fields' do
          trailer = subject[:trailer]
          expect(trailer).to include(
            tipo_de_registro: '99',
            numero_de_referencia: '9' * 13,
            sequencia_do_registro_no_lote: '000',
            numero_do_lote: '99999',
            sequencia_do_registro_no_movimento: '00005',
          )
        end
      end

      context 'when the file has more than one batch' do
        let(:file) { fixture_file('redecard_dois_batches') }

        subject { described_class.new.parse(file)[:batches] }

        let(:first_batch) { subject.first }
        let(:second_batch) { subject.last }

        it 'separates the headers, entries and trailer' do
          expect(first_batch[:header]).not_to eq(second_batch[:header])
          expect(first_batch[:entry01]).not_to eq(second_batch[:entry01])
          expect(first_batch[:trailer]).not_to eq(second_batch[:trailer])
        end
      end

      context 'when the file has CRLF line terminators' do
        let(:file) { fixture_file('redecard_transacao_de_credito_with_crlf_terminators') }

        subject { described_class.new.parse(file) }

        it 'does not raise errors' do
          expect { subject }.not_to raise_error
        end

        it 'parses the file correctly' do
          first_batch = subject[:batches].first
          header = first_batch[:header]
          expect(header).to include(
            tipo_de_registro: '00',
            codigo_da_empresa: '1234567890',
            nome_da_empresa: 'ACME INC LTDA                 ',
            numero_de_sequencia_movimento: '0001',
            data_de_gravacao: '170831',
            hora_de_gravacao: '223344',
            produto: '3',
            numero_de_sequencia_no_lote: '555',
            numero_do_lote: '77777',
            data_do_protocolo: '170831',
            data_para_o_credito: '170901',
            status_do_movimento: 'A',
            numero_de_sequencia_do_registro: '00001',
          )
        end
      end
    end
  end
end
