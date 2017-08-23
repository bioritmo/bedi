require "spec_helper"

RSpec.describe Bedi do
  describe '.parse' do
    let(:file) { File.open(File.join(File.dirname(__FILE__), 'fixtures/cielo_retorno_de_vendas')) }

    it 'parses the header fields' do
      header, *, _ = described_class.parse(file)
      expect(header).to include(
        tipo_de_registro: '00',
        data_do_deposito: '31082017',
        numero_do_resumo_de_operacoes: '0000666',
        reservado: ' ' * 10,
        nao_utilizar1: '000',
        numero_do_estabelecimento: '1111111111',
        codigo_da_moeda: '986',
        indicador_do_processo: 'P',
        indicador_de_venda: 'V',
        indicacao_de_estabelecimento_especial: ' ',
        nao_utilizar2: ' ' * 204
      )
    end

    it 'parses the details fields' do
      _, *details, _ = described_class.parse(file)
      expect(details.first).to include(
        tipo_de_registro: '01',
        comprovante_de_venda: '5555555',
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
        nao_utilizar: '000',
        numero_do_estabelecimento: '2' * 10,
        reservado: '1234567890' * 3,
        status_da_venda: '74',
        data_prevista_de_liquidacao: '05092017',
        validade_do_cartao: '2402',
        nao_utilizar2: '0' * 7,
        nao_utilizar3: '0' * 15,
        nao_utilizar4: ' ' * 3,
        codigo_do_erro: ' ' * 4,
        referencia: ' ' * 11,
        cartao_novo: ' ' * 19,
        vencimento_novo: ' ' * 4,
        nao_utilizar5: ' ' * 2
      )
    end

    it 'parses the trailer fields' do
      _, *, trailer = described_class.parse(file)
      expect(trailer).to include(
        tipo_de_registro: '99',
        quantidade_de_registros: '0000001',
        valor_total_bruto: '000000000007990',
        valor_total_aceito: '000000000007990',
        valor_total_liquido: '000000000007990',
        data_prevista_de_credit: '05092017',
        nao_utilizar: ' ' * 188
      )
    end
  end
end
