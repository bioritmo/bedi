require "bedi/version"

module Bedi
  HEADER = {
    tipo_de_registro: { start: 0, size: 2 },
    data_do_deposito: { start: 2, size: 8 },
    numero_do_resumo_de_operacoes: { start: 10, size: 7 },
    reservado: { start: 17, size: 10 },
    # nao_utilizar1: { start: 27, size: 3 },
    numero_do_estabelecimento: { start: 30, size: 10 },
    codigo_da_moeda: { start: 40, size: 3 },
    indicador_do_processo: { start: 43, size: 1 },
    indicador_de_venda: { start: 44, size: 1 },
    indicacao_de_estabelecimento_especial: { start: 45, size: 1 },
    # nao_utilizar2: { start: 46, size: 204 },
  }

  DETAIL = {
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
    # nao_utilizar: { start: 128, size: 3 },
    numero_do_estabelecimento: { start: 131, size: 10 },
    reservado: { start: 141, size: 30 },
    status_da_venda: { start: 171, size: 2 },
    data_prevista_de_liquidacao: { start: 173, size: 8 },
    validade_do_cartao: { start: 181, size: 4 },
    # nao_utilizar2: { start: 185, size: 7 },
    # nao_utilizar3: { start: 192, size: 15 },
    # nao_utilizar4: { start: 207, size: 3 },
    codigo_do_erro: { start: 210, size: 4 },
    referencia: { start: 214, size: 11 },
    cartao_novo: { start: 225, size: 19 },
    vencimento_novo: { start: 244, size: 4 },
    # nao_utilizar5: { start: 248, size: 2 },
  }

  TRAILER = {
    tipo_de_registro: { start: 0, size: 2 },
    quantidade_de_registros: { start: 2, size: 7 },
    valor_total_bruto: { start: 9, size: 15 },
    valor_total_aceito: { start: 24, size: 15 },
    valor_total_liquido: { start: 39, size: 15 },
    data_prevista_de_credit: { start: 54, size: 8 },
    # nao_utilizar: { start: 62, size: 188 },
  }

  def self.parse(file)
    lines = file.readlines.map(&:chomp)
    header, *details, trailer = lines

    [
      parse_string(HEADER, header),
      details.map { |detail| parse_string(DETAIL, detail) },
      parse_string(TRAILER, trailer),
    ]
  end

  def self.parse_string(part, string)
    part.each_with_object({}) do |(field, offset), result|
      start, size = offset.values_at(:start, :size)
      result[field] = string[start, size]
    end
  end
end
