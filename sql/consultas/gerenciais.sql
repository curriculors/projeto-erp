USE kxp_erp;

SET @data_ref = '2026-11-05';

SELECT 'G01 - Receita mensal por cliente e contrato' AS consulta;

SELECT DATE_FORMAT(f.competencia, '%Y-%m') AS mes_competencia,
       cl.nome AS cliente,
       c.numero AS contrato,
       c.status AS situacao_contrato,
       c.moeda,
       SUM(f.valor) AS faturado,
       SUM(COALESCE(p.pago, 0)) AS recebido
FROM FATURA f
JOIN CONTRATO c ON c.id_contrato = f.id_contrato
JOIN CLIENTE cl ON cl.id_cliente = c.id_cliente
LEFT JOIN (
    SELECT id_fatura, SUM(valor) AS pago
    FROM PAGAMENTO
    WHERE status = 'Confirmado'
    GROUP BY id_fatura
) p ON p.id_fatura = f.id_fatura
WHERE f.status <> 'Cancelada'
GROUP BY DATE_FORMAT(f.competencia, '%Y-%m'), cl.nome, c.numero, c.status, c.moeda
ORDER BY mes_competencia DESC, cliente;

SELECT 'G02 - Margem por contrato em BRL (faturado menos custo das horas apontadas)' AS consulta;

SELECT c.numero AS contrato,
       cl.nome AS cliente,
       COALESCE(rec.faturado, 0) AS faturado,
       COALESCE(cus.horas, 0) AS horas_apontadas,
       COALESCE(cus.custo, 0) AS custo_das_horas,
       COALESCE(rec.faturado, 0) - COALESCE(cus.custo, 0) AS margem,
       CASE WHEN COALESCE(rec.faturado, 0) > 0
            THEN ROUND((rec.faturado - COALESCE(cus.custo, 0)) * 100.0 / rec.faturado, 2)
       END AS margem_percentual
FROM CONTRATO c
JOIN CLIENTE cl ON cl.id_cliente = c.id_cliente
LEFT JOIN (
    SELECT id_contrato, SUM(valor) AS faturado
    FROM FATURA
    WHERE status <> 'Cancelada'
    GROUP BY id_contrato
) rec ON rec.id_contrato = c.id_contrato
LEFT JOIN (
    SELECT a.id_contrato,
           SUM(h.quantidade_horas) AS horas,
           SUM(h.quantidade_horas * a.custo_hora) AS custo
    FROM APONTAMENTO_DE_HORAS h
    JOIN ALOCACAO a ON a.id_alocacao = h.id_alocacao
    WHERE h.status <> 'Cancelado'
      AND h.`data` <= @data_ref
    GROUP BY a.id_contrato
) cus ON cus.id_contrato = c.id_contrato
WHERE c.moeda = 'BRL'
  AND c.status <> 'Em aprovação'
ORDER BY margem DESC;

SELECT 'G03 - Quem estará disponível, com o perfil técnico que cada oportunidade exige' AS consulta;

SELECT o.id_oportunidade,
       cl.nome AS cliente,
       o.estagio_negociacao,
       o.data_prevista_inicio,
       pt.nome_perfil AS perfil_exigido,
       col.id_colaborador,
       col.nome AS colaborador,
       col.senioridade,
       COALESCE(disp.dedicacao_atual, 0) AS dedicacao_atual_pct,
       CASE WHEN COALESCE(disp.dedicacao_atual, 0) >= 100 THEN 0
            ELSE 100 - COALESCE(disp.dedicacao_atual, 0)
       END AS capacidade_livre_pct,
       disp.data_livre,
       CASE WHEN disp.data_livre IS NULL THEN 'Disponível agora'
            WHEN disp.data_livre <= DATE_ADD(@data_ref, INTERVAL 30 DAY) THEN 'Livre em até 30 dias'
            WHEN disp.data_livre <= DATE_ADD(@data_ref, INTERVAL 60 DAY) THEN 'Livre em até 60 dias'
            WHEN disp.data_livre <= DATE_ADD(@data_ref, INTERVAL 90 DAY) THEN 'Livre em até 90 dias'
            ELSE 'Livre depois de 90 dias'
       END AS faixa_disponibilidade,
       CASE WHEN disp.data_livre IS NULL OR disp.data_livre < o.data_prevista_inicio THEN 'Sim'
            ELSE 'Não'
       END AS livre_antes_do_inicio
FROM OPORTUNIDADE o
JOIN CLIENTE cl ON cl.id_cliente = o.id_cliente
JOIN OPORTUNIDADE_PERFIL_TECNICO opt ON opt.id_oportunidade = o.id_oportunidade
JOIN PERFIL_TECNICO pt ON pt.id_perfil_tecnico = opt.id_perfil_tecnico
JOIN COLABORADOR_PERFIL_TECNICO cpt ON cpt.id_perfil_tecnico = pt.id_perfil_tecnico
JOIN COLABORADOR col ON col.id_colaborador = cpt.id_colaborador AND col.status = 'Ativo'
LEFT JOIN (
    SELECT id_colaborador,
           MAX(COALESCE(data_termino_real, data_termino_prevista)) AS data_livre,
           SUM(CASE WHEN status = 'Ativa' THEN percentual_dedicacao ELSE 0 END) AS dedicacao_atual
    FROM ALOCACAO
    WHERE status IN ('Ativa', 'Planejada')
    GROUP BY id_colaborador
) disp ON disp.id_colaborador = col.id_colaborador
WHERE o.estagio_negociacao IN ('Prospecção', 'Negociação')
ORDER BY o.id_oportunidade, pt.nome_perfil, disp.data_livre;

SELECT 'G04 - Contratos a vencer em até 90 dias ou em aviso prévio' AS consulta;

SELECT x.numero AS contrato,
       cl.nome AS cliente,
       x.status,
       x.tipo_renovacao,
       x.fim_vigencia,
       x.data_aviso_cancelamento,
       x.data_efetiva_termino,
       DATEDIFF(COALESCE(x.data_efetiva_termino, x.fim_vigencia), @data_ref) AS dias_para_termino,
       DATE_SUB(x.fim_vigencia, INTERVAL x.prazo_aviso_previo DAY) AS ultimo_dia_para_avisar
FROM (
    SELECT c.*, DATE_ADD(c.data_inicio, INTERVAL c.vigencia MONTH) AS fim_vigencia
    FROM CONTRATO c
) x
JOIN CLIENTE cl ON cl.id_cliente = x.id_cliente
WHERE x.status = 'Aviso prévio'
   OR (x.status = 'Vigente'
       AND x.tipo_renovacao = 'Prazo determinado'
       AND x.fim_vigencia BETWEEN @data_ref AND DATE_ADD(@data_ref, INTERVAL 90 DAY))
ORDER BY dias_para_termino;

SELECT 'G05 - Faturas com saldo em aberto, parcialmente pagas e em atraso' AS consulta;

SELECT c.numero AS contrato,
       cl.nome AS cliente,
       f.numero_fatura,
       DATE_FORMAT(f.competencia, '%Y-%m') AS mes_competencia,
       c.moeda,
       f.valor,
       COALESCE(p.pago, 0) AS pago_confirmado,
       f.valor - COALESCE(p.pago, 0) AS saldo_em_aberto,
       f.data_vencimento,
       CASE WHEN f.data_vencimento < @data_ref THEN DATEDIFF(@data_ref, f.data_vencimento) ELSE 0 END AS dias_de_atraso,
       CASE WHEN COALESCE(p.pago, 0) > 0 THEN 'Parcialmente paga'
            WHEN f.data_vencimento < @data_ref THEN 'Em atraso'
            ELSE 'Em aberto'
       END AS situacao_calculada,
       f.status AS status_gravado
FROM FATURA f
JOIN CONTRATO c ON c.id_contrato = f.id_contrato
JOIN CLIENTE cl ON cl.id_cliente = c.id_cliente
LEFT JOIN (
    SELECT id_fatura, SUM(valor) AS pago
    FROM PAGAMENTO
    WHERE status = 'Confirmado'
    GROUP BY id_fatura
) p ON p.id_fatura = f.id_fatura
WHERE f.status <> 'Cancelada'
  AND f.valor - COALESCE(p.pago, 0) > 0
ORDER BY dias_de_atraso DESC, saldo_em_aberto DESC;

SELECT 'G05b - Saldo em aberto por cliente e moeda' AS consulta;

SELECT s.cliente,
       s.moeda,
       COUNT(*) AS faturas_com_saldo,
       SUM(s.saldo) AS saldo_total,
       SUM(CASE WHEN s.vencida = 1 THEN s.saldo ELSE 0 END) AS saldo_vencido
FROM (
    SELECT cl.nome AS cliente,
           c.moeda,
           f.valor - COALESCE(p.pago, 0) AS saldo,
           CASE WHEN f.data_vencimento < @data_ref THEN 1 ELSE 0 END AS vencida
    FROM FATURA f
    JOIN CONTRATO c ON c.id_contrato = f.id_contrato
    JOIN CLIENTE cl ON cl.id_cliente = c.id_cliente
    LEFT JOIN (
        SELECT id_fatura, SUM(valor) AS pago
        FROM PAGAMENTO
        WHERE status = 'Confirmado'
        GROUP BY id_fatura
    ) p ON p.id_fatura = f.id_fatura
    WHERE f.status <> 'Cancelada'
      AND f.valor - COALESCE(p.pago, 0) > 0
) s
GROUP BY s.cliente, s.moeda
ORDER BY saldo_total DESC;

SELECT 'G06 - Funil de oportunidades por estágio' AS consulta;

SELECT o.estagio_negociacao,
       COUNT(*) AS quantidade,
       SUM(o.valor_estimado) AS valor_estimado_total,
       ROUND(SUM(o.valor_estimado) * 100.0 / t.total, 2) AS percentual_do_valor
FROM OPORTUNIDADE o
CROSS JOIN (SELECT SUM(valor_estimado) AS total FROM OPORTUNIDADE) t
GROUP BY o.estagio_negociacao, t.total
ORDER BY CASE o.estagio_negociacao
              WHEN 'Prospecção' THEN 1
              WHEN 'Negociação' THEN 2
              WHEN 'Ganha' THEN 3
              ELSE 4
         END;

SELECT 'G06b - Taxa de conversão das oportunidades encerradas' AS consulta;

SELECT SUM(CASE WHEN estagio_negociacao = 'Ganha' THEN 1 ELSE 0 END) AS ganhas,
       SUM(CASE WHEN estagio_negociacao = 'Perdida' THEN 1 ELSE 0 END) AS perdidas,
       ROUND(SUM(CASE WHEN estagio_negociacao = 'Ganha' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS taxa_de_conversao_pct
FROM OPORTUNIDADE
WHERE estagio_negociacao IN ('Ganha', 'Perdida');

SELECT 'G07 - Certificações vencidas ou que vencem em até 90 dias' AS consulta;

SELECT col.nome AS colaborador,
       col.status AS status_colaborador,
       ce.nome_certificacao,
       cc.data_obtencao,
       cc.data_validade,
       DATEDIFF(cc.data_validade, @data_ref) AS dias_para_vencer,
       CASE WHEN cc.data_validade < @data_ref THEN 'Vencida' ELSE 'Vence em até 90 dias' END AS situacao
FROM COLABORADOR_CERTIFICACAO cc
JOIN COLABORADOR col ON col.id_colaborador = cc.id_colaborador
JOIN CERTIFICACAO ce ON ce.id_certificacao = cc.id_certificacao
WHERE cc.data_validade IS NOT NULL
  AND cc.data_validade <= DATE_ADD(@data_ref, INTERVAL 90 DAY)
  AND NOT EXISTS (
      SELECT 1
      FROM COLABORADOR_CERTIFICACAO nova
      WHERE nova.id_colaborador = cc.id_colaborador
        AND nova.id_certificacao = cc.id_certificacao
        AND nova.data_obtencao > cc.data_obtencao
  )
ORDER BY cc.data_validade;

SELECT 'G08 - Serviços mais contratados e receita mensal contratada por serviço' AS consulta;

SELECT s.nome_servico,
       ct.moeda,
       COUNT(DISTINCT cs.id_contrato) AS contratos_ativos,
       SUM(cs.valor_contratado) AS receita_mensal_contratada
FROM CONTRATO_SERVICO cs
JOIN SERVICO s ON s.id_servico = cs.id_servico
JOIN CONTRATO ct ON ct.id_contrato = cs.id_contrato
WHERE ct.status IN ('Vigente', 'Aviso prévio')
GROUP BY s.nome_servico, ct.moeda
ORDER BY contratos_ativos DESC, receita_mensal_contratada DESC;
