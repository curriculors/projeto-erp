```mermaid
---
config:
  layout: elk
---
erDiagram
    Aditivo ||--o{ Aprovacao : "recebe (1:N)"
    Alocacao ||--o{ Apontamento_de_horas : "tem (1:N)"
    Alocacao ||--o{ Aprovacao : "possui (1:N)"
    
    Cliente ||--o{ Contato : "recebe (1:N)"
    Cliente ||--o{ Contrato : "tem (1:N)"
    Cliente ||--o{ Oportunidade : "tem (1:N)"
    
    Colaborador ||--o{ Alocacao : "tem (1:N)"
    Colaborador ||--o{ Apontamento_de_horas : "possui (1:N)"
    Colaborador }o--o{ Certificacao : "possui (N:N)"
    Colaborador ||--o{ Contrato_salarial : "tem (1:N)"
    Colaborador ||--o{ Evidencia : "registra (1:N)"
    Colaborador ||--o| Usuario : "tem (1:0..1)"
    
    Contrato ||--o{ Aditivo : "possui (1:N)"
    Contrato ||--o{ Alocacao : "tem (1:N)"
    Contrato ||--o{ Apontamento_de_horas : "possui (1:N)"
    Contrato ||--o{ Aprovacao : "possui (1:N)"
    Contrato }o--o{ Certificacao : "exige (N:N)"
    Contrato ||--o{ Evidencia : "tem (1:N)"
    Contrato ||--o{ Fatura : "produz (1:N)"
    Contrato }o--o{ Provedor_de_nuvem : "utiliza (N:N)"
    Contrato }o--o{ Tag : "tem (N:N)"
    
    Fatura ||--o{ Pagamento : "tem (1:N)"
    
    Oportunidade }o--o{ Certificacao : "exige (N:N)"
    Oportunidade ||--o| Contrato : "gera (1:0..1)"
    Oportunidade }o--o{ Servico : "envolve (N:N)"
    
    Servico }o--o{ Contrato : "envolve (N:N)"
    
    Usuario ||--o{ Aprovacao : "realiza (1:N)"
    Usuario }o--o{ Permissao : "precisa (N:N)"
    Usuario }o--|| Perfil_de_acesso : "possui (N:1)"
    Usuario }o--o{ Tag : "tem (N:N)"
