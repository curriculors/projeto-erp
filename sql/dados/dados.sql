USE kxp_erp;

INSERT INTO CLIENTE (id_cliente, cnpj, nome) VALUES
    (1, '12.345.678/0001-90', 'Alfa Logística S.A.'),
    (2, '23.456.789/0001-01', 'Banco Horizonte S.A.'),
    (3, '34.567.890/0001-12', 'Varejo Prisma Ltda'),
    (4, '45.678.901/0001-23', 'Seguradora Aurora S.A.'),
    (5, '56.789.012/0001-34', 'Metalúrgica Orion Ltda'),
    (6, '67.890.123/0001-45', 'Rede Saúde Vida S.A.'),
    (7, '78.901.234/0001-56', 'Educa Mais Tecnologia Ltda'),
    (8, '89.012.345/0001-67', 'Fintech Pagaí Ltda'),
    (9, '90.123.456/0001-78', 'Energia Verde Brasil S.A.'),
    (10, '01.234.567/0001-89', 'Atacadista Mercado Central Ltda');

INSERT INTO SERVICO (id_servico, nome_servico, descricao, preco_base) VALUES
    (1, 'Nuvem Gerenciada', 'Operação e sustentação contínua do ambiente em nuvem do cliente', 18000.00),
    (2, 'SRE', 'Engenharia de confiabilidade de sites, com metas de disponibilidade e resposta a incidentes', 22000.00),
    (3, 'FinOps', 'Gestão e otimização de custos de nuvem', 9000.00),
    (4, 'Migração para Nuvem', 'Planejamento e execução da migração de cargas para a nuvem', 30000.00),
    (5, 'Segurança em Nuvem', 'Hardening, gestão de acessos e conformidade do ambiente em nuvem', 15000.00),
    (6, 'Observabilidade', 'Monitoramento, métricas, logs e alertas das aplicações', 12000.00);

INSERT INTO COLABORADOR (id_colaborador, nome, funcao, senioridade, custo_hora, status) VALUES
    (1, 'Rafael Moreira', 'Arquiteto de Nuvem', 'Sênior', 185.00, 'Ativo'),
    (2, 'Camila Duarte', 'Engenheira DevOps', 'Pleno', 120.00, 'Ativo'),
    (3, 'Lucas Ferreira', 'SRE', 'Sênior', 165.00, 'Ativo'),
    (4, 'Beatriz Nogueira', 'Analista FinOps', 'Pleno', 110.00, 'Ativo'),
    (5, 'Thiago Almeida', 'Especialista em Segurança', 'Sênior', 175.00, 'Ativo'),
    (6, 'Juliana Castro', 'Engenheira DevOps', 'Júnior', 75.00, 'Ativo'),
    (7, 'Pedro Henrique Lima', 'SRE', 'Pleno', 125.00, 'Ativo'),
    (8, 'Fernanda Ribeiro', 'Arquiteta de Nuvem', 'Pleno', 130.00, 'Ativo'),
    (9, 'Gustavo Barbosa', 'Engenheiro de Observabilidade', 'Pleno', 118.00, 'Ativo'),
    (10, 'Larissa Mendes', 'Analista FinOps', 'Júnior', 70.00, 'Ativo'),
    (11, 'Marcelo Tavares', 'Gerente de Projetos', 'Sênior', 150.00, 'Ativo'),
    (12, 'Patrícia Gomes', 'Engenheira DevOps', 'Sênior', 160.00, 'Ativo'),
    (13, 'André Souza', 'SRE', 'Júnior', 80.00, 'Ativo'),
    (14, 'Renata Costa', 'Arquiteta de Nuvem', 'Sênior', 180.00, 'Inativo');

INSERT INTO CERTIFICACAO (id_certificacao, nome_certificacao, provedor_nuvem, nivel) VALUES
    (1, 'AWS Solutions Architect Associate', 'AWS', 'Associate'),
    (2, 'AWS DevOps Engineer Professional', 'AWS', 'Professional'),
    (3, 'Azure Administrator Associate (AZ-104)', 'Azure', 'Associate'),
    (4, 'Azure Solutions Architect Expert', 'Azure', 'Expert'),
    (5, 'Google Professional Cloud Architect', 'GCP', 'Professional'),
    (6, 'Certified Kubernetes Administrator (CKA)', NULL, 'Professional'),
    (7, 'FinOps Certified Practitioner', NULL, 'Foundation');

INSERT INTO PERMISSAO (id_permissao, nome_permissao, modulo, status) VALUES
    (1, 'Cadastrar contrato', 'Contratos', 'Ativo'),
    (2, 'Aprovar contrato', 'Contratos', 'Ativo'),
    (3, 'Aprovar alocação', 'Alocações', 'Ativo'),
    (4, 'Registrar horas', 'Apontamentos', 'Ativo'),
    (5, 'Emitir fatura', 'Financeiro', 'Ativo'),
    (6, 'Registrar pagamento', 'Financeiro', 'Ativo'),
    (7, 'Consultar relatórios', 'Relatórios', 'Ativo'),
    (8, 'Gerenciar usuários', 'Administração', 'Ativo');

INSERT INTO PERFIL_DE_ACESSO (id_perfil_de_acesso, nome_perfil, nivel_acesso, descricao, status) VALUES
    (1, 'Administrador', 5, 'Acesso total ao ERP', 'Ativo'),
    (2, 'Gestor de Contratos', 4, 'Gerencia contratos, alocações e aprovações', 'Ativo'),
    (3, 'Financeiro', 3, 'Gerencia faturas e pagamentos', 'Ativo'),
    (4, 'Comercial', 2, 'Gerencia clientes e oportunidades', 'Ativo'),
    (5, 'Colaborador', 1, 'Registra horas e evidências', 'Ativo');

INSERT INTO PROVEDOR_DE_NUVEM (id_provedor_de_nuvem, nome_provedor, site_oficial, descricao, status) VALUES
    (1, 'AWS', 'https://aws.amazon.com', 'Amazon Web Services', 'Ativo'),
    (2, 'Azure', 'https://azure.microsoft.com', 'Microsoft Azure', 'Ativo'),
    (3, 'GCP', 'https://cloud.google.com', 'Google Cloud Platform', 'Ativo');

INSERT INTO TAG (id_tag, nome_tag, cor, descricao, status) VALUES
    (1, 'Estratégico', '#1F77B4', 'Contrato de alta importância para a KXP', 'Ativo'),
    (2, 'Missão Crítica', '#D62728', 'Ambiente que não pode ficar indisponível', 'Ativo'),
    (3, 'Regulado', '#9467BD', 'Cliente em setor regulado', 'Ativo'),
    (4, 'Multi-cloud', '#2CA02C', 'Mais de um provedor de nuvem', 'Ativo'),
    (5, 'Piloto', '#FF7F0E', 'Contrato em fase piloto', 'Ativo');

INSERT INTO PERFIL_TECNICO (id_perfil_tecnico, nome_perfil, descricao, nivel_experiencia, status) VALUES
    (1, 'Arquiteto de Nuvem', 'Desenha arquiteturas de referência em nuvem', 'Sênior', 'Ativo'),
    (2, 'Engenheiro DevOps', 'Automação de entrega, infraestrutura como código e pipelines', 'Pleno', 'Ativo'),
    (3, 'SRE', 'Confiabilidade, disponibilidade e resposta a incidentes', 'Sênior', 'Ativo'),
    (4, 'Analista FinOps', 'Análise e otimização de custos de nuvem', 'Pleno', 'Ativo'),
    (5, 'Especialista em Segurança', 'Segurança e conformidade em ambientes de nuvem', 'Sênior', 'Ativo'),
    (6, 'Engenheiro de Observabilidade', 'Monitoramento, métricas e logs', 'Pleno', 'Ativo');

INSERT INTO CONTATO (id_contato, id_cliente, nome, email, telefone) VALUES
    (1, 1, 'Mariana Lopes', 'mariana.lopes@alfalogistica.com.br', '11987654321'),
    (2, 1, 'Carlos Pinheiro', 'carlos.pinheiro@alfalogistica.com.br', '1133445566'),
    (3, 2, 'Fábio Siqueira', 'fabio.siqueira@bancohorizonte.com.br', '11988112233'),
    (4, 2, 'Helena Prado', 'helena.prado@bancohorizonte.com.br', '1132114455'),
    (5, 3, 'Roberto Vasconcelos', 'roberto.vasconcelos@varejoprisma.com.br', '11977665544'),
    (6, 4, 'Sandra Teixeira', 'sandra.teixeira@seguradoraaurora.com.br', '11966554433'),
    (7, 4, 'Eduardo Brandão', 'eduardo.brandao@seguradoraaurora.com.br', '1134567890'),
    (8, 5, 'Márcia Lacerda', 'marcia.lacerda@metalurgicaorion.com.br', '11955443322'),
    (9, 6, 'Ricardo Fonseca', 'ricardo.fonseca@redesaudevida.com.br', '11944332211'),
    (10, 6, 'Cláudia Antunes', 'claudia.antunes@redesaudevida.com.br', '1136547890'),
    (11, 7, 'Vinícius Campos', 'vinicius.campos@educamais.com.br', '11933221100'),
    (12, 8, 'Daniela Moura', 'daniela.moura@fintechpagai.com.br', '11922110099'),
    (13, 9, 'Otávio Ramalho', 'otavio.ramalho@energiaverde.com.br', '11911009988'),
    (14, 9, 'Letícia Barros', 'leticia.barros@energiaverde.com.br', NULL),
    (15, 3, 'Paulo Neves', NULL, '11900998877');

INSERT INTO OPORTUNIDADE (id_oportunidade, id_cliente, valor_estimado, data_prevista_inicio, estagio_negociacao) VALUES
    (1, 1, 27000.00, '2025-02-01', 'Ganha'),
    (2, 2, 37000.00, '2025-05-01', 'Ganha'),
    (3, 3, 30000.00, '2025-09-01', 'Ganha'),
    (4, 4, 30000.00, '2026-01-01', 'Ganha'),
    (5, 5, 49000.00, '2026-03-01', 'Ganha'),
    (6, 6, 34000.00, '2026-07-01', 'Ganha'),
    (7, 7, 33000.00, '2027-01-15', 'Negociação'),
    (8, 8, 44000.00, '2027-02-01', 'Negociação'),
    (9, 9, 39000.00, '2027-04-01', 'Prospecção'),
    (10, 3, 9000.00, '2026-08-01', 'Perdida');

INSERT INTO CONTRATO_SALARIAL (id_contrato_salarial, id_colaborador, salario, data_inicio, data_fim) VALUES
    (1, 1, 21000.00, '2023-01-01', '2025-12-31'),
    (2, 1, 23500.00, '2026-01-01', NULL),
    (3, 2, 14500.00, '2024-02-01', NULL),
    (4, 3, 19000.00, '2023-06-01', '2025-12-31'),
    (5, 3, 21000.00, '2026-01-01', NULL),
    (6, 4, 13000.00, '2025-03-01', NULL),
    (7, 5, 20000.00, '2023-09-01', '2026-02-28'),
    (8, 5, 22000.00, '2026-03-01', NULL),
    (9, 6, 8500.00, '2025-06-01', NULL),
    (10, 7, 15000.00, '2024-05-01', NULL),
    (11, 8, 16000.00, '2024-08-01', NULL),
    (12, 9, 14000.00, '2024-04-01', NULL),
    (13, 10, 8000.00, '2025-08-01', NULL),
    (14, 11, 18500.00, '2022-10-01', NULL),
    (15, 12, 19500.00, '2023-03-01', NULL),
    (16, 13, 9500.00, '2025-09-01', NULL),
    (17, 14, 21500.00, '2022-01-01', '2024-12-31');

INSERT INTO USUARIO (id_usuario, id_perfil_de_acesso, id_colaborador, nome_usuario, email, senha, status, ultimo_acesso) VALUES
    (1, 1, NULL, 'admin.kxp', 'admin@kxp.com.br', '59c3a5281936d8ef0b7b7fb9985b8be1cbc9f79beea3efa8433d338d9e876ae0', 'Ativo', '2026-11-04 08:12:00'),
    (2, 2, 11, 'marcelo.tavares', 'marcelo.tavares@kxp.com.br', '8fcb0d55f3ac4c2f0c79c2a0db398b912b32d3e0d15ab1424570e24de42204bd', 'Ativo', '2026-11-04 09:40:00'),
    (3, 3, NULL, 'financeiro.kxp', 'financeiro@kxp.com.br', '65ce0ada1c17fa2c648e1bbb33298fc5dc035de94921cfa6c15ff8e1427a1d08', 'Ativo', '2026-11-03 17:05:00'),
    (4, 4, NULL, 'comercial.kxp', 'comercial@kxp.com.br', '56a42b0c2329a9d01cb7b31d64fb94ec28b4878531675a81de6a4edb83dfc595', 'Ativo', '2026-11-02 11:30:00'),
    (5, 5, 1, 'rafael.moreira', 'rafael.moreira@kxp.com.br', '68ca36e1e72ae5bc1bf7bd224e602dbea36824c16b5d7551c9106d1733c19b9b', 'Ativo', '2026-11-04 18:20:00'),
    (6, 5, 2, 'camila.duarte', 'camila.duarte@kxp.com.br', '773114ba770951470ca4000d43012464183012cbff2005a374cd9b0393848fff', 'Ativo', '2026-11-04 17:45:00'),
    (7, 5, 3, 'lucas.ferreira', 'lucas.ferreira@kxp.com.br', 'ff5616b50d0c7eef1fc8f27c47de1958561ceefb60fc62e7abaf73e9cc7e569f', 'Ativo', '2026-11-04 16:58:00'),
    (8, 5, 4, 'beatriz.nogueira', 'beatriz.nogueira@kxp.com.br', '34fbafafd2d262a1cd119fc750a2e3746ab7b82d2e6108093ca8206951d05a76', 'Ativo', NULL);

INSERT INTO CONTRATO (id_contrato, id_cliente, id_oportunidade, numero, valor_mensal, data_inicio, vigencia, tipo_renovacao, prazo_aviso_previo, moeda, referencia_docusign, status, data_aviso_cancelamento, data_efetiva_termino) VALUES
    (1, 1, 1, 'CT-2025-001', 27000.00, '2025-02-01', 24, 'Prazo determinado', 30, 'BRL', 'DS-2025-0001', 'Vigente', NULL, NULL),
    (2, 2, 2, 'CT-2025-002', 37000.00, '2025-05-01', 24, 'Evergreen', 60, 'BRL', 'DS-2025-0002', 'Vigente', NULL, NULL),
    (3, 3, 3, 'CT-2025-003', 30000.00, '2025-09-01', 12, 'Evergreen', 30, 'BRL', 'DS-2025-0003', 'Vigente', NULL, NULL),
    (4, 4, 4, 'CT-2026-001', 30000.00, '2026-01-01', 12, 'Prazo determinado', 30, 'BRL', 'DS-2026-0001', 'Aviso prévio', '2026-10-20', '2026-11-19'),
    (5, 5, 5, 'CT-2026-002', 49000.00, '2026-03-01', 36, 'Prazo determinado', 90, 'BRL', 'DS-2026-0002', 'Vigente', NULL, NULL),
    (6, 6, 6, 'CT-2026-003', 34000.00, '2026-07-01', 12, 'Evergreen', 30, 'BRL', NULL, 'Vigente', NULL, NULL),
    (7, 3, NULL, 'CT-2026-004', 20000.00, '2026-11-16', 12, 'Evergreen', 30, 'BRL', NULL, 'Em aprovação', NULL, NULL),
    (8, 8, NULL, 'CT-2026-005', 8500.00, '2026-04-01', 12, 'Evergreen', 30, 'USD', 'DS-2026-0003', 'Vigente', NULL, NULL),
    (9, 9, NULL, 'CT-2025-004', 12000.00, '2025-08-01', 24, 'Prazo determinado', 60, 'USD', 'DS-2025-0004', 'Vigente', NULL, NULL),
    (10, 10, NULL, 'CT-2024-001', 15000.00, '2024-01-01', 12, 'Prazo determinado', 30, 'BRL', 'DS-2024-0001', 'Encerrado', NULL, NULL),
    (11, 2, NULL, 'CT-2025-005', 21000.00, '2025-11-01', 24, 'Prazo determinado', 30, 'BRL', 'DS-2025-0005', 'Cancelado', '2026-06-10', '2026-07-10'),
    (12, 1, NULL, 'CT-2026-006', 16000.00, '2026-09-01', 12, 'Evergreen', 30, 'BRL', 'DS-2026-0004', 'Vigente', NULL, NULL);

INSERT INTO ALOCACAO (id_alocacao, id_colaborador, id_contrato, funcao, data_inicio, data_termino_prevista, data_termino_real, percentual_dedicacao, custo_hora, status) VALUES
    (1, 1, 1, 'Arquiteto de Nuvem', '2025-02-01', '2027-01-31', NULL, 50.00, 175.00, 'Ativa'),
    (2, 3, 1, 'SRE', '2025-02-01', '2027-01-31', NULL, 40.00, 160.00, 'Ativa'),
    (3, 2, 2, 'Engenheira DevOps', '2025-05-01', '2026-12-31', NULL, 60.00, 115.00, 'Ativa'),
    (4, 5, 2, 'Especialista em Segurança', '2025-05-01', '2026-12-20', NULL, 50.00, 170.00, 'Ativa'),
    (5, 1, 3, 'Arquiteto de Nuvem', '2025-09-01', '2026-12-31', NULL, 50.00, 180.00, 'Ativa'),
    (6, 9, 3, 'Engenheiro de Observabilidade', '2025-09-01', '2026-11-30', NULL, 100.00, 112.00, 'Ativa'),
    (7, 8, 4, 'Arquiteta de Nuvem', '2026-01-01', '2026-11-19', NULL, 100.00, 125.00, 'Ativa'),
    (8, 4, 5, 'Analista FinOps', '2026-03-01', '2027-02-28', NULL, 50.00, 105.00, 'Ativa'),
    (9, 7, 5, 'SRE', '2026-03-01', '2027-02-28', NULL, 100.00, 120.00, 'Ativa'),
    (10, 12, 5, 'Engenheira DevOps', '2026-03-01', '2027-02-28', NULL, 60.00, 155.00, 'Ativa'),
    (11, 2, 5, 'Engenheira DevOps', '2026-03-01', '2026-12-31', NULL, 40.00, 120.00, 'Ativa'),
    (12, 3, 6, 'SRE', '2026-07-01', '2027-06-30', NULL, 60.00, 165.00, 'Ativa'),
    (13, 13, 6, 'SRE', '2026-07-11', '2027-06-30', NULL, 100.00, 78.00, 'Ativa'),
    (14, 6, 8, 'Engenheira DevOps', '2026-04-01', '2027-03-31', NULL, 70.00, 72.00, 'Ativa'),
    (15, 10, 8, 'Analista FinOps', '2026-04-01', '2027-03-31', NULL, 50.00, 68.00, 'Ativa'),
    (16, 5, 9, 'Especialista em Segurança', '2025-08-01', '2027-07-31', NULL, 50.00, 170.00, 'Ativa'),
    (17, 4, 9, 'Analista FinOps', '2025-08-01', '2027-07-31', NULL, 50.00, 102.00, 'Ativa'),
    (18, 14, 10, 'Arquiteta de Nuvem', '2024-01-01', '2024-12-31', '2024-12-31', 100.00, 170.00, 'Encerrada'),
    (19, 6, 10, 'Engenheira DevOps', '2024-03-01', '2024-12-31', '2024-12-31', 100.00, 70.00, 'Encerrada'),
    (20, 12, 11, 'Engenheira DevOps', '2025-11-01', '2027-10-31', '2026-07-10', 40.00, 150.00, 'Encerrada'),
    (21, 13, 11, 'SRE', '2025-11-01', '2027-10-31', '2026-07-10', 60.00, 75.00, 'Encerrada'),
    (22, 10, 12, 'Analista FinOps', '2026-09-01', '2027-08-31', NULL, 30.00, 68.00, 'Ativa'),
    (23, 8, 12, 'Arquiteta de Nuvem', '2026-11-20', '2027-08-31', NULL, 100.00, 130.00, 'Planejada'),
    (24, 7, 3, 'SRE', '2026-09-15', '2026-12-15', NULL, 20.00, 125.00, 'Ativa'),
    (25, 6, 2, 'Engenheira DevOps', '2026-09-01', '2026-12-31', NULL, 15.00, 75.00, 'Ativa'),
    (26, 6, 12, 'Engenheira DevOps', '2026-09-01', '2027-08-31', NULL, 15.00, 75.00, 'Ativa');

INSERT INTO APONTAMENTO_DE_HORAS (id_apontamento_de_horas, id_alocacao, `data`, quantidade_horas, descricao, status) VALUES
    (1, 1, '2026-09-16', 4.00, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (2, 1, '2026-09-30', 4.00, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (3, 1, '2026-10-14', 4.00, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (4, 1, '2026-10-28', 4.00, 'Análise de custos e recomendações de economia', 'Registrado'),
    (5, 2, '2026-09-16', 3.20, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (6, 2, '2026-09-30', 3.20, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (7, 2, '2026-10-14', 3.20, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (8, 2, '2026-10-28', 3.20, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (9, 3, '2026-09-16', 4.80, 'Análise de custos e recomendações de economia', 'Registrado'),
    (10, 3, '2026-09-30', 4.80, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (11, 3, '2026-10-14', 4.80, 'Horas corrigidas após revisão do gestor', 'Ajustado'),
    (12, 3, '2026-10-28', 4.80, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (13, 4, '2026-09-16', 4.00, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (14, 4, '2026-09-30', 4.00, 'Análise de custos e recomendações de economia', 'Registrado'),
    (15, 4, '2026-10-14', 4.00, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (16, 4, '2026-10-28', 4.00, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (17, 5, '2026-09-16', 4.00, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (18, 5, '2026-09-30', 4.00, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (19, 5, '2026-10-14', 4.00, 'Análise de custos e recomendações de economia', 'Registrado'),
    (20, 5, '2026-10-28', 4.00, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (21, 6, '2026-09-16', 8.00, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (22, 6, '2026-09-30', 8.00, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (23, 6, '2026-10-14', 8.00, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (24, 6, '2026-10-28', 8.00, 'Análise de custos e recomendações de economia', 'Registrado'),
    (25, 7, '2026-09-16', 8.00, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (26, 7, '2026-09-30', 8.00, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (27, 7, '2026-10-14', 8.00, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (28, 7, '2026-10-28', 8.00, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (29, 8, '2026-09-16', 4.00, 'Análise de custos e recomendações de economia', 'Registrado'),
    (30, 8, '2026-09-30', 4.00, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (31, 8, '2026-10-14', 4.00, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (32, 8, '2026-10-28', 4.00, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (33, 9, '2026-09-16', 8.00, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (34, 9, '2026-09-30', 8.00, 'Análise de custos e recomendações de economia', 'Registrado'),
    (35, 9, '2026-10-14', 8.00, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (36, 9, '2026-10-28', 8.00, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (37, 10, '2026-09-16', 4.80, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (38, 10, '2026-09-30', 4.80, 'Horas corrigidas após revisão do gestor', 'Ajustado'),
    (39, 10, '2026-10-14', 4.80, 'Análise de custos e recomendações de economia', 'Registrado'),
    (40, 10, '2026-10-28', 4.80, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (41, 11, '2026-09-16', 3.20, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (42, 11, '2026-09-30', 3.20, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (43, 11, '2026-10-14', 3.20, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (44, 11, '2026-10-28', 3.20, 'Análise de custos e recomendações de economia', 'Registrado'),
    (45, 12, '2026-09-16', 4.80, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (46, 12, '2026-09-30', 4.80, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (47, 12, '2026-10-14', 4.80, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (48, 12, '2026-10-28', 4.80, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (49, 13, '2026-09-16', 8.00, 'Análise de custos e recomendações de economia', 'Registrado'),
    (50, 13, '2026-09-30', 8.00, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (51, 13, '2026-10-14', 8.00, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (52, 13, '2026-10-28', 8.00, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (53, 14, '2026-09-16', 5.60, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (54, 14, '2026-09-30', 5.60, 'Análise de custos e recomendações de economia', 'Registrado'),
    (55, 14, '2026-10-14', 5.60, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (56, 14, '2026-10-28', 5.60, 'Lançamento duplicado cancelado', 'Cancelado'),
    (57, 15, '2026-09-16', 4.00, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (58, 15, '2026-09-30', 4.00, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (59, 15, '2026-10-14', 4.00, 'Análise de custos e recomendações de economia', 'Registrado'),
    (60, 15, '2026-10-28', 4.00, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (61, 16, '2026-09-16', 4.00, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (62, 16, '2026-09-30', 4.00, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (63, 16, '2026-10-14', 4.00, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (64, 16, '2026-10-28', 4.00, 'Análise de custos e recomendações de economia', 'Registrado'),
    (65, 17, '2026-09-16', 4.00, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (66, 17, '2026-09-30', 4.00, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (67, 17, '2026-10-14', 4.00, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (68, 17, '2026-10-28', 4.00, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (69, 18, '2024-06-14', 8.00, 'Análise de custos e recomendações de economia', 'Registrado'),
    (70, 18, '2024-10-15', 8.00, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (71, 19, '2024-06-14', 8.00, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (72, 19, '2024-10-15', 8.00, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (73, 20, '2026-05-13', 3.20, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (74, 20, '2026-06-17', 3.20, 'Análise de custos e recomendações de economia', 'Registrado'),
    (75, 21, '2026-05-13', 4.80, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (76, 21, '2026-06-17', 4.80, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (77, 22, '2026-09-16', 2.40, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (78, 22, '2026-09-30', 2.40, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (79, 22, '2026-10-14', 2.40, 'Análise de custos e recomendações de economia', 'Registrado'),
    (80, 22, '2026-10-28', 2.40, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (81, 24, '2026-09-16', 1.60, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (82, 24, '2026-09-30', 1.60, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (83, 24, '2026-10-14', 1.60, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (84, 24, '2026-10-28', 1.60, 'Análise de custos e recomendações de economia', 'Registrado'),
    (85, 25, '2026-09-16', 1.20, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (86, 25, '2026-09-30', 1.20, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (87, 25, '2026-10-14', 1.20, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (88, 25, '2026-10-28', 1.20, 'Acompanhamento de métricas e alertas', 'Registrado'),
    (89, 26, '2026-09-16', 1.20, 'Análise de custos e recomendações de economia', 'Registrado'),
    (90, 26, '2026-09-30', 1.20, 'Sustentação do ambiente e tratamento de chamados', 'Registrado'),
    (91, 26, '2026-10-14', 1.20, 'Melhorias de automação e infraestrutura como código', 'Registrado'),
    (92, 26, '2026-10-28', 1.20, 'Revisão de arquitetura e boas práticas', 'Registrado'),
    (93, 1, '2030-01-15', 4.00, 'Lançamento com data incorreta', 'Registrado');

INSERT INTO EVIDENCIA (id_evidencia, id_contrato, id_colaborador, mes_referencia, caminho_arquivo, nome_arquivo, tipo_arquivo, data_upload, descricao) VALUES
    (1, 1, 1, '2026-09-01', 'evidencias/2026-09/ct-2025-001_2026-09_colab1.pdf', 'ct-2025-001_2026-09_colab1.pdf', 'pdf', '2026-10-04 10:00:00', 'Relatório mensal de entregas do contrato'),
    (2, 1, 3, '2026-10-01', 'evidencias/2026-10/ct-2025-001_2026-10_colab3.pdf', 'ct-2025-001_2026-10_colab3.pdf', 'pdf', '2026-11-03 10:00:00', 'Relatório mensal de entregas do contrato'),
    (3, 2, 2, '2026-09-01', 'evidencias/2026-09/ct-2025-002_2026-09_colab2.pdf', 'ct-2025-002_2026-09_colab2.pdf', 'pdf', '2026-10-04 10:00:00', 'Relatório mensal de entregas do contrato'),
    (4, 2, 5, '2026-10-01', 'evidencias/2026-10/ct-2025-002_2026-10_colab5.pdf', 'ct-2025-002_2026-10_colab5.pdf', 'pdf', '2026-11-03 10:00:00', 'Relatório mensal de entregas do contrato'),
    (5, 3, 9, '2026-10-01', 'evidencias/2026-10/ct-2025-003_2026-10_colab9.pdf', 'ct-2025-003_2026-10_colab9.pdf', 'pdf', '2026-11-03 10:00:00', 'Relatório mensal de entregas do contrato'),
    (6, 5, 4, '2026-10-01', 'evidencias/2026-10/ct-2026-002_2026-10_colab4.pdf', 'ct-2026-002_2026-10_colab4.pdf', 'pdf', '2026-11-03 10:00:00', 'Relatório mensal de entregas do contrato'),
    (7, 5, 7, '2026-10-01', 'evidencias/2026-10/ct-2026-002_2026-10_colab7.pdf', 'ct-2026-002_2026-10_colab7.pdf', 'pdf', '2026-11-03 10:00:00', 'Relatório mensal de entregas do contrato'),
    (8, 6, 13, '2026-10-01', 'evidencias/2026-10/ct-2026-003_2026-10_colab13.pdf', 'ct-2026-003_2026-10_colab13.pdf', 'pdf', '2026-11-03 10:00:00', 'Relatório mensal de entregas do contrato'),
    (9, 8, 6, '2026-10-01', 'evidencias/2026-10/ct-2026-005_2026-10_colab6.pdf', 'ct-2026-005_2026-10_colab6.pdf', 'pdf', '2026-11-03 10:00:00', 'Relatório mensal de entregas do contrato'),
    (10, 9, 5, '2026-09-01', 'evidencias/2026-09/ct-2025-004_2026-09_colab5.pdf', 'ct-2025-004_2026-09_colab5.pdf', 'pdf', '2026-10-04 10:00:00', 'Relatório mensal de entregas do contrato');

INSERT INTO ADITIVO (id_aditivo, id_contrato, numero_aditivo, data_assinatura, descricao, impacto_financeiro, nova_vigencia, status) VALUES
    (1, 2, 1, '2026-04-20', 'Prorrogação da vigência por mais 12 meses, mantidas as demais condições', 0.00, 24, 'Aprovado'),
    (2, 5, 1, NULL, 'Inclusão de um SRE adicional na equipe do contrato', 8000.00, NULL, 'Pendente'),
    (3, 6, 1, NULL, 'Inclusão do serviço de Segurança em Nuvem no escopo', 11000.00, NULL, 'Aprovado'),
    (4, 9, 1, '2026-03-02', 'Troca do provedor principal de nuvem de AWS para Azure', 0.00, NULL, 'Aprovado'),
    (5, 3, 1, NULL, 'Inclusão do provedor GCP no escopo multi-cloud', 0.00, NULL, 'Rejeitado');

INSERT INTO FATURA (id_fatura, id_contrato, numero_fatura, competencia, valor, data_emissao, data_vencimento, status) VALUES
    (1, 1, 'FAT-2026-0001', '2026-08-01', 27000.00, '2026-08-31', '2026-09-15', 'Paga'),
    (2, 1, 'FAT-2026-0002', '2026-09-01', 27000.00, '2026-09-30', '2026-10-15', 'Paga'),
    (3, 1, 'FAT-2026-0003', '2026-10-01', 27000.00, '2026-10-31', '2026-11-15', 'Paga'),
    (4, 2, 'FAT-2026-0004', '2026-08-01', 37000.00, '2026-08-31', '2026-09-15', 'Paga'),
    (5, 2, 'FAT-2026-0005', '2026-09-01', 37000.00, '2026-09-30', '2026-10-15', 'Paga'),
    (6, 2, 'FAT-2026-0006', '2026-10-01', 37000.00, '2026-10-31', '2026-11-15', 'Em aberto'),
    (7, 3, 'FAT-2026-0007', '2026-08-01', 30000.00, '2026-08-31', '2026-09-15', 'Paga'),
    (8, 3, 'FAT-2026-0008', '2026-09-01', 30000.00, '2026-09-30', '2026-10-15', 'Em atraso'),
    (9, 3, 'FAT-2026-0009', '2026-10-01', 30000.00, '2026-10-31', '2026-11-15', 'Em aberto'),
    (10, 4, 'FAT-2026-0010', '2026-08-01', 30000.00, '2026-08-31', '2026-09-15', 'Paga'),
    (11, 4, 'FAT-2026-0011', '2026-09-01', 30000.00, '2026-09-30', '2026-10-15', 'Paga'),
    (12, 4, 'FAT-2026-0012', '2026-10-01', 30000.00, '2026-10-31', '2026-11-15', 'Em aberto'),
    (13, 5, 'FAT-2026-0013', '2026-08-01', 49000.00, '2026-08-31', '2026-09-15', 'Paga'),
    (14, 5, 'FAT-2026-0014', '2026-09-01', 49000.00, '2026-09-30', '2026-10-15', 'Em atraso'),
    (15, 5, 'FAT-2026-0015', '2026-10-01', 49000.00, '2026-10-31', '2026-11-15', 'Em aberto'),
    (16, 6, 'FAT-2026-0016', '2026-07-01', 34000.00, '2026-07-31', '2026-08-15', 'Paga'),
    (17, 6, 'FAT-2026-0017', '2026-08-01', 34000.00, '2026-08-31', '2026-09-15', 'Paga'),
    (18, 6, 'FAT-2026-0018', '2026-09-01', 34000.00, '2026-09-30', '2026-10-15', 'Em aberto'),
    (19, 6, 'FAT-2026-0019', '2026-10-01', 34000.00, '2026-10-31', '2026-11-15', 'Em aberto'),
    (20, 8, 'FAT-2026-0020', '2026-08-01', 8500.00, '2026-08-31', '2026-09-15', 'Paga'),
    (21, 8, 'FAT-2026-0021', '2026-09-01', 8500.00, '2026-09-30', '2026-10-15', 'Paga'),
    (22, 8, 'FAT-2026-0022', '2026-10-01', 8500.00, '2026-10-31', '2026-11-15', 'Em aberto'),
    (23, 9, 'FAT-2026-0023', '2026-08-01', 12000.00, '2026-08-31', '2026-09-15', 'Paga'),
    (24, 9, 'FAT-2026-0024', '2026-09-01', 12000.00, '2026-09-30', '2026-10-15', 'Paga'),
    (25, 9, 'FAT-2026-0025', '2026-10-01', 12000.00, '2026-10-31', '2026-11-15', 'Em aberto'),
    (26, 10, 'FAT-2024-0026', '2024-11-01', 15000.00, '2024-11-30', '2024-12-15', 'Paga'),
    (27, 10, 'FAT-2024-0027', '2024-12-01', 15000.00, '2024-12-31', '2025-01-15', 'Paga'),
    (28, 11, 'FAT-2026-0028', '2026-05-01', 21000.00, '2026-05-31', '2026-06-15', 'Paga'),
    (29, 11, 'FAT-2026-0029', '2026-06-01', 21000.00, '2026-06-30', '2026-07-15', 'Cancelada'),
    (30, 12, 'FAT-2026-0030', '2026-09-01', 16000.00, '2026-09-30', '2026-10-15', 'Paga'),
    (31, 12, 'FAT-2026-0031', '2026-10-01', 16000.00, '2026-10-31', '2026-11-15', 'Em aberto');

INSERT INTO PAGAMENTO (id_pagamento, id_fatura, valor, data_pagamento, metodo_pagamento, codigo_transacao, status) VALUES
    (1, 1, 27000.00, '2026-09-12', 'PIX', 'TRX-100001', 'Confirmado'),
    (2, 2, 27000.00, '2026-10-12', 'Transferência', 'TRX-100002', 'Confirmado'),
    (3, 3, 27000.00, '2026-11-03', 'Boleto', NULL, 'Confirmado'),
    (4, 4, 37000.00, '2026-09-12', 'PIX', 'TRX-100004', 'Confirmado'),
    (5, 5, 37000.00, '2026-10-12', 'Transferência', 'TRX-100005', 'Confirmado'),
    (6, 6, 14800.00, '2026-11-02', 'Boleto', NULL, 'Confirmado'),
    (7, 7, 30000.00, '2026-09-12', 'PIX', 'TRX-100007', 'Confirmado'),
    (8, 8, 15000.00, '2026-10-10', 'Transferência', 'TRX-100008', 'Confirmado'),
    (9, 10, 30000.00, '2026-09-12', 'Boleto', NULL, 'Confirmado'),
    (10, 11, 30000.00, '2026-10-12', 'PIX', 'TRX-100010', 'Confirmado'),
    (11, 13, 49000.00, '2026-09-12', 'Transferência', 'TRX-100011', 'Confirmado'),
    (12, 16, 34000.00, '2026-08-12', 'Boleto', NULL, 'Confirmado'),
    (13, 17, 34000.00, '2026-09-12', 'PIX', 'TRX-100013', 'Confirmado'),
    (14, 20, 8500.00, '2026-09-12', 'Transferência', 'TRX-100014', 'Confirmado'),
    (15, 21, 8500.00, '2026-10-02', 'Transferência', 'TRX-100015', 'Estornado'),
    (16, 21, 8500.00, '2026-10-09', 'Transferência', 'TRX-100016', 'Confirmado'),
    (17, 23, 12000.00, '2026-09-12', 'Transferência', 'TRX-100017', 'Confirmado'),
    (18, 23, 2000.00, '2026-09-14', 'Transferência', 'TRX-100018', 'Confirmado'),
    (19, 24, 12000.00, '2026-10-12', 'PIX', 'TRX-100019', 'Confirmado'),
    (20, 26, 15000.00, '2024-12-12', 'Transferência', 'TRX-100020', 'Confirmado'),
    (21, 27, 15000.00, '2025-01-12', 'Boleto', NULL, 'Confirmado'),
    (22, 28, 21000.00, '2026-06-12', 'PIX', 'TRX-100022', 'Confirmado'),
    (23, 30, 16000.00, '2026-10-12', 'Transferência', 'TRX-100023', 'Confirmado');

INSERT INTO APROVACAO (id_aprovacao, id_usuario, id_contrato, id_aditivo, id_alocacao, data_aprovacao, status, observacao, etapa) VALUES
    (1, 2, 1, NULL, NULL, '2025-01-28 10:15:00', 'Aprovado', NULL, 'Aprovação final'),
    (2, 2, 2, NULL, NULL, '2025-04-25 14:30:00', 'Aprovado', NULL, 'Aprovação final'),
    (3, 1, 3, NULL, NULL, '2025-08-27 09:50:00', 'Aprovado', NULL, 'Aprovação final'),
    (4, 2, 4, NULL, NULL, '2025-12-22 16:20:00', 'Aprovado', NULL, 'Aprovação final'),
    (5, 2, 5, NULL, NULL, '2026-02-24 11:05:00', 'Aprovado', NULL, 'Aprovação final'),
    (6, 1, 6, NULL, NULL, '2026-06-26 15:40:00', 'Aprovado', NULL, 'Aprovação final'),
    (7, 3, 7, NULL, NULL, '2026-10-20 10:00:00', 'Reprovado', 'Valor mensal divergente da proposta comercial', 'Revisão financeira'),
    (8, 2, 9, NULL, NULL, '2025-07-25 13:10:00', 'Aprovado', NULL, 'Aprovação final'),
    (9, 2, 10, NULL, NULL, '2023-12-20 09:30:00', 'Aprovado', NULL, 'Aprovação final'),
    (10, 2, 11, NULL, NULL, '2025-10-27 17:00:00', 'Aprovado', NULL, 'Aprovação final'),
    (11, 1, 12, NULL, NULL, '2026-08-25 10:45:00', 'Aprovado', NULL, 'Aprovação final'),
    (12, 2, NULL, 1, NULL, '2026-04-18 15:00:00', 'Aprovado', NULL, 'Aprovação final'),
    (13, 1, NULL, 3, NULL, '2026-08-10 09:20:00', 'Aprovado', NULL, 'Aprovação final'),
    (14, 2, NULL, 4, NULL, '2026-02-27 14:00:00', 'Aprovado', NULL, 'Aprovação final'),
    (15, 2, NULL, 5, NULL, '2026-06-20 11:30:00', 'Reprovado', 'Fora do escopo originalmente contratado', 'Aprovação final'),
    (16, 2, NULL, NULL, 12, '2026-06-24 10:10:00', 'Aprovado', NULL, 'Aprovação de alocação'),
    (17, 2, NULL, NULL, 23, '2026-10-28 16:45:00', 'Aprovado', NULL, 'Aprovação de alocação'),
    (18, 2, NULL, NULL, 24, '2026-09-10 12:00:00', 'Aprovado', NULL, 'Aprovação de alocação'),
    (19, 1, NULL, NULL, 26, '2026-08-28 09:00:00', 'Aprovado', NULL, 'Aprovação de alocação');

INSERT INTO COLABORADOR_CERTIFICACAO (id_colaborador, id_certificacao, data_obtencao, data_validade) VALUES
    (1, 1, '2023-03-10', '2026-03-10'),
    (1, 1, '2026-03-20', '2029-03-20'),
    (1, 4, '2024-06-15', '2027-06-15'),
    (2, 2, '2024-02-01', '2027-02-01'),
    (3, 6, '2023-09-05', '2026-09-05'),
    (3, 1, '2025-01-20', '2028-01-20'),
    (4, 7, '2025-05-12', '2027-05-12'),
    (5, 3, '2024-11-08', '2026-12-08'),
    (5, 2, '2025-07-01', '2028-07-01'),
    (6, 3, '2025-10-10', '2028-10-10'),
    (7, 6, '2025-04-22', '2028-04-22'),
    (8, 1, '2024-08-14', '2027-08-14'),
    (8, 5, '2025-09-30', '2027-09-30'),
    (9, 6, '2025-02-18', '2028-02-18'),
    (10, 7, '2026-01-15', NULL),
    (12, 2, '2023-05-20', '2026-05-20'),
    (12, 6, '2024-10-30', '2027-10-30'),
    (13, 6, '2026-02-11', '2029-02-11'),
    (14, 4, '2023-01-10', '2026-01-10');

INSERT INTO CONTRATO_CERTIFICACAO (id_contrato, id_certificacao, obrigatorio, data_limite) VALUES
    (1, 1, 1, NULL),
    (2, 3, 1, '2025-08-01'),
    (3, 1, 1, NULL),
    (4, 5, 1, NULL),
    (5, 1, 1, NULL),
    (5, 6, 1, '2026-06-01'),
    (6, 3, 1, NULL),
    (8, 5, 0, NULL),
    (9, 1, 1, NULL),
    (12, 2, 0, NULL);

INSERT INTO OPORTUNIDADE_CERTIFICACAO (id_oportunidade, id_certificacao, obrigatorio) VALUES
    (1, 1, 1),
    (2, 3, 1),
    (2, 7, 0),
    (3, 1, 1),
    (4, 5, 1),
    (5, 1, 1),
    (5, 6, 1),
    (6, 3, 1),
    (7, 1, 1),
    (7, 2, 0),
    (8, 6, 1),
    (9, 4, 1),
    (10, 7, 0);

INSERT INTO CONTRATO_PROVEDOR (id_contrato, id_provedor_de_nuvem, data_inicio, data_fim) VALUES
    (1, 1, '2025-02-01', NULL),
    (2, 2, '2025-05-01', NULL),
    (3, 1, '2025-09-01', NULL),
    (3, 3, '2025-09-01', NULL),
    (4, 3, '2026-01-01', NULL),
    (5, 1, '2026-03-01', NULL),
    (5, 2, '2026-03-01', NULL),
    (6, 2, '2026-07-01', NULL),
    (7, 1, '2026-11-16', NULL),
    (8, 3, '2026-04-01', NULL),
    (9, 1, '2025-08-01', NULL),
    (10, 2, '2024-01-01', '2024-12-31'),
    (11, 1, '2025-11-01', '2026-07-10'),
    (12, 3, '2026-09-01', NULL);

INSERT INTO CONTRATO_SERVICO (id_contrato, id_servico, valor_contratado, data_inicio, data_fim) VALUES
    (1, 1, 18000.00, '2025-02-01', NULL),
    (1, 3, 9000.00, '2025-02-01', NULL),
    (2, 2, 22000.00, '2025-05-01', NULL),
    (2, 5, 15000.00, '2025-05-01', NULL),
    (3, 1, 18000.00, '2025-09-01', NULL),
    (3, 6, 12000.00, '2025-09-01', NULL),
    (4, 4, 30000.00, '2026-01-01', NULL),
    (5, 1, 18000.00, '2026-03-01', NULL),
    (5, 2, 22000.00, '2026-03-01', NULL),
    (5, 3, 9000.00, '2026-03-01', NULL),
    (6, 2, 22000.00, '2026-07-01', NULL),
    (6, 6, 12000.00, '2026-07-01', NULL),
    (7, 3, 9000.00, '2026-11-16', NULL),
    (7, 5, 11000.00, '2026-11-16', NULL),
    (8, 1, 5000.00, '2026-04-01', NULL),
    (8, 6, 3500.00, '2026-04-01', NULL),
    (9, 2, 7000.00, '2025-08-01', NULL),
    (9, 5, 5000.00, '2025-08-01', NULL),
    (10, 1, 15000.00, '2024-01-01', '2024-12-31'),
    (11, 2, 21000.00, '2025-11-01', '2026-07-10'),
    (12, 1, 10000.00, '2026-09-01', NULL),
    (12, 3, 6000.00, '2026-09-01', NULL);

INSERT INTO OPORTUNIDADE_SERVICO (id_oportunidade, id_servico, valor_negociado, quantidade) VALUES
    (1, 1, 18000.00, 1),
    (1, 3, 9000.00, 1),
    (2, 2, 22000.00, 1),
    (2, 5, 15000.00, 1),
    (3, 1, 18000.00, 1),
    (3, 6, 12000.00, 1),
    (4, 4, 30000.00, 1),
    (5, 1, 18000.00, 1),
    (5, 2, 22000.00, 1),
    (5, 3, 9000.00, 1),
    (6, 2, 22000.00, 1),
    (6, 6, 12000.00, 1),
    (7, 1, 18000.00, 1),
    (7, 5, 15000.00, 1),
    (8, 2, 22000.00, 2),
    (9, 4, 30000.00, 1),
    (9, 3, 9000.00, 1),
    (10, 3, 9000.00, 1);

INSERT INTO OPORTUNIDADE_PERFIL_TECNICO (id_oportunidade, id_perfil_tecnico) VALUES
    (1, 1),
    (1, 4),
    (2, 3),
    (2, 5),
    (3, 2),
    (3, 6),
    (4, 1),
    (5, 1),
    (5, 2),
    (5, 4),
    (6, 3),
    (6, 6),
    (7, 1),
    (7, 5),
    (8, 3),
    (8, 2),
    (9, 1),
    (9, 4),
    (10, 4);

INSERT INTO COLABORADOR_PERFIL_TECNICO (id_colaborador, id_perfil_tecnico) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (3, 1),
    (4, 4),
    (5, 5),
    (6, 2),
    (7, 3),
    (8, 1),
    (9, 6),
    (10, 4),
    (12, 2),
    (12, 3),
    (13, 3),
    (14, 1);

INSERT INTO CONTRATO_TAG (id_contrato, id_tag, data_associacao) VALUES
    (1, 1, '2025-02-01'),
    (2, 2, '2025-05-01'),
    (2, 3, '2025-05-01'),
    (3, 4, '2025-09-01'),
    (4, 3, '2026-01-01'),
    (5, 1, '2026-03-01'),
    (5, 4, '2026-03-01'),
    (6, 3, '2026-07-01'),
    (8, 5, '2026-04-01'),
    (9, 1, '2025-08-01'),
    (12, 5, '2026-09-01');

INSERT INTO USUARIO_TAG (id_usuario, id_tag, data_permissao) VALUES
    (1, 1, '2025-01-10'),
    (1, 2, '2025-01-10'),
    (1, 3, '2025-01-10'),
    (1, 4, '2025-01-10'),
    (1, 5, '2025-01-10'),
    (2, 1, '2025-02-01'),
    (2, 2, '2025-05-01'),
    (2, 3, '2025-05-01'),
    (3, 2, '2025-05-02'),
    (4, 1, '2025-02-01');

INSERT INTO USUARIO_PERMISSAO (id_usuario, id_permissao, data_permissao) VALUES
    (1, 1, '2025-01-10'),
    (1, 2, '2025-01-10'),
    (1, 3, '2025-01-10'),
    (1, 4, '2025-01-10'),
    (1, 5, '2025-01-10'),
    (1, 6, '2025-01-10'),
    (1, 7, '2025-01-10'),
    (1, 8, '2025-01-10'),
    (2, 1, '2025-01-15'),
    (2, 2, '2025-01-15'),
    (2, 3, '2025-01-15'),
    (2, 7, '2025-01-15'),
    (3, 5, '2025-01-15'),
    (3, 6, '2025-01-15'),
    (3, 7, '2025-01-15'),
    (4, 1, '2025-01-15'),
    (4, 7, '2025-01-15'),
    (5, 4, '2025-02-01'),
    (6, 4, '2025-02-01'),
    (7, 4, '2025-02-01'),
    (8, 4, '2025-02-01');

INSERT INTO OPORTUNIDADE_PROVEDOR (id_oportunidade, id_provedor_de_nuvem) VALUES
    (1, 1),
    (2, 2),
    (3, 1),
    (3, 3),
    (4, 3),
    (5, 1),
    (5, 2),
    (6, 2),
    (7, 1),
    (8, 3),
    (8, 1),
    (9, 2),
    (10, 1);

SELECT tabela, registros FROM (
    SELECT 'CLIENTE' AS tabela, COUNT(*) AS registros FROM CLIENTE
UNION ALL
    SELECT 'SERVICO' AS tabela, COUNT(*) AS registros FROM SERVICO
UNION ALL
    SELECT 'COLABORADOR' AS tabela, COUNT(*) AS registros FROM COLABORADOR
UNION ALL
    SELECT 'CERTIFICACAO' AS tabela, COUNT(*) AS registros FROM CERTIFICACAO
UNION ALL
    SELECT 'PERMISSAO' AS tabela, COUNT(*) AS registros FROM PERMISSAO
UNION ALL
    SELECT 'PERFIL_DE_ACESSO' AS tabela, COUNT(*) AS registros FROM PERFIL_DE_ACESSO
UNION ALL
    SELECT 'PROVEDOR_DE_NUVEM' AS tabela, COUNT(*) AS registros FROM PROVEDOR_DE_NUVEM
UNION ALL
    SELECT 'TAG' AS tabela, COUNT(*) AS registros FROM TAG
UNION ALL
    SELECT 'PERFIL_TECNICO' AS tabela, COUNT(*) AS registros FROM PERFIL_TECNICO
UNION ALL
    SELECT 'CONTATO' AS tabela, COUNT(*) AS registros FROM CONTATO
UNION ALL
    SELECT 'OPORTUNIDADE' AS tabela, COUNT(*) AS registros FROM OPORTUNIDADE
UNION ALL
    SELECT 'CONTRATO_SALARIAL' AS tabela, COUNT(*) AS registros FROM CONTRATO_SALARIAL
UNION ALL
    SELECT 'USUARIO' AS tabela, COUNT(*) AS registros FROM USUARIO
UNION ALL
    SELECT 'CONTRATO' AS tabela, COUNT(*) AS registros FROM CONTRATO
UNION ALL
    SELECT 'ALOCACAO' AS tabela, COUNT(*) AS registros FROM ALOCACAO
UNION ALL
    SELECT 'APONTAMENTO_DE_HORAS' AS tabela, COUNT(*) AS registros FROM APONTAMENTO_DE_HORAS
UNION ALL
    SELECT 'EVIDENCIA' AS tabela, COUNT(*) AS registros FROM EVIDENCIA
UNION ALL
    SELECT 'ADITIVO' AS tabela, COUNT(*) AS registros FROM ADITIVO
UNION ALL
    SELECT 'FATURA' AS tabela, COUNT(*) AS registros FROM FATURA
UNION ALL
    SELECT 'PAGAMENTO' AS tabela, COUNT(*) AS registros FROM PAGAMENTO
UNION ALL
    SELECT 'APROVACAO' AS tabela, COUNT(*) AS registros FROM APROVACAO
UNION ALL
    SELECT 'COLABORADOR_CERTIFICACAO' AS tabela, COUNT(*) AS registros FROM COLABORADOR_CERTIFICACAO
UNION ALL
    SELECT 'CONTRATO_CERTIFICACAO' AS tabela, COUNT(*) AS registros FROM CONTRATO_CERTIFICACAO
UNION ALL
    SELECT 'OPORTUNIDADE_CERTIFICACAO' AS tabela, COUNT(*) AS registros FROM OPORTUNIDADE_CERTIFICACAO
UNION ALL
    SELECT 'CONTRATO_PROVEDOR' AS tabela, COUNT(*) AS registros FROM CONTRATO_PROVEDOR
UNION ALL
    SELECT 'CONTRATO_SERVICO' AS tabela, COUNT(*) AS registros FROM CONTRATO_SERVICO
UNION ALL
    SELECT 'OPORTUNIDADE_SERVICO' AS tabela, COUNT(*) AS registros FROM OPORTUNIDADE_SERVICO
UNION ALL
    SELECT 'OPORTUNIDADE_PERFIL_TECNICO' AS tabela, COUNT(*) AS registros FROM OPORTUNIDADE_PERFIL_TECNICO
UNION ALL
    SELECT 'COLABORADOR_PERFIL_TECNICO' AS tabela, COUNT(*) AS registros FROM COLABORADOR_PERFIL_TECNICO
UNION ALL
    SELECT 'CONTRATO_TAG' AS tabela, COUNT(*) AS registros FROM CONTRATO_TAG
UNION ALL
    SELECT 'USUARIO_TAG' AS tabela, COUNT(*) AS registros FROM USUARIO_TAG
UNION ALL
    SELECT 'USUARIO_PERMISSAO' AS tabela, COUNT(*) AS registros FROM USUARIO_PERMISSAO
UNION ALL
    SELECT 'OPORTUNIDADE_PROVEDOR' AS tabela, COUNT(*) AS registros FROM OPORTUNIDADE_PROVEDOR
) AS contagem ORDER BY tabela;
