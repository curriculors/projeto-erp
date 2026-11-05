# Consultas do projeto KXP (Etapas 18 e 19)

Este documento explica cada consulta: qual pergunta de negócio ela responde (gerenciais) ou o que ela verifica (auditoria), que informação produz e que decisão apoia.

Data de referência usada em todas as consultas: `2026-11-05` (variável `@data_ref` no início de cada arquivo). Para usar a data real do computador, troque por `SET @data_ref = CURDATE();`.

Os "resultados esperados" abaixo são os da massa de dados atual (`02_dados.sql`). Se a massa mudar, os resultados mudam.

---

## Consultas gerenciais (`04_gerenciais.sql`)

### G01 — Receita mensal por cliente e contrato

- **Pergunta de negócio:** quanto cada cliente foi faturado e quanto já pagou, mês a mês?
- **Informação produzida:** faturado e recebido (só pagamentos Confirmados) por competência, cliente e contrato. Faturas Canceladas ficam de fora.
- **Decisão apoiada:** acompanhar a receita, identificar clientes que pagam menos do que são faturados e priorizar cobrança.
- **Resultado esperado:** 30 linhas. Exemplo: em 2026-10, Banco Horizonte faturado 37.000 e recebido 14.800.
- **Atenção:** contratos em USD (CT-2026-005 e CT-2025-004) aparecem com moeda própria. Não some BRL com USD.

### G02 — Margem por contrato

- **Pergunta de negócio:** cada contrato dá lucro? Quanto sobra depois do custo das horas trabalhadas?
- **Informação produzida:** faturado, horas apontadas, custo (horas × `ALOCACAO.custo_hora`), margem e margem percentual.
- **Decisão apoiada:** renegociar valores de contratos com margem baixa e saber quais contratos são mais rentáveis.
- **Resultado esperado:** 9 contratos em BRL, todos com margem acima de 87%.
- **Atenção:**
  - A margem fica alta porque os apontamentos da massa são uma amostra (4 datas por alocação), não o mês completo.
  - Contratos em USD ficam de fora porque o banco não tem tabela de cotação para converter o custo (que está em BRL).
  - Apontamentos com data futura (o de 2030) e apontamentos Cancelados não entram no custo.

### G03 — Disponibilidade de pessoas para oportunidades

- **Pergunta de negócio:** para as oportunidades que ainda não fecharam, quem tem o perfil técnico exigido e quando fica livre?
- **Informação produzida:** por oportunidade e perfil exigido, os colaboradores Ativos com esse perfil, a dedicação atual, a capacidade livre, a data em que ficam livres, a faixa (agora, 30, 60, 90 dias ou depois) e se ficam livres antes da data prevista de início.
- **Decisão apoiada:** decidir se dá para assumir a oportunidade com a equipe atual ou se é preciso contratar ou realocar.
- **Resultado esperado:** 16 linhas (oportunidades 7, 8 e 9). Exemplo: Camila Duarte (perfil DevOps) fica livre em 2026-12-31, antes do início da oportunidade 8.
- **Como a disponibilidade é calculada:** `data_livre` é a maior data de término (real, se existir, senão a prevista) entre as alocações Ativas e Planejadas do colaborador. É uma visão conservadora: quem tem 50% numa alocação que termina só em 2027 aparece com `data_livre` em 2027, mas a coluna `capacidade_livre_pct` mostra que já tem espaço hoje.

### G04 — Contratos a vencer ou em aviso prévio

- **Pergunta de negócio:** quais contratos terminam logo e até quando é preciso avisar o cliente?
- **Informação produzida:** contratos em Aviso prévio e contratos Vigentes de prazo determinado que terminam em até 90 dias, com dias restantes e o último dia para avisar (fim da vigência menos o prazo de aviso).
- **Decisão apoiada:** iniciar renovação, negociar aditivo ou planejar a saída da equipe.
- **Resultado esperado:** 2 linhas: CT-2026-001 (aviso prévio, termina em 2026-11-19) e CT-2025-001 (termina em 2027-02-01).
- **Atenção:** contratos Evergreen não têm data de fim e por isso não entram. A consulta não considera `ADITIVO.nova_vigencia`.

### G05 e G05b — Saldo em aberto e faturas em atraso

- **Pergunta de negócio:** quanto ainda temos a receber, de quem, e o que já está vencido?
- **Informação produzida:** G05 lista cada fatura com saldo (valor menos pagamentos Confirmados), dias de atraso e a situação calculada (Em aberto, Em atraso ou Parcialmente paga). G05b soma por cliente e moeda.
- **Decisão apoiada:** priorizar cobrança, avaliar risco de inadimplência e prever o caixa.
- **Resultado esperado:** G05 com 11 linhas, G05b com 8 linhas. Parcialmente pagas: FAT-2026-0006 (14.800 de 37.000) e FAT-2026-0008 (15.000 de 30.000). A fatura FAT-2026-0018 aparece como "Em atraso" calculado, mas está gravada como "Em aberto" (ver A08).
- **Regra da equipe:** "Parcialmente paga" não é gravada em `FATURA.status`; é calculada pela soma dos pagamentos Confirmados.

### G06 e G06b — Funil de oportunidades

- **Pergunta de negócio:** quantas oportunidades temos em cada estágio e quanto isso vale? Quantas viram contrato?
- **Informação produzida:** quantidade, valor estimado e percentual do valor por estágio; taxa de conversão entre ganhas e perdidas.
- **Decisão apoiada:** direcionar esforço comercial e prever receita futura.
- **Resultado esperado:** Prospecção 1 (39.000), Negociação 2 (77.000), Ganha 6 (207.000), Perdida 1 (9.000). Conversão: 85,71%.

### G07 — Certificações vencidas ou a vencer

- **Pergunta de negócio:** quais certificações dos colaboradores venceram ou vencem em até 90 dias?
- **Informação produzida:** colaborador, certificação, validade e dias para vencer. Se o colaborador já renovou a mesma certificação (registro mais novo), a antiga não aparece.
- **Decisão apoiada:** planejar renovações e evitar alocar alguém sem a certificação que o contrato exige.
- **Resultado esperado:** 5 linhas. Vencidas: Renata Costa (Inativa), Patrícia Gomes e Lucas Ferreira. A vencer: Thiago Almeida (2026-12-08) e Camila Duarte (2027-02-01).
- **Atenção:** Rafael Moreira (colaborador 1) tem uma AWS Solutions Architect vencida em 2026-03, mas renovada em 2026-03-20; por isso não aparece.

### G08 — Serviços mais contratados e receita por serviço

- **Pergunta de negócio:** quais serviços vendemos mais e quanto cada um rende por mês?
- **Informação produzida:** número de contratos ativos (Vigente ou Aviso prévio) e receita mensal contratada por serviço, separada por moeda.
- **Decisão apoiada:** decidir onde investir em equipe e treinamento e quais serviços ampliar no portfólio.
- **Resultado esperado:** 10 linhas. Em BRL, Nuvem Gerenciada aparece em 4 contratos e SRE em 3 (a maior receita: 66.000).

---

## Consultas de auditoria (`05_auditoria.sql`)

Auditoria procura dados que o banco aceitou, mas que merecem conferência. Cada consulta abaixo cobre uma regra que o `CHECK` do MySQL não consegue proteger (porque depende de outras linhas ou da data de hoje).

| Código | O que verifica | Regra | Resultado esperado na massa | O que fazer se aparecer |
|---|---|---|---|---|
| A01 | Dedicação total acima de 100% em períodos que se sobrepõem | RN17 | Pedro Henrique Lima: 120% em 2026-09-15 (alocações 9 e 24) | Reduzir uma alocação ou antecipar o fim de outra |
| A02 | Mais de 2 contratos ao mesmo tempo | RN17 | Juliana Castro: 3 contratos em 2026-09-01 (alocações 14, 25, 26) | Reavaliar a divisão da equipe |
| A03 | Apontamento com data futura | O CHECK do MySQL não aceita `CURRENT_DATE` | Apontamento 93 (alocação 1) em 2030-01-15 | Corrigir a data digitada |
| A04 | Apontamento fora do período da alocação | Hora só vale dentro da alocação | O mesmo apontamento 93 (também está fora do período) | Corrigir data ou alocação |
| A05 | Pagamentos confirmados acima do valor da fatura | Pagamento não pode exceder a fatura | FAT-2026-0023: fatura de 12.000, pagos 14.000 (excedente 2.000) | Estornar ou devolver o excedente |
| A06 | Contrato Vigente sem referência do DocuSign | Contrato vigente deve estar assinado | CT-2026-003 (contrato 6) | Obter a referência da assinatura |
| A07 | Aditivo Aprovado sem data de assinatura | Aditivo aprovado deve estar assinado | Aditivo 3 (contrato 6) | Registrar a data de assinatura |
| A08 | Fatura vencida que continua "Em aberto" | Status deveria virar "Em atraso" | FAT-2026-0018 (21 dias de atraso) | Atualizar o status e iniciar cobrança |
| A09 | Contrato Vigente ou em aviso prévio sem aprovação registrada | Todo contrato passa por aprovação | CT-2026-005 (contrato 8) | Registrar a aprovação ou suspender o contrato |
| A10 | Contrato Vigente sem evidência no mês de referência | Evidência comprova a entrega do mês | Contratos 9 e 12 em 2026-10 | Cobrar o envio da evidência |
| A11 | Cliente sem contato | Todo cliente precisa de contato | Cliente 10 (Atacadista Mercado Central) | Cadastrar um contato |
| A12 | Fatura "Paga" sem pagamento confirmado suficiente | Status coerente com os pagamentos | 0 linhas (nenhum problema) | Corrigir status ou lançar pagamento |
| A13 | Valor mensal do contrato diferente da soma dos serviços | Premissa da massa: a KXP ainda não confirmou essa regra | 0 linhas (nenhum problema) | Conferir o valor com o comercial |
| A14 | Alocação Ativa ou Planejada de colaborador Inativo ou de contrato Encerrado/Cancelado | Pessoa inativa não pode estar alocada | 0 linhas (nenhum problema) | Encerrar a alocação |

**Sobre as consultas sem resultado (A12, A13, A14):** elas servem para mostrar que o banco está consistente nesses pontos. Uma auditoria que volta vazia é um resultado válido.

**Regra que não pode ser auditada:** RN37 (quem cadastrou um contrato não pode aprová-lo). O modelo não guarda quem cadastrou, então não há como consultar.

---

## Exemplos de manipulação de dados (`03_dml.sql`)

| Código | Comando | O que mostra |
|---|---|---|
| D01, D02 | SELECT | Consulta simples e com filtro |
| D03, D04 | INNER JOIN | Contratos com clientes; equipe alocada com 4 tabelas |
| D05 | LEFT JOIN | Clientes com a contagem de contatos, incluindo quem não tem |
| D07 | INSERT | Cria um cliente e um contato (usando `LAST_INSERT_ID()`) |
| D08, D09 | UPDATE | Altera telefone; muda faturas vencidas "Em aberto" para "Em atraso" |
| D10 | DELETE | Apaga o contato e depois o cliente (ordem exigida pela FK RESTRICT) |

Tudo que altera dados roda dentro de uma transação que termina em `ROLLBACK`. Por isso a massa de dados continua igual depois da execução e as auditorias continuam achando as anomalias. O contador de ids do CLIENTE avança (o próximo cliente novo seria o 12), o que não causa problema.

---

## Testes das restrições (`06_testes_negativos.sql`)

Cada teste tenta violar uma regra de propósito. **O esperado é aparecer erro.** Se algum teste não der erro, a restrição correspondente não está funcionando.

| Teste | Tentativa | Erro esperado no MySQL |
|---|---|---|
| T01 | CNPJ repetido | 1062 Duplicate entry (`uq_cliente_cnpj`) |
| T02 | Contrato com cliente inexistente | 1452 Cannot add or update a child row |
| T03 | Apagar cliente com contratos | 1451 Cannot delete or update a parent row |
| T04 | Apagar contrato com faturas e alocações | 1451 |
| T05 | Custo por hora negativo | 3819 Check constraint `chk_colaborador_custo` |
| T06 | Dedicação de 150% | 3819 `chk_alocacao_dedicacao` |
| T07 | Término antes do início | 3819 `chk_alocacao_termino_prev` |
| T08 | Vencimento antes da emissão | 3819 `chk_fatura_vencimento` |
| T09 | Competência fora do dia 1 | 3819 `chk_fatura_competencia` |
| T10 | Pagamento de valor zero | 3819 `chk_pagamento_valor` |
| T11 | Pagamento de fatura inexistente | 1452 |
| T12 | Pagamento sem fatura | 1048 Column 'id_fatura' cannot be null |
| T13 | Aprovação com dois alvos | 3819 `chk_aprovacao_um_alvo` |
| T14 | Reprovação sem observação | 3819 `chk_aprovacao_obs` |
| T15 | Moeda inválida | 3819 `chk_contrato_moeda` |
| T16 | Vigência zero | 3819 `chk_contrato_vigencia` |
| T17 | Apontamento de 25 horas | 3819 `chk_apontamento_horas` |
| T18 | Número de aditivo repetido no contrato | 1062 (`uq_aditivo_contrato_numero`) |
| T19 | Dois usuários para o mesmo colaborador | 1062 (`uq_usuario_colaborador`) |
| T20 | Telefone inválido | 3819 `chk_contato_telefone` |
| T21 | Evidência com mês fora do dia 1 | 3819 `chk_evidencia_mes` |
| T22 | Estágio de oportunidade inválido | 3819 `chk_oportunidade_estagio` |
| P01 | **Teste positivo:** apagar uma TAG remove o vínculo em CONTRATO_TAG | Sem erro. O número de tags do contrato 1 vai de 2 para 1 (CASCADE) |

Os números dos erros do MySQL (1062, 1452, 1451, 3819, 1048) são os esperados pela documentação do MySQL 8; os nomes das restrições vieram do `01_ddl.sql`.
