```mermaid
erDiagram
    %% 1. Cliente
    CLIENTE {
        string cnpj
        string nome
        string contatos
    }

    %% 2. Oportunidade
    OPORTUNIDADE {
        string cliente
        string servico
        decimal valor_estimado
        date data_prevista_inicio
        string provedor_nuvem
        string certificacoes_perfis_tecnicos_necessarios
        string estagio_negociacao
    }

    %% 3. Serviço
    SERVICO {
        string nome_descricao_servico
        decimal valor_contrato
    }

    %% 4. Contrato
    CONTRATO {
        string numero
        string servicos
        decimal valor
        date data_inicio
        string vigencia
        string tipo_renovacao
        string prazo_aviso_previo
        string provedores_nuvem
        string moeda
        string referencia_docusign
        string status
    }

    %% 5. Colaborador
    COLABORADOR {
        string funcao
        string senioridade
        decimal custo_hora
        string status
        string certificacoes
    }

    %% 6. Alocação
    ALOCACAO {
        string colaborador
        string contrato
        string funcao
        date data_inicio
        date termino_previsto
        date termino_real
        string dedicacao
        decimal custo_hora_momento
    }

    %% 7. Apontamento de Horas
    APONTAMENTO_DE_HORAS {
        string colaborador
        string contrato_alocacao
        decimal horas_trabalhadas
        date data_periodo_apontamento
        decimal custo_hora_vigente
    }

    %% 8. Evidência de Entrega
    EVIDENCIA {
        string contrato
        string colaborador
        string mes_referencia
        string entrega_evidencia
    }

    %% 9. Fatura
    FATURA {
        string contrato
        string competencia
        decimal valor
        string moeda
        date vencimento
        string numero_nf
        string status_fatura
    }

    %% 10. Pagamento
    PAGAMENTO {
        string fatura
        date data
        decimal valor
    }

    %% 11. Aditivo
    ADITIVO {
        string contrato
        date data
        string condicoes_anteriores
        string novas_condicoes
        string status_aprovacao
    }

    %% 12. Usuário
    USUARIO {
        string perfil_acesso
        string colaborador_vinculado
    }

    %% 13. Perfil de Acesso
    PERFIL_DE_ACESSO {
        string nome_perfil
        string usuarios_vinculados
    }

    %% 14. Aprovação
    APROVACAO {
        string quem_aprovou
        date data
        string decisao
        string observacao
    }

    %% 15. Certificação
    CERTIFICACAO {
        string nome_certificacao
        date data_obtencao
        date data_validade
    }

    %% 16. Provedor de Nuvem
    PROVEDOR_DE_NUVEM {
        string nome_provedor
    }

    %% 17. Permissão
    PERMISSAO {
        string nome_permissao
        string descricao
    }

    %% 18. Tag
    TAG {
        string nome_tag
    }

    %% 19. Contato
    CONTATO {
        string nome
        string email
        string telefone
    }

    %% 20. Contrato Salarial
    CONTRATO_SALARIAL {
        decimal salario
        date data_inicio
        date data_fim
    }

    %% ATRIBUTOS DOS RELACIONAMENTOS (ENTIDADES ASSOCIATIVAS)
    ADITIVO_APROVACAO {
        string status_aprovacao
        date data_aprovacao
    }

    ALOCACAO_APROVACAO {
        string status_aprovacao
        date data_aprovacao
    }

    COLABORADOR_CERTIFICACAO {
        date data_obtencao
        date data_validade
    }

    CONTRATO_CERTIFICACAO {
        boolean obrigatorio
        date data_limite
    }

    CONTRATO_PROVEDOR_DE_NUVEM {
        date data_inicio
        date data_fim
    }

    CONTRATO_TAG {
        date data_associacao
    }

    OPORTUNIDADE_CERTIFICACAO {
        boolean obrigatorio
    }

    OPORTUNIDADE_SERVICO {
        decimal valor_negociado
        int quantidade
    }

    SERVICO_CONTRATO {
        decimal valor_contratado
        date data_inicio
        date data_fim
    }

    USUARIO_PERMISSAO {
        date data_permissao
    }

    USUARIO_TAG {
        date data_permissao
    }

    %% RELACIONAMENTOS
    ADITIVO ||--|{ ADITIVO_APROVACAO : "recebe (1,1)"
    APROVACAO ||--|{ ADITIVO_APROVACAO : "recebe (1,N)"

    ALOCACAO ||--|{ ALOCACAO_APROVACAO : "possui (1,1)"
    APROVACAO ||--|{ ALOCACAO_APROVACAO : "possui (1,N)"

    COLABORADOR }o--|{ COLABORADOR_CERTIFICACAO : "possui (0,N)"
    CERTIFICACAO }o--|{ COLABORADOR_CERTIFICACAO : "possui (0,N)"

    CONTRATO }o--|{ CONTRATO_CERTIFICACAO : "exige (0,N)"
    CERTIFICACAO }o--|{ CONTRATO_CERTIFICACAO : "exige (0,N)"

    CONTRATO }o--|{ CONTRATO_PROVEDOR_DE_NUVEM : "utiliza (0,N)"
    PROVEDOR_DE_NUVEM }o--|{ CONTRATO_PROVEDOR_DE_NUVEM : "utiliza (0,N)"

    CONTRATO }o--|{ CONTRATO_TAG : "tem (0,N)"
    TAG }o--|{ CONTRATO_TAG : "tem (0,N)"

    OPORTUNIDADE }o--|{ OPORTUNIDADE_CERTIFICACAO : "exige (0,N)"
    CERTIFICACAO }o--|{ OPORTUNIDADE_CERTIFICACAO : "exige (0,N)"

    OPORTUNIDADE }o--|{ OPORTUNIDADE_SERVICO : "envolve (0,N)"
    SERVICO }o--|{ OPORTUNIDADE_SERVICO : "envolve (0,N)"

    SERVICO }o--|{ SERVICO_CONTRATO : "envolve (0,N)"
    CONTRATO }o--|{ SERVICO_CONTRATO : "envolve (0,N)"

    USUARIO }o--|{ USUARIO_PERMISSAO : "precisa (0,N)"
    PERMISSAO }o--|{ USUARIO_PERMISSAO : "precisa (0,N)"

    USUARIO }o--|{ USUARIO_TAG : "tem (0,N)"
    TAG }o--|{ USUARIO_TAG : "tem (0,N)"

    %%Demais entidades
    ALOCACAO ||--|{ APONTAMENTO_DE_HORAS : "tem (1,1 - 1,N)"
    CLIENTE ||--|{ CONTATO : "recebe (1,1 - 1,N)"
    CLIENTE ||--|{ OPORTUNIDADE : "tem (1,1 - 1,N)"
    COLABORADOR ||--|{ ALOCACAO : "tem (1,1 - 1,N)"
    COLABORADOR ||--|{ APONTAMENTO_DE_HORAS : "possui (1,1 - 1,N)"
    COLABORADOR ||--|{ CONTRATO_SALARIAL : "tem (1,1 - 1,N)"
    COLABORADOR ||--|{ EVIDENCIA : "registra (1,1 - 1,N)"
    COLABORADOR |o--|| USUARIO : "tem (0,1 - 1,1)"
    CONTRATO ||--|{ ADITIVO : "possui (1,1 - 1,N)"
    CONTRATO ||--|{ ALOCACAO : "tem (1,1 - 1,N)"
    CONTRATO ||--|{ APONTAMENTO_DE_HORAS : "possui (1,1 - 1,N)"
    CONTRATO ||--|{ APROVACAO : "possui (1,1 - 1,N)"
    CONTRATO ||--|{ EVIDENCIA : "tem (1,1 - 1,N)"
    CONTRATO ||--|{ FATURA : "produz (1,1 - 1,N)"
    CONTRATO ||--|{ OPORTUNIDADE : "gera (1,1 - 1,N)"
    FATURA ||--|{ PAGAMENTO : "tem (1,1 - 1,N)"
    OPORTUNIDADE |o--|| CONTRATO : "gera (0,1 - 1,1)"
    USUARIO ||--|{ APROVACAO : "realiza (1,1 - 1,N)"
    USUARIO }|--|| PERFIL_DE_ACESSO : "possui (1,N - 1,1)"
