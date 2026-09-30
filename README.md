# P r o j e t o E R P — K X P

# # 1 . I d e n t i f i c a ç ã o d a e q u i p e
# # 2 . C a r a c t e r i z a ç ã o d a e m p r e s a
# # 3 . J u s t i f i c a t i v a d a e s c o l h a
# # 4 . P r o b l e m a s i d e n t i f i c a d o s
# # 5 . P r o c e s s o s d e n e g ó c i o
# # 6 . R e q u i s i t o s f u n c i o n a i s
# # 7 . R e q u i s i t o s n ã o f u n c i o n a i s
# # 8 . R e g r a s d e n e g ó c i o
# # 9 . R e s t r i ç õ e s e p o l í t i c a s o r g a n i z a c i o n a i s
# # 1 0 . F l u x o g r a m a s
# # 1 1 . E n t i d a d e s
# # 1 2 . A t r i b u t o s
# # 1 3 . R e l a c i o n a m e n t o s
# # 1 4 . C a r d i n a l i d a d e s
# # 1 5 . D i c i o n á r i o d e d a d o s c o n c e i t u a l
# # 1 6 . D E R
# # 1 7 . J u s t i f i c a t i v a s t é c n i c a s
## 18. Conclusão

# Projeto Integrador — Modelagem de Dados 🚀
**ERP de Gestão de Contratos e Alocação — KXP Technology Consulting**

**Fase 1 — Dupla 1:** Diego + Matheus  
**Entregas:** Etapa 3 (Processos de negócio) · Etapa 5 (Requisitos funcionais) · Etapa 7 (Regras de negócio)

---

## 📌 Contexto Resumido

A **KXP** é uma consultoria de tecnologia especializada em nuvem, com 17 a 18 colaboradores, que oferece Nuvem Gerenciada, FinOps como serviço, SRE como serviço e Revisão de Arquitetura. A empresa trabalha 100% de forma remota; a equipe se reúne presencialmente só a cada três meses, aproximadamente. Os serviços são prestados nos três principais provedores de nuvem (AWS, Azure e GCP), por um time com certificações AWS, Azure, GCP, FinOps, Scrum e Datadog, trabalhando em modelo ágil, com ciclos curtos e entregas incrementais.

Entre os clientes estão Caixa, Cielo, Havan, TIM, Porto, Stone, Banco BV, Rabobank, SEBRAE-PR e a Polícia Militar do Estado de São Paulo (PMESP). Além do endereço em São Paulo, a empresa informa um endereço em Orlando (EUA).

> **Nota sobre o Kura Financials:** A KXP também possui um produto próprio, plataforma de controle de custos de nuvem vendida por assinatura (plano gratuito e plano Standard, cobrado a 2% do *billing* gerenciado por mês), usada também no serviço de FinOps. A KXP respondeu que isso está fora do escopo dessa etapa da entrevista. Neste documento, o Kura é tratado apenas como ferramenta de apoio, sem regras próprias.

Um novo contrato leva de 3 a 6 meses para ser fechado. O padrão é de 12 meses, mas existem contratos *evergreen*, renovados continuamente, e o cliente pode cancelar com aviso prévio. Os contratos ficam no DocuSign e as notas fiscais e boletos são emitidos pelo ERP Nibo. A cada contrato, a empresa monta uma equipe de colaboradores, mas **não controla o custo em horas dessa equipe nem sabe prever quando ela ficará livre**.

---

## ⚙️ ETAPA 3 — Processos de Negócio

### PN01 — Prospecção e negociação
| Pergunta | Resposta |
| :--- | :--- |
| **Quem participa?** | Comercial/Diretoria e cliente |
| **O que inicia?** | Interesse do cliente ou prospecção ativa da KXP |
| **O que acontece?** | Negociação remota de escopo, serviço e valor, que dura de 3 a 6 meses |
| **Qual informação é gerada?** | Oportunidade: cliente, serviço, valor estimado, data prevista de início, provedor de nuvem, certificações/perfis técnicos necessários e estágio da negociação |
| **Qual é o resultado?** | Oportunidade ganha (segue para PN02) ou perdida |

### PN02 — Formalização do contrato
| Pergunta | Resposta |
| :--- | :--- |
| **Quem participa?** | Comercial, Diretoria e cliente |
| **O que inicia?** | Oportunidade ganha |
| **O que acontece?** | Elaboração do contrato → aprovação interna → assinatura digital pelo DocuSign → registro das condições no sistema |
| **Qual informação é gerada?** | Contrato: número, serviço(s), valor, data de início, vigência, tipo (12 meses ou *evergreen*), prazo de aviso prévio, provedor(es) de nuvem, moeda e referência ao DocuSign |
| **Qual é o resultado?** | Contrato vigente |

### PN03 — Alocação da equipe
| Pergunta | Resposta |
| :--- | :--- |
| **Quem participa?** | Diretoria/gestor de operações e colaboradores |
| **O que inicia?** | Contrato vigente (ou oportunidade perto de fechar) |
| **O que acontece?** | Verificar quem está livre ou ficará livre e possui as certificações exigidas pelo contrato → selecionar os colaboradores → definir função, período e dedicação de cada um |
| **Qual informação é gerada?** | Alocação: colaborador, contrato, função, data de início, término previsto, dedicação e custo/hora no momento |
| **Qual é o resultado?** | Equipe formada para o contrato, com as competências necessárias |

### PN04 — Execução remota e apontamento de horas
| Pergunta | Resposta |
| :--- | :--- |
| **Quem participa?** | Colaboradores e gestor de operações |
| **O que inicia?** | Início da alocação |
| **O que acontece?** | Cada colaborador, de onde estiver, trabalha no ambiente de nuvem do cliente, em ciclos curtos, registra as horas dedicadas a cada contrato e registra as entregas incrementais de cada ciclo (relatórios mensais, relatórios de FinOps, estudos de maturidade, diagnósticos e relatório de revisão de arquitetura) |
| **Qual informação é gerada?** | Apontamentos de horas e evidências de entrega |
| **Qual é o resultado?** | Custo real do contrato conhecido e execução comprovada |

### PN05 — Faturamento e recebimento
| Pergunta | Resposta |
| :--- | :--- |
| **Quem participa?** | Administrativo-Financeiro, ERP Nibo e cliente |
| **O que inicia?** | Competência do contrato. *(Premissa: a KXP confirmou valor fixo; a periodicidade mensal mantivemos como padrão de mercado).* |
| **O que acontece?** | Gerar a fatura → enviar os dados ao Nibo → o Nibo emite a nota fiscal e o boleto → registrar o pagamento |
| **Qual informação é gerada?** | Fatura (competência, valor, moeda, vencimento, nº da NF, status) e pagamento (data, valor) |
| **Qual é o resultado?** | Fatura paga ou em atraso; margem do contrato (receita − custo real) |

### PN06 — Renovação, alteração e cancelamento de contrato
| Pergunta | Resposta |
| :--- | :--- |
| **Quem participa?** | Diretoria, Comercial e cliente |
| **O que inicia?** | Fim da vigência, pedido de alteração ou pedido de cancelamento |
| **O que acontece?** | **Contrato 12 meses:** renovar por aditivo ou encerrar. **Evergreen:** renova automaticamente. **Alteração:** registrar aditivo. **Cancelamento:** registrar o aviso prévio e calcular a data efetiva de término |
| **Qual informação é gerada?** | Aditivo, data do aviso, data efetiva de término e motivo |
| **Qual é o resultado?** | Contrato renovado, alterado, encerrado ou cancelado — e data de liberação da equipe atualizada |

### PN07 — Planejamento trimestral de capacidade
| Pergunta | Resposta |
| :--- | :--- |
| **Quem participa?** | Diretoria e equipe, na reunião presencial trimestral |
| **O que inicia?** | Reunião que acontece a cada 3 meses |
| **O que acontece?** | Revisar contratos a vencer, equipes que ficarão livres e oportunidades em negociação |
| **Qual informação é gerada?** | Relatório de capacidade e decisões de realocação |
| **Qual é o resultado?** | Plano de alocação para o próximo trimestre |
> *Premissa da dupla: A KXP não confirmou se a reunião trimestral já trata desse assunto. Propusemos aproveitar esse encontro já existente para discutir capacidade e realocação com base nos dados do sistema.*

### 🔄 Integração entre os processos
* **Fluxo Base:** PN01 Negociação (3–6 meses) → PN02 Contrato → PN03 Alocação → PN04 Horas e entregas → PN05 Faturamento (Nibo)
* **Margem do Contrato:** PN04 fornece o *custo real* e PN05 fornece a *receita* → juntos calculam a margem.
* **Ciclo de Capacidade:** PN06 Renovação / Cancelamento (define quando a equipe fica livre) → PN07 Planejamento trimestral → volta ao PN01 e ao PN03 (nova oportunidade e realocação).
> **Ponto-chave:** O PN06 alimenta o PN07 e o PN01. Saber quando cada contrato termina permite planejar a realocação antes que a equipe fique ociosa — o principal problema relatado pela KXP.

---

## 📋 ETAPA 5 — Requisitos Funcionais

| Cód. | Requisito | Processo(s) |
| :--- | :--- | :--- |
| **RF01** | O sistema deverá cadastrar clientes e seus contatos. | PN01 |
| **RF02** | O sistema deverá cadastrar os serviços oferecidos (Nuvem Gerenciada, FinOps, SRE e Revisão de Arquitetura). | PN01, PN02 |
| **RF03** | O sistema deverá registrar oportunidades em negociação, com estágio, valor estimado, data prevista de início e perfis técnicos necessários. | PN01 |
| **RF04** | O sistema deverá cadastrar contratos com número, serviço(s), valor, data de início, vigência, tipo de renovação, prazo de aviso prévio e referência ao DocuSign. | PN02 |
| **RF05** | O sistema deverá controlar o status do contrato (em aprovação, vigente, em aviso prévio, encerrado, cancelado). | PN02, PN06 |
| **RF06** | O sistema deverá registrar a aprovação de contratos, aditivos e alocações (quem aprovou, quando e a decisão). | PN02, PN03, PN06 |
| **RF07** | O sistema deverá cadastrar colaboradores com função, senioridade e custo/hora, mantendo o histórico do custo. | PN03 |
| **RF08** | O sistema deverá alocar colaboradores em contratos, informando função, data de início, término previsto e dedicação. | PN03 |
| **RF09** | O sistema deverá exibir a alocação atual e a disponibilidade futura de cada colaborador. | PN03, PN07 |
| **RF10** | O sistema deverá sinalizar colaboradores que ficarão livres nos próximos 30, 60 e 90 dias. *(Prazos não confirmados pela KXP, mas coerentes com a reunião trimestral).* | PN03, PN07 |
| **RF11** | O sistema deverá permitir que cada colaborador registre, remotamente, as horas trabalhadas em cada contrato. | PN04 |
| **RF12** | O sistema deverá registrar evidências de entrega vinculadas ao contrato e ao mês de referência. | PN04 |
| **RF13** | O sistema deverá calcular o custo real de cada contrato (horas apontadas × custo/hora). | PN04 |
| **RF14** | O sistema deverá gerar as faturas de cada contrato. | PN05 |
| **RF15** | O sistema deverá enviar os dados das faturas ao Nibo para emissão de nota fiscal e boleto. | PN05 |
| **RF16** | O sistema deverá registrar o número da nota fiscal e a situação do pagamento de cada fatura. | PN05 |
| **RF17** | O sistema deverá calcular a margem de cada contrato (receita faturada − custo real). | PN05 |
| **RF18** | O sistema deverá registrar aditivos vinculados ao contrato, mantendo o histórico das condições anteriores. | PN06 |
| **RF19** | O sistema deverá renovar automaticamente os contratos *evergreen* ao fim de cada ciclo. | PN06 |
| **RF20** | O sistema deverá alertar sobre contratos de 12 meses próximos do vencimento. | PN06 |
| **RF21** | O sistema deverá registrar cancelamentos, com data do aviso e cálculo da data efetiva de término. | PN06 |
| **RF22** | O sistema deverá atualizar o término previsto das alocações quando o contrato for cancelado ou encerrado. | PN06, PN03 |
| **RF23** | O sistema deverá gerar o relatório trimestral de capacidade (contratos a vencer, equipes que ficarão livres e oportunidades em andamento). | PN07 |
| **RF24** | O sistema deverá gerar relatórios de margem por contrato e de ociosidade dos colaboradores. | PN05, PN07 |
| **RF25** | O sistema deverá cadastrar usuários e vinculá-los a um colaborador e a um perfil de acesso. | Todos |
| **RF26** | O sistema deverá cadastrar as certificações de cada colaborador (AWS, Azure, GCP, FinOps, Scrum, Datadog etc.), com data de obtenção e de validade. | PN03 |
| **RF27** | O sistema deverá buscar colaboradores disponíveis que possuam as certificações exigidas por um contrato ou oportunidade. | PN01, PN03 |
| **RF28** | O sistema deverá registrar em qual(is) provedor(es) de nuvem (AWS, Azure, GCP) cada contrato é executado. | PN02 |
| **RF29** | O sistema deverá registrar a moeda de cada contrato e de cada fatura. *(Premissa baseada no endereço nos EUA e venda do Kura em dólar).* | PN02, PN05 |
| **RF30** | O sistema deverá alertar sobre certificações de colaboradores próximas do vencimento. | PN03 |

---

## 📏 ETAPA 7 — Regras de Negócio

> **Legenda de Fonte:**  
> **"Entrevista"** = informado pelo proprietário | **"Proposta"** = definida pela dupla a partir dos processos.  
> *A coluna "Impacto no modelo" é uma indicação para as Fases 2 e 3, não a modelagem final.*

### 7.1 Clientes e Oportunidades
| Cód. | Regra | Fonte | Impacto no modelo |
| :--- | :--- | :--- | :--- |
| **RN01** | Um cliente pode ter nenhum ou vários contratos. | Entrevista | Cliente–Contrato (0,N) |
| **RN02** | Todo contrato deve estar associado a exatamente um cliente. | Entrevista | Cliente–Contrato (1,1) |
| **RN03** | O CNPJ do cliente é obrigatório e não pode se repetir. | Proposta | Atributo único |
| **RN04** | Um cliente pode ter várias oportunidades; cada oportunidade pertence a um único cliente. | Proposta | Cliente–Oportunidade |
| **RN05** | Uma oportunidade ganha gera um contrato; uma oportunidade perdida não gera contrato. | Entrevista | Oportunidade–Contrato (0,1) |

### 7.2 Contratos
| Cód. | Regra | Fonte | Impacto no modelo |
| :--- | :--- | :--- | :--- |
| **RN06** | Todo contrato possui número único e referência ao documento assinado no DocuSign. | Entrevista | Atributos |
| **RN07** | O contrato padrão tem vigência de 12 meses. | Entrevista | Valor padrão |
| **RN08** | Um contrato pode ser de prazo determinado ou *evergreen* (renovação contínua). | Entrevista | Atributo "tipo de renovação" |
| **RN09** | Contrato *evergreen* é renovado automaticamente ao fim de cada ciclo, até ser cancelado. | Entrevista | Regra de status |
| **RN10** | O cliente pode cancelar o contrato mediante aviso prévio; a data efetiva de término é a data do aviso somada ao prazo de aviso prévio. *(Padrão de 30 dias confirmado).* | Entrevista | Atributos de cancelamento |
| **RN11** | Um contrato pode incluir um ou mais serviços, e um serviço pode estar em vários contratos, com valor próprio em cada um. *(Confirmada divisão de operações).* | Proposta | Contrato–Serviço (N:N com atributo) |
| **RN12** | Um contrato pode ter nenhum ou vários aditivos; todo aditivo pertence a um único contrato. | Proposta | Contrato–Aditivo |
| **RN13** | Um aditivo só altera as condições do contrato depois de aprovado. | Proposta | Status do aditivo |
| **RN14** | Um contrato só se torna vigente após aprovação interna e assinatura no DocuSign. | Proposta | Status + aprovação |
| **RN15** | Contrato encerrado ou cancelado não pode receber novas alocações, apontamentos de horas ou faturas. | Proposta | Restrição de status |

### 7.3 Colaboradores, Alocação e Horas
| Cód. | Regra | Fonte | Impacto no modelo |
| :--- | :--- | :--- | :--- |
| **RN16** | Todo contrato vigente deve ser atendido por uma equipe de pelo menos um colaborador. | Entrevista | Contrato–Colaborador (1,N) |
| **RN17** | Um colaborador pode estar alocado em nenhum, um ou até dois contratos ao mesmo tempo, dividindo a dedicação entre eles. | Entrevista | N:N Colaborador–Contrato |
| **RN18** | Cada alocação deve registrar função, data de início, término previsto e dedicação (horas/mês ou %); o término real é registrado quando a alocação acaba. | Proposta | Atributos do relacionamento |
| **RN19** | A dedicação total de um colaborador em alocações simultâneas não pode ultrapassar 100%, respeitando o limite de até 2 contratos. | Entrevista | Restrição |
| **RN20** | Todo colaborador deve ter um custo/hora; quando o valor muda, o anterior é mantido no histórico. | Entrevista | Histórico de custo |
| **RN21** | O colaborador só pode apontar horas em contratos nos quais está alocado e dentro do período da alocação. | Proposta | Apontamento ligado à alocação |
| **RN22** | O apontamento de horas é feito pelo próprio colaborador, remotamente. | Adendo | Apontamento–Colaborador |
| **RN23** | O custo real de um contrato é a soma das horas apontadas multiplicadas pelo custo/hora vigente na data de cada apontamento. | Entrevista | Cálculo |
| **RN24** | Um colaborador é considerado disponível a partir do término previsto da sua última alocação. | Entrevista | Cálculo |
| **RN25** | Quando um contrato é cancelado ou encerrado, o término previsto das suas alocações passa a ser a data efetiva de término do contrato. | Entrevista | Integra PN03 e PN06 |
| **RN26** | Colaborador desligado é inativado, nunca excluído, para preservar o histórico de alocações e horas. | Proposta | Status |
| **RN44** | O custo/hora do colaborador considera: salário, encargos/benefícios, provisão de desligamento, equipamentos, licenças de software, diluição da camada de gestão e fator de ociosidade de 20%. | Entrevista | Atributos do cálculo de custo/hora |

### 7.4 Evidências, Faturas e Pagamentos
| Cód. | Regra | Fonte | Impacto no modelo |
| :--- | :--- | :--- | :--- |
| **RN27** | Um contrato pode ter nenhuma ou várias evidências de entrega; cada evidência pertence a um único contrato e a um mês de referência. | Proposta | Contrato–Evidência |
| **RN28** | Toda evidência deve ser registrada por um colaborador alocado no contrato. | Proposta | Colaborador–Evidência |
| **RN29** | Um contrato vigente gera uma fatura mensal; cada fatura pertence a um único contrato. | Proposta | Contrato–Fatura |
| **RN30** | A nota fiscal e o boleto de cada fatura são emitidos pelo Nibo; o sistema guarda o número da NF e o status. | Entrevista | Atributos da fatura |
| **RN31** | Uma fatura pode receber um ou mais pagamentos; cada pagamento pertence a uma única fatura. | Proposta | Fatura–Pagamento |
| **RN32** | A soma dos pagamentos não pode ultrapassar o valor da fatura. | Proposta | Restrição |
| **RN33** | A margem do contrato é a receita faturada menos o custo real no mesmo período. | Entrevista | Cálculo |

### 7.5 Usuários e Aprovações
| Cód. | Regra | Fonte | Impacto no modelo |
| :--- | :--- | :--- | :--- |
| **RN34** | Todo usuário possui exatamente um perfil de acesso; um perfil pode ser atribuído a vários usuários. | Proposta | Perfil–Usuário |
| **RN35** | Um usuário pode estar vinculado a no máximo um colaborador, e cada colaborador ativo possui um usuário. | Adendo | Usuário–Colaborador (1,1) |
| **RN36** | Toda aprovação registra quem aprovou, data, decisão e observação. | Proposta | Atributos da aprovação |
| **RN37** | Quem cadastrou um contrato, aditivo ou alocação não pode aprová-lo. | Proposta | Restrição |

### 7.6 Certificações, Provedores e Moeda
| Cód. | Regra | Fonte | Impacto no modelo |
| :--- | :--- | :--- | :--- |
| **RN38** | Um colaborador pode ter nenhuma ou várias certificações, e uma certificação pode pertencer a vários colaboradores. | Site KXP | N:N Colaborador–Certificação |
| **RN39** | Cada certificação obtida por um colaborador registra a data de obtenção e a data de validade. | Proposta | Atributos do relacionamento |
| **RN40** | Certificação vencida não é considerada na busca de colaboradores para alocação. | Proposta | Restrição |
| **RN41** | Um contrato ou oportunidade pode exigir nenhuma ou várias certificações. | Site KXP | Contrato–Certificação (N:N) |
| **RN42** | Um contrato é executado em um ou mais provedores de nuvem (AWS, Azure, GCP), e um provedor pode estar em vários contratos. | Site KXP | Contrato–Provedor (N:N) |
| **RN43** | Todo contrato possui uma moeda, e suas faturas são emitidas na mesma moeda. | Site KXP | Atributo "moeda" |
```eof
