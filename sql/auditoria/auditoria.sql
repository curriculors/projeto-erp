USE kxp_erp;

SET @data_ref = '2026-11-05';
SET @mes_ref = '2026-10-01';

SELECT 'A01 - Colaboradores com dedicação total acima de 100% em períodos simultâneos (RN17)' AS auditoria;

SELECT col.id_colaborador,
       col.nome AS colaborador,
       r.data_referencia,
       SUM(b.percentual_dedicacao) AS dedicacao_total_pct,
       GROUP_CONCAT(b.id_alocacao ORDER BY b.id_alocacao) AS alocacoes_envolvidas
FROM (
    SELECT DISTINCT id_colaborador, data_inicio AS data_referencia
    FROM ALOCACAO
) r
JOIN ALOCACAO b ON b.id_colaborador = r.id_colaborador
               AND b.data_inicio <= r.data_referencia
               AND COALESCE(b.data_termino_real, b.data_termino_prevista) >= r.data_referencia
JOIN COLABORADOR col ON col.id_colaborador = r.id_colaborador
GROUP BY col.id_colaborador, col.nome, r.data_referencia
HAVING SUM(b.percentual_dedicacao) > 100
ORDER BY dedicacao_total_pct DESC;

SELECT 'A02 - Colaboradores com mais de 2 contratos simultâneos (RN17)' AS auditoria;

SELECT col.id_colaborador,
       col.nome AS colaborador,
       r.data_referencia,
       COUNT(DISTINCT b.id_contrato) AS contratos_simultaneos,
       GROUP_CONCAT(DISTINCT b.id_alocacao ORDER BY b.id_alocacao) AS alocacoes_envolvidas
FROM (
    SELECT DISTINCT id_colaborador, data_inicio AS data_referencia
    FROM ALOCACAO
) r
JOIN ALOCACAO b ON b.id_colaborador = r.id_colaborador
               AND b.data_inicio <= r.data_referencia
               AND COALESCE(b.data_termino_real, b.data_termino_prevista) >= r.data_referencia
JOIN COLABORADOR col ON col.id_colaborador = r.id_colaborador
GROUP BY col.id_colaborador, col.nome, r.data_referencia
HAVING COUNT(DISTINCT b.id_contrato) > 2
ORDER BY contratos_simultaneos DESC;

SELECT 'A03 - Apontamentos de horas com data futura' AS auditoria;

SELECT h.id_apontamento_de_horas,
       h.id_alocacao,
       col.nome AS colaborador,
       c.numero AS contrato,
       h.`data` AS data_apontada,
       h.quantidade_horas,
       h.status
FROM APONTAMENTO_DE_HORAS h
JOIN ALOCACAO a ON a.id_alocacao = h.id_alocacao
JOIN COLABORADOR col ON col.id_colaborador = a.id_colaborador
JOIN CONTRATO c ON c.id_contrato = a.id_contrato
WHERE h.`data` > @data_ref
ORDER BY h.`data`;

SELECT 'A04 - Apontamentos fora do período da alocação' AS auditoria;

SELECT h.id_apontamento_de_horas,
       h.id_alocacao,
       col.nome AS colaborador,
       c.numero AS contrato,
       h.`data` AS data_apontada,
       a.data_inicio,
       COALESCE(a.data_termino_real, a.data_termino_prevista) AS data_fim_alocacao
FROM APONTAMENTO_DE_HORAS h
JOIN ALOCACAO a ON a.id_alocacao = h.id_alocacao
JOIN COLABORADOR col ON col.id_colaborador = a.id_colaborador
JOIN CONTRATO c ON c.id_contrato = a.id_contrato
WHERE h.`data` < a.data_inicio
   OR h.`data` > COALESCE(a.data_termino_real, a.data_termino_prevista)
ORDER BY h.`data`;

SELECT 'A05 - Faturas com pagamentos confirmados acima do valor da fatura' AS auditoria;

SELECT f.id_fatura,
       f.numero_fatura,
       c.numero AS contrato,
       f.valor AS valor_fatura,
       p.total_confirmado,
       p.total_confirmado - f.valor AS excedente
FROM FATURA f
JOIN CONTRATO c ON c.id_contrato = f.id_contrato
JOIN (
    SELECT id_fatura, SUM(valor) AS total_confirmado
    FROM PAGAMENTO
    WHERE status = 'Confirmado'
    GROUP BY id_fatura
) p ON p.id_fatura = f.id_fatura
WHERE p.total_confirmado > f.valor
ORDER BY excedente DESC;

SELECT 'A06 - Contratos Vigentes sem referência do DocuSign' AS auditoria;

SELECT c.id_contrato,
       c.numero,
       cl.nome AS cliente,
       c.status,
       c.data_inicio
FROM CONTRATO c
JOIN CLIENTE cl ON cl.id_cliente = c.id_cliente
WHERE c.status = 'Vigente'
  AND (c.referencia_docusign IS NULL OR TRIM(c.referencia_docusign) = '')
ORDER BY c.id_contrato;

SELECT 'A07 - Aditivos Aprovados sem data de assinatura' AS auditoria;

SELECT ad.id_aditivo,
       c.numero AS contrato,
       ad.numero_aditivo,
       ad.status,
       ad.descricao
FROM ADITIVO ad
JOIN CONTRATO c ON c.id_contrato = ad.id_contrato
WHERE ad.status = 'Aprovado'
  AND ad.data_assinatura IS NULL
ORDER BY ad.id_aditivo;

SELECT 'A08 - Faturas vencidas que continuam Em aberto' AS auditoria;

SELECT f.id_fatura,
       f.numero_fatura,
       c.numero AS contrato,
       f.valor,
       f.data_vencimento,
       DATEDIFF(@data_ref, f.data_vencimento) AS dias_de_atraso,
       f.status
FROM FATURA f
JOIN CONTRATO c ON c.id_contrato = f.id_contrato
WHERE f.status = 'Em aberto'
  AND f.data_vencimento < @data_ref
ORDER BY dias_de_atraso DESC;

SELECT 'A09 - Contratos Vigentes ou em aviso prévio sem aprovação registrada' AS auditoria;

SELECT c.id_contrato,
       c.numero,
       cl.nome AS cliente,
       c.status
FROM CONTRATO c
JOIN CLIENTE cl ON cl.id_cliente = c.id_cliente
WHERE c.status IN ('Vigente', 'Aviso prévio')
  AND NOT EXISTS (
      SELECT 1
      FROM APROVACAO ap
      WHERE ap.id_contrato = c.id_contrato
        AND ap.status = 'Aprovado'
  )
ORDER BY c.id_contrato;

SELECT 'A10 - Contratos Vigentes sem evidência no mês de referência' AS auditoria;

SELECT c.id_contrato,
       c.numero,
       cl.nome AS cliente,
       @mes_ref AS mes_referencia
FROM CONTRATO c
JOIN CLIENTE cl ON cl.id_cliente = c.id_cliente
WHERE c.status = 'Vigente'
  AND c.data_inicio <= @mes_ref
  AND NOT EXISTS (
      SELECT 1
      FROM EVIDENCIA e
      WHERE e.id_contrato = c.id_contrato
        AND e.mes_referencia = @mes_ref
  )
ORDER BY c.id_contrato;

SELECT 'A11 - Clientes sem nenhum contato cadastrado' AS auditoria;

SELECT cl.id_cliente,
       cl.nome,
       cl.cnpj
FROM CLIENTE cl
WHERE NOT EXISTS (
    SELECT 1
    FROM CONTATO ct
    WHERE ct.id_cliente = cl.id_cliente
)
ORDER BY cl.id_cliente;

SELECT 'A12 - Faturas marcadas como Paga sem pagamento confirmado suficiente' AS auditoria;

SELECT f.id_fatura,
       f.numero_fatura,
       f.valor,
       COALESCE(p.total_confirmado, 0) AS total_confirmado,
       f.status
FROM FATURA f
LEFT JOIN (
    SELECT id_fatura, SUM(valor) AS total_confirmado
    FROM PAGAMENTO
    WHERE status = 'Confirmado'
    GROUP BY id_fatura
) p ON p.id_fatura = f.id_fatura
WHERE f.status = 'Paga'
  AND COALESCE(p.total_confirmado, 0) < f.valor
ORDER BY f.id_fatura;

SELECT 'A13 - Contratos cujo valor mensal difere da soma dos serviços contratados' AS auditoria;

SELECT c.id_contrato,
       c.numero,
       c.valor_mensal,
       COALESCE(s.soma_servicos, 0) AS soma_servicos,
       c.valor_mensal - COALESCE(s.soma_servicos, 0) AS diferenca
FROM CONTRATO c
LEFT JOIN (
    SELECT id_contrato, SUM(valor_contratado) AS soma_servicos
    FROM CONTRATO_SERVICO
    GROUP BY id_contrato
) s ON s.id_contrato = c.id_contrato
WHERE c.valor_mensal <> COALESCE(s.soma_servicos, 0)
ORDER BY c.id_contrato;

SELECT 'A14 - Alocações Ativas ou Planejadas de colaboradores Inativos ou em contratos encerrados' AS auditoria;

SELECT a.id_alocacao,
       col.nome AS colaborador,
       col.status AS status_colaborador,
       c.numero AS contrato,
       c.status AS status_contrato,
       a.status AS status_alocacao
FROM ALOCACAO a
JOIN COLABORADOR col ON col.id_colaborador = a.id_colaborador
JOIN CONTRATO c ON c.id_contrato = a.id_contrato
WHERE a.status IN ('Ativa', 'Planejada')
  AND (col.status = 'Inativo' OR c.status IN ('Encerrado', 'Cancelado'))
ORDER BY a.id_alocacao;
