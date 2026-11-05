DROP DATABASE IF EXISTS kxp_erp;
CREATE DATABASE kxp_erp
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE kxp_erp;

CREATE TABLE CLIENTE (
    id_cliente  INT           NOT NULL AUTO_INCREMENT,
    cnpj        VARCHAR(18)   NOT NULL,
    nome        VARCHAR(100)  NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT uq_cliente_cnpj UNIQUE (cnpj)
) ENGINE=InnoDB;

CREATE TABLE SERVICO (
    id_servico    INT            NOT NULL AUTO_INCREMENT,
    nome_servico  VARCHAR(100)   NOT NULL,
    descricao     TEXT           NULL,
    preco_base    DECIMAL(12,2)  NOT NULL DEFAULT 0.00,
    CONSTRAINT pk_servico PRIMARY KEY (id_servico),
    CONSTRAINT uq_servico_nome UNIQUE (nome_servico),
    CONSTRAINT chk_servico_preco CHECK (preco_base >= 0)
) ENGINE=InnoDB;

CREATE TABLE COLABORADOR (
    id_colaborador  INT            NOT NULL AUTO_INCREMENT,
    nome            VARCHAR(100)   NOT NULL,
    funcao          VARCHAR(50)    NOT NULL,
    senioridade     VARCHAR(10)    NOT NULL,
    custo_hora      DECIMAL(10,2)  NOT NULL,
    status          VARCHAR(10)    NOT NULL DEFAULT 'Ativo',
    CONSTRAINT pk_colaborador PRIMARY KEY (id_colaborador),
    CONSTRAINT chk_colaborador_senioridade CHECK (senioridade IN ('Júnior','Pleno','Sênior')),
    CONSTRAINT chk_colaborador_custo CHECK (custo_hora > 0),
    CONSTRAINT chk_colaborador_status CHECK (status IN ('Ativo','Inativo'))
) ENGINE=InnoDB;

CREATE TABLE CERTIFICACAO (
    id_certificacao    INT           NOT NULL AUTO_INCREMENT,
    nome_certificacao  VARCHAR(100)  NOT NULL,
    provedor_nuvem     VARCHAR(50)   NULL,
    nivel              VARCHAR(30)   NULL,
    CONSTRAINT pk_certificacao PRIMARY KEY (id_certificacao),
    CONSTRAINT uq_certificacao_nome UNIQUE (nome_certificacao)
) ENGINE=InnoDB;

CREATE TABLE PERMISSAO (
    id_permissao    INT           NOT NULL AUTO_INCREMENT,
    nome_permissao  VARCHAR(100)  NOT NULL,
    modulo          VARCHAR(50)   NOT NULL,
    status          VARCHAR(10)   NOT NULL DEFAULT 'Ativo',
    CONSTRAINT pk_permissao PRIMARY KEY (id_permissao),
    CONSTRAINT uq_permissao_nome UNIQUE (nome_permissao),
    CONSTRAINT chk_permissao_status CHECK (status IN ('Ativo','Inativo'))
) ENGINE=InnoDB;

CREATE TABLE PERFIL_DE_ACESSO (
    id_perfil_de_acesso  INT           NOT NULL AUTO_INCREMENT,
    nome_perfil          VARCHAR(50)   NOT NULL,
    nivel_acesso         INT           NOT NULL,
    descricao            VARCHAR(255)  NULL,
    status               VARCHAR(10)   NOT NULL DEFAULT 'Ativo',
    CONSTRAINT pk_perfil_de_acesso PRIMARY KEY (id_perfil_de_acesso),
    CONSTRAINT uq_perfil_de_acesso_nome UNIQUE (nome_perfil),
    CONSTRAINT chk_perfil_de_acesso_nivel CHECK (nivel_acesso >= 1),
    CONSTRAINT chk_perfil_de_acesso_status CHECK (status IN ('Ativo','Inativo'))
) ENGINE=InnoDB;

CREATE TABLE PROVEDOR_DE_NUVEM (
    id_provedor_de_nuvem  INT           NOT NULL AUTO_INCREMENT,
    nome_provedor         VARCHAR(50)   NOT NULL,
    site_oficial          VARCHAR(150)  NULL,
    descricao             VARCHAR(255)  NULL,
    status                VARCHAR(10)   NOT NULL DEFAULT 'Ativo',
    CONSTRAINT pk_provedor_de_nuvem PRIMARY KEY (id_provedor_de_nuvem),
    CONSTRAINT uq_provedor_de_nuvem_nome UNIQUE (nome_provedor),
    CONSTRAINT chk_provedor_de_nuvem_status CHECK (status IN ('Ativo','Inativo'))
) ENGINE=InnoDB;

CREATE TABLE TAG (
    id_tag     INT           NOT NULL AUTO_INCREMENT,
    nome_tag   VARCHAR(50)   NOT NULL,
    cor        VARCHAR(7)    NULL,
    descricao  VARCHAR(255)  NULL,
    status     VARCHAR(10)   NOT NULL DEFAULT 'Ativo',
    CONSTRAINT pk_tag PRIMARY KEY (id_tag),
    CONSTRAINT uq_tag_nome UNIQUE (nome_tag),
    CONSTRAINT chk_tag_status CHECK (status IN ('Ativo','Inativo'))
) ENGINE=InnoDB;

CREATE TABLE PERFIL_TECNICO (
    id_perfil_tecnico  INT           NOT NULL AUTO_INCREMENT,
    nome_perfil        VARCHAR(100)  NOT NULL,
    descricao          VARCHAR(255)  NULL,
    nivel_experiencia  VARCHAR(20)   NULL,
    status             VARCHAR(10)   NOT NULL DEFAULT 'Ativo',
    CONSTRAINT pk_perfil_tecnico PRIMARY KEY (id_perfil_tecnico),
    CONSTRAINT uq_perfil_tecnico_nome UNIQUE (nome_perfil),
    CONSTRAINT chk_perfil_tecnico_nivel CHECK (nivel_experiencia IS NULL OR nivel_experiencia IN ('Júnior','Pleno','Sênior')),
    CONSTRAINT chk_perfil_tecnico_status CHECK (status IN ('Ativo','Inativo'))
) ENGINE=InnoDB;

CREATE TABLE CONTATO (
    id_contato  INT           NOT NULL AUTO_INCREMENT,
    id_cliente  INT           NOT NULL,
    nome        VARCHAR(100)  NOT NULL,
    email       VARCHAR(100)  NULL,
    telefone    VARCHAR(20)   NULL,
    CONSTRAINT pk_contato PRIMARY KEY (id_contato),
    CONSTRAINT fk_contato_cliente FOREIGN KEY (id_cliente)
        REFERENCES CLIENTE (id_cliente) ON DELETE RESTRICT,
    CONSTRAINT chk_contato_email CHECK (email IS NULL OR email LIKE '%_@_%._%'),
    CONSTRAINT chk_contato_telefone CHECK (telefone IS NULL OR telefone REGEXP '^[0-9]{10,13}$')
) ENGINE=InnoDB;

CREATE TABLE OPORTUNIDADE (
    id_oportunidade       INT            NOT NULL AUTO_INCREMENT,
    id_cliente            INT            NOT NULL,
    valor_estimado        DECIMAL(12,2)  NOT NULL DEFAULT 0.00,
    data_prevista_inicio  DATE           NULL,
    estagio_negociacao    VARCHAR(50)    NOT NULL DEFAULT 'Prospecção',
    CONSTRAINT pk_oportunidade PRIMARY KEY (id_oportunidade),
    CONSTRAINT fk_oportunidade_cliente FOREIGN KEY (id_cliente)
        REFERENCES CLIENTE (id_cliente) ON DELETE RESTRICT,
    CONSTRAINT chk_oportunidade_valor CHECK (valor_estimado >= 0),
    CONSTRAINT chk_oportunidade_estagio CHECK (estagio_negociacao IN ('Prospecção','Negociação','Ganha','Perdida'))
) ENGINE=InnoDB;

CREATE TABLE CONTRATO_SALARIAL (
    id_contrato_salarial  INT            NOT NULL AUTO_INCREMENT,
    id_colaborador        INT            NOT NULL,
    salario               DECIMAL(10,2)  NOT NULL,
    data_inicio           DATE           NOT NULL,
    data_fim              DATE           NULL,
    CONSTRAINT pk_contrato_salarial PRIMARY KEY (id_contrato_salarial),
    CONSTRAINT fk_contrato_salarial_colaborador FOREIGN KEY (id_colaborador)
        REFERENCES COLABORADOR (id_colaborador) ON DELETE RESTRICT,
    CONSTRAINT chk_contrato_salarial_salario CHECK (salario > 0),
    CONSTRAINT chk_contrato_salarial_data_fim CHECK (data_fim IS NULL OR data_fim >= data_inicio)
) ENGINE=InnoDB;

CREATE TABLE USUARIO (
    id_usuario           INT           NOT NULL AUTO_INCREMENT,
    id_perfil_de_acesso  INT           NOT NULL,
    id_colaborador       INT           NULL,
    nome_usuario         VARCHAR(50)   NOT NULL,
    email                VARCHAR(100)  NOT NULL,
    senha                VARCHAR(255)  NOT NULL,
    status               VARCHAR(10)   NOT NULL DEFAULT 'Ativo',
    ultimo_acesso        DATETIME      NULL,
    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
    CONSTRAINT uq_usuario_colaborador UNIQUE (id_colaborador),
    CONSTRAINT uq_usuario_nome UNIQUE (nome_usuario),
    CONSTRAINT uq_usuario_email UNIQUE (email),
    CONSTRAINT fk_usuario_perfil FOREIGN KEY (id_perfil_de_acesso)
        REFERENCES PERFIL_DE_ACESSO (id_perfil_de_acesso) ON DELETE RESTRICT,
    CONSTRAINT fk_usuario_colaborador FOREIGN KEY (id_colaborador)
        REFERENCES COLABORADOR (id_colaborador) ON DELETE RESTRICT,
    CONSTRAINT chk_usuario_status CHECK (status IN ('Ativo','Inativo'))
) ENGINE=InnoDB;

CREATE TABLE CONTRATO (
    id_contrato              INT            NOT NULL AUTO_INCREMENT,
    id_cliente               INT            NOT NULL,
    id_oportunidade          INT            NULL,
    numero                   VARCHAR(50)    NOT NULL,
    valor_mensal             DECIMAL(12,2)  NOT NULL,
    data_inicio              DATE           NOT NULL,
    vigencia                 INT            NOT NULL DEFAULT 12,
    tipo_renovacao           VARCHAR(20)    NOT NULL,
    prazo_aviso_previo       INT            NOT NULL DEFAULT 30,
    moeda                    CHAR(3)        NOT NULL,
    referencia_docusign      VARCHAR(100)   NULL,
    status                   VARCHAR(20)    NOT NULL DEFAULT 'Em aprovação',
    data_aviso_cancelamento  DATE           NULL,
    data_efetiva_termino     DATE           NULL,
    CONSTRAINT pk_contrato PRIMARY KEY (id_contrato),
    CONSTRAINT uq_contrato_oportunidade UNIQUE (id_oportunidade),
    CONSTRAINT uq_contrato_numero UNIQUE (numero),
    CONSTRAINT fk_contrato_cliente FOREIGN KEY (id_cliente)
        REFERENCES CLIENTE (id_cliente) ON DELETE RESTRICT,
    CONSTRAINT fk_contrato_oportunidade FOREIGN KEY (id_oportunidade)
        REFERENCES OPORTUNIDADE (id_oportunidade) ON DELETE RESTRICT,
    CONSTRAINT chk_contrato_valor CHECK (valor_mensal >= 0),
    CONSTRAINT chk_contrato_vigencia CHECK (vigencia > 0),
    CONSTRAINT chk_contrato_renovacao CHECK (tipo_renovacao IN ('Prazo determinado','Evergreen')),
    CONSTRAINT chk_contrato_aviso CHECK (prazo_aviso_previo >= 0),
    CONSTRAINT chk_contrato_moeda CHECK (moeda IN ('BRL','USD')),
    CONSTRAINT chk_contrato_status CHECK (status IN ('Em aprovação','Vigente','Aviso prévio','Encerrado','Cancelado')),
    CONSTRAINT chk_contrato_termino CHECK (data_efetiva_termino IS NULL OR data_aviso_cancelamento IS NULL
                                           OR data_efetiva_termino >= data_aviso_cancelamento)
) ENGINE=InnoDB;

CREATE TABLE ALOCACAO (
    id_alocacao            INT            NOT NULL AUTO_INCREMENT,
    id_colaborador         INT            NOT NULL,
    id_contrato            INT            NOT NULL,
    funcao                 VARCHAR(50)    NOT NULL,
    data_inicio            DATE           NOT NULL,
    data_termino_prevista  DATE           NOT NULL,
    data_termino_real      DATE           NULL,
    percentual_dedicacao   DECIMAL(5,2)   NOT NULL,
    custo_hora             DECIMAL(10,2)  NOT NULL,
    status                 VARCHAR(20)    NOT NULL DEFAULT 'Ativa',
    CONSTRAINT pk_alocacao PRIMARY KEY (id_alocacao),
    CONSTRAINT fk_alocacao_colaborador FOREIGN KEY (id_colaborador)
        REFERENCES COLABORADOR (id_colaborador) ON DELETE RESTRICT,
    CONSTRAINT fk_alocacao_contrato FOREIGN KEY (id_contrato)
        REFERENCES CONTRATO (id_contrato) ON DELETE RESTRICT,
    CONSTRAINT chk_alocacao_termino_prev CHECK (data_termino_prevista >= data_inicio),
    CONSTRAINT chk_alocacao_termino_real CHECK (data_termino_real IS NULL OR data_termino_real >= data_inicio),
    CONSTRAINT chk_alocacao_dedicacao CHECK (percentual_dedicacao > 0 AND percentual_dedicacao <= 100),
    CONSTRAINT chk_alocacao_custo CHECK (custo_hora > 0),
    CONSTRAINT chk_alocacao_status CHECK (status IN ('Planejada','Ativa','Encerrada'))
) ENGINE=InnoDB;

CREATE TABLE APONTAMENTO_DE_HORAS (
    id_apontamento_de_horas  INT            NOT NULL AUTO_INCREMENT,
    id_alocacao              INT            NOT NULL,
    `data`                   DATE           NOT NULL,
    quantidade_horas         DECIMAL(5,2)   NOT NULL,
    descricao                VARCHAR(255)   NULL,
    status                   VARCHAR(20)    NOT NULL DEFAULT 'Registrado',
    CONSTRAINT pk_apontamento_de_horas PRIMARY KEY (id_apontamento_de_horas),
    CONSTRAINT fk_apontamento_alocacao FOREIGN KEY (id_alocacao)
        REFERENCES ALOCACAO (id_alocacao) ON DELETE RESTRICT,
    CONSTRAINT chk_apontamento_horas CHECK (quantidade_horas > 0 AND quantidade_horas <= 24),
    CONSTRAINT chk_apontamento_status CHECK (status IN ('Registrado','Ajustado','Cancelado'))
) ENGINE=InnoDB;

CREATE TABLE EVIDENCIA (
    id_evidencia     INT           NOT NULL AUTO_INCREMENT,
    id_contrato      INT           NOT NULL,
    id_colaborador   INT           NOT NULL,
    mes_referencia   DATE          NOT NULL,
    caminho_arquivo  VARCHAR(255)  NOT NULL,
    nome_arquivo     VARCHAR(100)  NOT NULL,
    tipo_arquivo     VARCHAR(20)   NULL,
    data_upload      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descricao        VARCHAR(255)  NULL,
    CONSTRAINT pk_evidencia PRIMARY KEY (id_evidencia),
    CONSTRAINT fk_evidencia_contrato FOREIGN KEY (id_contrato)
        REFERENCES CONTRATO (id_contrato) ON DELETE RESTRICT,
    CONSTRAINT fk_evidencia_colaborador FOREIGN KEY (id_colaborador)
        REFERENCES COLABORADOR (id_colaborador) ON DELETE RESTRICT,
    CONSTRAINT chk_evidencia_mes CHECK (DAY(mes_referencia) = 1)
) ENGINE=InnoDB;

CREATE TABLE ADITIVO (
    id_aditivo          INT            NOT NULL AUTO_INCREMENT,
    id_contrato         INT            NOT NULL,
    numero_aditivo      INT            NOT NULL,
    data_assinatura     DATE           NULL,
    descricao           TEXT           NOT NULL,
    impacto_financeiro  DECIMAL(12,2)  NULL DEFAULT 0.00,
    nova_vigencia       INT            NULL,
    status              VARCHAR(20)    NOT NULL DEFAULT 'Pendente',
    CONSTRAINT pk_aditivo PRIMARY KEY (id_aditivo),
    CONSTRAINT uq_aditivo_contrato_numero UNIQUE (id_contrato, numero_aditivo),
    CONSTRAINT fk_aditivo_contrato FOREIGN KEY (id_contrato)
        REFERENCES CONTRATO (id_contrato) ON DELETE RESTRICT,
    CONSTRAINT chk_aditivo_numero CHECK (numero_aditivo > 0),
    CONSTRAINT chk_aditivo_vigencia CHECK (nova_vigencia IS NULL OR nova_vigencia > 0),
    CONSTRAINT chk_aditivo_status CHECK (status IN ('Pendente','Aprovado','Rejeitado'))
) ENGINE=InnoDB;

CREATE TABLE FATURA (
    id_fatura        INT            NOT NULL AUTO_INCREMENT,
    id_contrato      INT            NOT NULL,
    numero_fatura    VARCHAR(50)    NOT NULL,
    competencia      DATE           NOT NULL,
    valor            DECIMAL(12,2)  NOT NULL,
    data_emissao     DATE           NOT NULL,
    data_vencimento  DATE           NOT NULL,
    status           VARCHAR(20)    NOT NULL DEFAULT 'Em aberto',
    CONSTRAINT pk_fatura PRIMARY KEY (id_fatura),
    CONSTRAINT uq_fatura_numero UNIQUE (numero_fatura),
    CONSTRAINT fk_fatura_contrato FOREIGN KEY (id_contrato)
        REFERENCES CONTRATO (id_contrato) ON DELETE RESTRICT,
    CONSTRAINT chk_fatura_competencia CHECK (DAY(competencia) = 1),
    CONSTRAINT chk_fatura_valor CHECK (valor > 0),
    CONSTRAINT chk_fatura_vencimento CHECK (data_vencimento >= data_emissao),
    CONSTRAINT chk_fatura_status CHECK (status IN ('Em aberto','Paga','Em atraso','Cancelada'))
) ENGINE=InnoDB;

CREATE TABLE PAGAMENTO (
    id_pagamento      INT            NOT NULL AUTO_INCREMENT,
    id_fatura         INT            NOT NULL,
    valor             DECIMAL(12,2)  NOT NULL,
    data_pagamento    DATE           NOT NULL,
    metodo_pagamento  VARCHAR(30)    NOT NULL,
    codigo_transacao  VARCHAR(100)   NULL,
    status            VARCHAR(20)    NOT NULL DEFAULT 'Confirmado',
    CONSTRAINT pk_pagamento PRIMARY KEY (id_pagamento),
    CONSTRAINT uq_pagamento_transacao UNIQUE (codigo_transacao),
    CONSTRAINT fk_pagamento_fatura FOREIGN KEY (id_fatura)
        REFERENCES FATURA (id_fatura) ON DELETE RESTRICT,
    CONSTRAINT chk_pagamento_valor CHECK (valor > 0),
    CONSTRAINT chk_pagamento_status CHECK (status IN ('Confirmado','Estornado'))
) ENGINE=InnoDB;

CREATE TABLE APROVACAO (
    id_aprovacao    INT          NOT NULL AUTO_INCREMENT,
    id_usuario      INT          NOT NULL,
    id_contrato     INT          NULL,
    id_aditivo      INT          NULL,
    id_alocacao     INT          NULL,
    data_aprovacao  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status          VARCHAR(20)  NOT NULL,
    observacao      TEXT         NULL,
    etapa           VARCHAR(50)  NULL,
    CONSTRAINT pk_aprovacao PRIMARY KEY (id_aprovacao),
    CONSTRAINT fk_aprovacao_usuario FOREIGN KEY (id_usuario)
        REFERENCES USUARIO (id_usuario) ON DELETE RESTRICT,
    CONSTRAINT fk_aprovacao_contrato FOREIGN KEY (id_contrato)
        REFERENCES CONTRATO (id_contrato) ON DELETE RESTRICT,
    CONSTRAINT fk_aprovacao_aditivo FOREIGN KEY (id_aditivo)
        REFERENCES ADITIVO (id_aditivo) ON DELETE RESTRICT,
    CONSTRAINT fk_aprovacao_alocacao FOREIGN KEY (id_alocacao)
        REFERENCES ALOCACAO (id_alocacao) ON DELETE RESTRICT,
    CONSTRAINT chk_aprovacao_status CHECK (status IN ('Aprovado','Reprovado')),
    CONSTRAINT chk_aprovacao_um_alvo CHECK (
        (id_contrato IS NOT NULL) + (id_aditivo IS NOT NULL) + (id_alocacao IS NOT NULL) = 1),
    CONSTRAINT chk_aprovacao_obs CHECK (status <> 'Reprovado' OR observacao IS NOT NULL)
) ENGINE=InnoDB;

CREATE TABLE COLABORADOR_CERTIFICACAO (
    id_colaborador   INT   NOT NULL,
    id_certificacao  INT   NOT NULL,
    data_obtencao    DATE  NOT NULL,
    data_validade    DATE  NULL,
    CONSTRAINT pk_colaborador_certificacao PRIMARY KEY (id_colaborador, id_certificacao, data_obtencao),
    CONSTRAINT fk_colcert_colaborador FOREIGN KEY (id_colaborador)
        REFERENCES COLABORADOR (id_colaborador) ON DELETE CASCADE,
    CONSTRAINT fk_colcert_certificacao FOREIGN KEY (id_certificacao)
        REFERENCES CERTIFICACAO (id_certificacao) ON DELETE CASCADE,
    CONSTRAINT chk_colcert_validade CHECK (data_validade IS NULL OR data_validade >= data_obtencao)
) ENGINE=InnoDB;

CREATE TABLE CONTRATO_CERTIFICACAO (
    id_contrato      INT      NOT NULL,
    id_certificacao  INT      NOT NULL,
    obrigatorio      TINYINT  NOT NULL DEFAULT 1,
    data_limite      DATE     NULL,
    CONSTRAINT pk_contrato_certificacao PRIMARY KEY (id_contrato, id_certificacao),
    CONSTRAINT fk_contcert_contrato FOREIGN KEY (id_contrato)
        REFERENCES CONTRATO (id_contrato) ON DELETE CASCADE,
    CONSTRAINT fk_contcert_certificacao FOREIGN KEY (id_certificacao)
        REFERENCES CERTIFICACAO (id_certificacao) ON DELETE CASCADE,
    CONSTRAINT chk_contcert_obrigatorio CHECK (obrigatorio IN (0,1))
) ENGINE=InnoDB;

CREATE TABLE OPORTUNIDADE_CERTIFICACAO (
    id_oportunidade  INT      NOT NULL,
    id_certificacao  INT      NOT NULL,
    obrigatorio      TINYINT  NOT NULL DEFAULT 1,
    CONSTRAINT pk_oportunidade_certificacao PRIMARY KEY (id_oportunidade, id_certificacao),
    CONSTRAINT fk_opcert_oportunidade FOREIGN KEY (id_oportunidade)
        REFERENCES OPORTUNIDADE (id_oportunidade) ON DELETE CASCADE,
    CONSTRAINT fk_opcert_certificacao FOREIGN KEY (id_certificacao)
        REFERENCES CERTIFICACAO (id_certificacao) ON DELETE CASCADE,
    CONSTRAINT chk_opcert_obrigatorio CHECK (obrigatorio IN (0,1))
) ENGINE=InnoDB;

CREATE TABLE CONTRATO_PROVEDOR (
    id_contrato           INT   NOT NULL,
    id_provedor_de_nuvem  INT   NOT NULL,
    data_inicio           DATE  NOT NULL,
    data_fim              DATE  NULL,
    CONSTRAINT pk_contrato_provedor PRIMARY KEY (id_contrato, id_provedor_de_nuvem),
    CONSTRAINT fk_contprov_contrato FOREIGN KEY (id_contrato)
        REFERENCES CONTRATO (id_contrato) ON DELETE CASCADE,
    CONSTRAINT fk_contprov_provedor FOREIGN KEY (id_provedor_de_nuvem)
        REFERENCES PROVEDOR_DE_NUVEM (id_provedor_de_nuvem) ON DELETE CASCADE,
    CONSTRAINT chk_contprov_data_fim CHECK (data_fim IS NULL OR data_fim >= data_inicio)
) ENGINE=InnoDB;

CREATE TABLE CONTRATO_SERVICO (
    id_contrato       INT            NOT NULL,
    id_servico        INT            NOT NULL,
    valor_contratado  DECIMAL(12,2)  NOT NULL,
    data_inicio       DATE           NOT NULL,
    data_fim          DATE           NULL,
    CONSTRAINT pk_contrato_servico PRIMARY KEY (id_contrato, id_servico),
    CONSTRAINT fk_contserv_contrato FOREIGN KEY (id_contrato)
        REFERENCES CONTRATO (id_contrato) ON DELETE CASCADE,
    CONSTRAINT fk_contserv_servico FOREIGN KEY (id_servico)
        REFERENCES SERVICO (id_servico) ON DELETE CASCADE,
    CONSTRAINT chk_contserv_valor CHECK (valor_contratado >= 0),
    CONSTRAINT chk_contserv_data_fim CHECK (data_fim IS NULL OR data_fim >= data_inicio)
) ENGINE=InnoDB;

CREATE TABLE OPORTUNIDADE_SERVICO (
    id_oportunidade  INT            NOT NULL,
    id_servico       INT            NOT NULL,
    valor_negociado  DECIMAL(12,2)  NOT NULL,
    quantidade       INT            NOT NULL DEFAULT 1,
    CONSTRAINT pk_oportunidade_servico PRIMARY KEY (id_oportunidade, id_servico),
    CONSTRAINT fk_opserv_oportunidade FOREIGN KEY (id_oportunidade)
        REFERENCES OPORTUNIDADE (id_oportunidade) ON DELETE CASCADE,
    CONSTRAINT fk_opserv_servico FOREIGN KEY (id_servico)
        REFERENCES SERVICO (id_servico) ON DELETE CASCADE,
    CONSTRAINT chk_opserv_valor CHECK (valor_negociado >= 0),
    CONSTRAINT chk_opserv_quantidade CHECK (quantidade > 0)
) ENGINE=InnoDB;

CREATE TABLE OPORTUNIDADE_PERFIL_TECNICO (
    id_oportunidade    INT  NOT NULL,
    id_perfil_tecnico  INT  NOT NULL,
    CONSTRAINT pk_oportunidade_perfil_tecnico PRIMARY KEY (id_oportunidade, id_perfil_tecnico),
    CONSTRAINT fk_opperf_oportunidade FOREIGN KEY (id_oportunidade)
        REFERENCES OPORTUNIDADE (id_oportunidade) ON DELETE CASCADE,
    CONSTRAINT fk_opperf_perfil FOREIGN KEY (id_perfil_tecnico)
        REFERENCES PERFIL_TECNICO (id_perfil_tecnico) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE COLABORADOR_PERFIL_TECNICO (
    id_colaborador     INT  NOT NULL,
    id_perfil_tecnico  INT  NOT NULL,
    CONSTRAINT pk_colaborador_perfil_tecnico PRIMARY KEY (id_colaborador, id_perfil_tecnico),
    CONSTRAINT fk_colperf_colaborador FOREIGN KEY (id_colaborador)
        REFERENCES COLABORADOR (id_colaborador) ON DELETE CASCADE,
    CONSTRAINT fk_colperf_perfil FOREIGN KEY (id_perfil_tecnico)
        REFERENCES PERFIL_TECNICO (id_perfil_tecnico) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE CONTRATO_TAG (
    id_contrato      INT   NOT NULL,
    id_tag           INT   NOT NULL,
    data_associacao  DATE  NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT pk_contrato_tag PRIMARY KEY (id_contrato, id_tag),
    CONSTRAINT fk_conttag_contrato FOREIGN KEY (id_contrato)
        REFERENCES CONTRATO (id_contrato) ON DELETE CASCADE,
    CONSTRAINT fk_conttag_tag FOREIGN KEY (id_tag)
        REFERENCES TAG (id_tag) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE USUARIO_TAG (
    id_usuario      INT   NOT NULL,
    id_tag          INT   NOT NULL,
    data_permissao  DATE  NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT pk_usuario_tag PRIMARY KEY (id_usuario, id_tag),
    CONSTRAINT fk_usertag_usuario FOREIGN KEY (id_usuario)
        REFERENCES USUARIO (id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_usertag_tag FOREIGN KEY (id_tag)
        REFERENCES TAG (id_tag) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE USUARIO_PERMISSAO (
    id_usuario      INT   NOT NULL,
    id_permissao    INT   NOT NULL,
    data_permissao  DATE  NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT pk_usuario_permissao PRIMARY KEY (id_usuario, id_permissao),
    CONSTRAINT fk_userperm_usuario FOREIGN KEY (id_usuario)
        REFERENCES USUARIO (id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_userperm_permissao FOREIGN KEY (id_permissao)
        REFERENCES PERMISSAO (id_permissao) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE OPORTUNIDADE_PROVEDOR (
    id_oportunidade       INT  NOT NULL,
    id_provedor_de_nuvem  INT  NOT NULL,
    CONSTRAINT pk_oportunidade_provedor PRIMARY KEY (id_oportunidade, id_provedor_de_nuvem),
    CONSTRAINT fk_opprov_oportunidade FOREIGN KEY (id_oportunidade)
        REFERENCES OPORTUNIDADE (id_oportunidade) ON DELETE CASCADE,
    CONSTRAINT fk_opprov_provedor FOREIGN KEY (id_provedor_de_nuvem)
        REFERENCES PROVEDOR_DE_NUVEM (id_provedor_de_nuvem) ON DELETE CASCADE
) ENGINE=InnoDB;

SELECT COUNT(*) AS total_tabelas
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'kxp_erp' AND TABLE_TYPE = 'BASE TABLE';

SELECT COUNT(*) AS total_fks
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'kxp_erp' AND CONSTRAINT_TYPE = 'FOREIGN KEY';

SELECT COUNT(*) AS total_checks
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'kxp_erp' AND CONSTRAINT_TYPE = 'CHECK';
