USE kxp_erp;

SET @data_ref = '2026-11-05';

SELECT 'D01 - SELECT simples: clientes em ordem alfabética' AS exemplo;

SELECT id_cliente, cnpj, nome
FROM CLIENTE
ORDER BY nome;

SELECT 'D02 - SELECT com filtro: colaboradores Sênior ativos' AS exemplo;

SELECT id_colaborador, nome, funcao, custo_hora
FROM COLABORADOR
WHERE senioridade = 'Sênior'
  AND status = 'Ativo'
ORDER BY custo_hora DESC;

SELECT 'D03 - INNER JOIN: contratos com o nome do cliente' AS exemplo;

SELECT c.numero AS contrato,
       cl.nome AS cliente,
       c.valor_mensal,
       c.moeda,
       c.status
FROM CONTRATO c
INNER JOIN CLIENTE cl ON cl.id_cliente = c.id_cliente
ORDER BY c.numero;

SELECT 'D04 - JOIN de várias tabelas: equipe com alocação ativa por contrato' AS exemplo;

SELECT c.numero AS contrato,
       cl.nome AS cliente,
       col.nome AS colaborador,
       a.funcao,
       a.percentual_dedicacao,
       a.data_termino_prevista
FROM ALOCACAO a
INNER JOIN COLABORADOR col ON col.id_colaborador = a.id_colaborador
INNER JOIN CONTRATO c ON c.id_contrato = a.id_contrato
INNER JOIN CLIENTE cl ON cl.id_cliente = c.id_cliente
WHERE a.status = 'Ativa'
ORDER BY c.numero, col.nome;

SELECT 'D05 - LEFT JOIN: clientes e quantidade de contatos (inclui quem não tem)' AS exemplo;

SELECT cl.nome AS cliente,
       COUNT(ct.id_contato) AS quantidade_de_contatos
FROM CLIENTE cl
LEFT JOIN CONTATO ct ON ct.id_cliente = cl.id_cliente
GROUP BY cl.id_cliente, cl.nome
ORDER BY quantidade_de_contatos, cl.nome;

SELECT 'D06 - Início da transação: tudo abaixo será desfeito no final' AS exemplo;

START TRANSACTION;

SELECT 'D07 - INSERT: novo cliente e novo contato' AS exemplo;

INSERT INTO CLIENTE (cnpj, nome)
VALUES ('11.222.333/0001-44', 'Cliente Teste DML Ltda');

INSERT INTO CONTATO (id_cliente, nome, email, telefone)
VALUES (LAST_INSERT_ID(), 'Contato Teste', 'contato.teste@clienteteste.com.br', '11999990000');

SELECT cl.id_cliente, cl.nome AS cliente, ct.nome AS contato, ct.telefone
FROM CLIENTE cl
INNER JOIN CONTATO ct ON ct.id_cliente = cl.id_cliente
WHERE cl.cnpj = '11.222.333/0001-44';

SELECT 'D08 - UPDATE: alterar o telefone do contato de teste' AS exemplo;

UPDATE CONTATO
SET telefone = '1133334444'
WHERE nome = 'Contato Teste';

SELECT nome, telefone
FROM CONTATO
WHERE nome = 'Contato Teste';

SELECT 'D09 - UPDATE: faturas vencidas e Em aberto passam para Em atraso (antes)' AS exemplo;

SELECT id_fatura, numero_fatura, data_vencimento, status
FROM FATURA
WHERE status = 'Em aberto'
  AND data_vencimento < @data_ref;

UPDATE FATURA
SET status = 'Em atraso'
WHERE status = 'Em aberto'
  AND data_vencimento < @data_ref;

SELECT 'D09 - depois do UPDATE' AS exemplo;

SELECT id_fatura, numero_fatura, data_vencimento, status
FROM FATURA
WHERE data_vencimento < @data_ref
  AND status IN ('Em aberto', 'Em atraso')
ORDER BY id_fatura;

SELECT 'D10 - DELETE: remover o contato e depois o cliente de teste (ordem respeita a FK)' AS exemplo;

DELETE FROM CONTATO
WHERE nome = 'Contato Teste';

DELETE FROM CLIENTE
WHERE cnpj = '11.222.333/0001-44';

SELECT COUNT(*) AS clientes_de_teste_restantes
FROM CLIENTE
WHERE cnpj = '11.222.333/0001-44';

ROLLBACK;

SELECT 'D11 - Transação desfeita: a fatura 18 voltou ao status original' AS exemplo;

SELECT id_fatura, numero_fatura, status
FROM FATURA
WHERE id_fatura = 18;
