USE kxp_erp;

START TRANSACTION;

SELECT 'T01 - CNPJ repetido em CLIENTE (esperado: erro de UNIQUE)' AS teste;
INSERT INTO CLIENTE (cnpj, nome) VALUES ('12.345.678/0001-90', 'Cliente Duplicado');

SELECT 'T02 - Contrato com cliente inexistente (esperado: erro de FK)' AS teste;
INSERT INTO CONTRATO (id_cliente, numero, valor_mensal, data_inicio, vigencia, tipo_renovacao, prazo_aviso_previo, moeda, status)
VALUES (999, 'CT-TESTE-001', 1000.00, '2026-11-01', 12, 'Evergreen', 30, 'BRL', 'Em aprovação');

SELECT 'T03 - Apagar cliente que possui contratos (esperado: erro de FK RESTRICT)' AS teste;
DELETE FROM CLIENTE WHERE id_cliente = 1;

SELECT 'T04 - Apagar contrato que possui faturas e alocações (esperado: erro de FK RESTRICT)' AS teste;
DELETE FROM CONTRATO WHERE id_contrato = 1;

SELECT 'T05 - Colaborador com custo por hora negativo (esperado: erro de CHECK)' AS teste;
INSERT INTO COLABORADOR (nome, funcao, senioridade, custo_hora, status)
VALUES ('Teste Custo', 'SRE', 'Pleno', -10.00, 'Ativo');

SELECT 'T06 - Alocação com dedicação de 150% (esperado: erro de CHECK)' AS teste;
INSERT INTO ALOCACAO (id_colaborador, id_contrato, funcao, data_inicio, data_termino_prevista, percentual_dedicacao, custo_hora, status)
VALUES (1, 1, 'Arquiteto de Nuvem', '2026-11-01', '2027-01-31', 150.00, 100.00, 'Ativa');

SELECT 'T07 - Alocação com término previsto antes do início (esperado: erro de CHECK)' AS teste;
INSERT INTO ALOCACAO (id_colaborador, id_contrato, funcao, data_inicio, data_termino_prevista, percentual_dedicacao, custo_hora, status)
VALUES (1, 1, 'Arquiteto de Nuvem', '2026-11-01', '2026-10-01', 10.00, 100.00, 'Ativa');

SELECT 'T08 - Fatura com vencimento antes da emissão (esperado: erro de CHECK)' AS teste;
INSERT INTO FATURA (id_contrato, numero_fatura, competencia, valor, data_emissao, data_vencimento, status)
VALUES (1, 'FAT-TESTE-001', '2026-11-01', 1000.00, '2026-11-30', '2026-11-10', 'Em aberto');

SELECT 'T09 - Fatura com competência fora do dia 1 (esperado: erro de CHECK)' AS teste;
INSERT INTO FATURA (id_contrato, numero_fatura, competencia, valor, data_emissao, data_vencimento, status)
VALUES (1, 'FAT-TESTE-002', '2026-11-15', 1000.00, '2026-11-30', '2026-12-15', 'Em aberto');

SELECT 'T10 - Pagamento com valor zero (esperado: erro de CHECK)' AS teste;
INSERT INTO PAGAMENTO (id_fatura, valor, data_pagamento, metodo_pagamento, codigo_transacao, status)
VALUES (6, 0.00, '2026-11-04', 'PIX', 'TRX-TESTE-001', 'Confirmado');

SELECT 'T11 - Pagamento de fatura inexistente (esperado: erro de FK)' AS teste;
INSERT INTO PAGAMENTO (id_fatura, valor, data_pagamento, metodo_pagamento, codigo_transacao, status)
VALUES (9999, 100.00, '2026-11-04', 'PIX', 'TRX-TESTE-002', 'Confirmado');

SELECT 'T12 - Pagamento sem fatura informada (esperado: erro de NOT NULL)' AS teste;
INSERT INTO PAGAMENTO (id_fatura, valor, data_pagamento, metodo_pagamento, codigo_transacao, status)
VALUES (NULL, 100.00, '2026-11-04', 'PIX', 'TRX-TESTE-003', 'Confirmado');

SELECT 'T13 - Aprovação com dois alvos ao mesmo tempo (esperado: erro de CHECK)' AS teste;
INSERT INTO APROVACAO (id_usuario, id_contrato, id_aditivo, id_alocacao, status, observacao, etapa)
VALUES (2, 1, 1, NULL, 'Aprovado', NULL, 'Teste');

SELECT 'T14 - Aprovação Reprovada sem observação (esperado: erro de CHECK)' AS teste;
INSERT INTO APROVACAO (id_usuario, id_contrato, id_aditivo, id_alocacao, status, observacao, etapa)
VALUES (2, 1, NULL, NULL, 'Reprovado', NULL, 'Teste');

SELECT 'T15 - Contrato com moeda inválida (esperado: erro de CHECK)' AS teste;
INSERT INTO CONTRATO (id_cliente, numero, valor_mensal, data_inicio, vigencia, tipo_renovacao, prazo_aviso_previo, moeda, status)
VALUES (1, 'CT-TESTE-002', 1000.00, '2026-11-01', 12, 'Evergreen', 30, 'EUR', 'Em aprovação');

SELECT 'T16 - Alterar a vigência de um contrato para zero (esperado: erro de CHECK)' AS teste;
UPDATE CONTRATO SET vigencia = 0 WHERE id_contrato = 1;

SELECT 'T17 - Apontamento com 25 horas em um dia (esperado: erro de CHECK)' AS teste;
INSERT INTO APONTAMENTO_DE_HORAS (id_alocacao, `data`, quantidade_horas, descricao, status)
VALUES (1, '2026-11-03', 25.00, 'Teste', 'Registrado');

SELECT 'T18 - Aditivo com número repetido no mesmo contrato (esperado: erro de UNIQUE)' AS teste;
INSERT INTO ADITIVO (id_contrato, numero_aditivo, descricao, status)
VALUES (2, 1, 'Aditivo repetido', 'Pendente');

SELECT 'T19 - Dois usuários para o mesmo colaborador (esperado: erro de UNIQUE)' AS teste;
INSERT INTO USUARIO (id_perfil_de_acesso, id_colaborador, nome_usuario, email, senha, status)
VALUES (5, 1, 'usuario.teste', 'usuario.teste@kxp.com.br', 'x', 'Ativo');

SELECT 'T20 - Contato com telefone inválido (esperado: erro de CHECK)' AS teste;
INSERT INTO CONTATO (id_cliente, nome, email, telefone)
VALUES (1, 'Contato Inválido', 'invalido@teste.com.br', 'abc123');

SELECT 'T21 - Evidência com mês de referência fora do dia 1 (esperado: erro de CHECK)' AS teste;
INSERT INTO EVIDENCIA (id_contrato, id_colaborador, mes_referencia, caminho_arquivo, nome_arquivo)
VALUES (1, 1, '2026-10-15', 'evidencias/teste.pdf', 'teste.pdf');

SELECT 'T22 - Oportunidade com estágio inválido (esperado: erro de CHECK)' AS teste;
INSERT INTO OPORTUNIDADE (id_cliente, valor_estimado, estagio_negociacao)
VALUES (1, 1000.00, 'Ativa');

SELECT 'P01 - Teste positivo: apagar uma TAG remove o vínculo em CONTRATO_TAG (CASCADE)' AS teste;
INSERT INTO TAG (nome_tag, cor, descricao, status)
VALUES ('tag-teste-cascade', '#112233', 'Tag temporária', 'Ativo');
INSERT INTO CONTRATO_TAG (id_contrato, id_tag)
VALUES (1, LAST_INSERT_ID());
SELECT COUNT(*) AS tags_do_contrato_1_com_a_tag_de_teste FROM CONTRATO_TAG WHERE id_contrato = 1;
DELETE FROM TAG WHERE nome_tag = 'tag-teste-cascade';
SELECT COUNT(*) AS tags_do_contrato_1_depois_de_apagar_a_tag FROM CONTRATO_TAG WHERE id_contrato = 1;

ROLLBACK;

SELECT 'FIM - transação desfeita, a massa de dados continua intacta' AS teste;
SELECT COUNT(*) AS clientes, (SELECT COUNT(*) FROM CONTRATO) AS contratos, (SELECT COUNT(*) FROM FATURA) AS faturas FROM CLIENTE;
