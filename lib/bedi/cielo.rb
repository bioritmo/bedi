module Bedi
  class Cielo
    Header = {
      tipo_de_registro: { start: 0, size: 2 },
      data_do_deposito: { start: 2, size: 8 },
      numero_do_resumo_de_operacoes: { start: 10, size: 7 },
      reservado: { start: 17, size: 10 },
      numero_do_estabelecimento: { start: 30, size: 10 },
      codigo_da_moeda: { start: 40, size: 3 },
      indicador_do_processo: { start: 43, size: 1 },
      indicador_de_venda: { start: 44, size: 1 },
      indicacao_de_estabelecimento_especial: { start: 45, size: 1 },
    }.freeze

    Detail = {
      tipo_de_registro: { start: 0, size: 2 },
      comprovante_de_venda: { start: 2, size: 7 },
      numero_do_cartao: { start: 9, size: 19 },
      codigo_de_autorizacao: { start: 28, size: 6 },
      data_da_venda: { start: 34, size: 8 },
      opcao_da_venda: { start: 42, size: 1 },
      valor_da_venda: { start: 43, size: 15 },
      quantidade_de_parcelas: { start: 58, size: 3 },
      valor_financiado: { start: 61, size: 15 },
      valor_entrada: { start: 76, size: 15 },
      taxa_embarque: { start: 91, size: 15 },
      valor_parcela: { start: 106, size: 15 },
      numero_do_resumo_de_operacoes: { start: 121, size: 7 },
      numero_do_estabelecimento: { start: 131, size: 10 },
      reservado: { start: 141, size: 30 },
      status_da_venda: { start: 171, size: 2 },
      data_prevista_de_liquidacao: { start: 173, size: 8 },
      validade_do_cartao: { start: 181, size: 4 },
      codigo_do_erro: { start: 210, size: 4 },
      referencia: { start: 214, size: 11 },
      cartao_novo: { start: 225, size: 19 },
      vencimento_novo: { start: 244, size: 4 },
    }.freeze

    Trailer = {
      tipo_de_registro: { start: 0, size: 2 },
      quantidade_de_registros: { start: 2, size: 7 },
      valor_total_bruto: { start: 9, size: 15 },
      valor_total_aceito: { start: 24, size: 15 },
      valor_total_liquido: { start: 39, size: 15 },
      data_prevista_de_credit: { start: 54, size: 8 },
    }.freeze

    def self.parse(file)
      new.parse(file)
    end

    attr_accessor :parser

    def initialize(parser = default_parser)
      @parser = parser
    end

    def parse(file)
      parser.parse(file)
    end

    private

    def default_parser
      PositionalParser.new(header: Header,
                           detail: Detail,
                           trailer: Trailer)
    end
  end
end
