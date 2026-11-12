# Briefings para distribuição por função — Atlas-Harness v0.1

**Data:** 12/11/2026 | **Estado:** material de alinhamento **ainda não distribuído**, sem autorização de deploy.\n\n**ADDENDUM:** a VPS atual é laboratório e pode ser reorganizada após inventário, backups e GO específico; consultar [ADR-0003](adr/0003-lab-consolidation-aws-gwd-rollout.md).
**Diretiva principal:** https://github.com/sergiomonteiro-atlas/Atlas-Harness/blob/main/docs/team-directive-2026-11-12.md
**Confirmações:** https://github.com/sergiomonteiro-atlas/Atlas-Harness/issues/1

Estas mensagens podem ser distribuídas nos canais empresariais adequados. A existência do ficheiro **não comprova entrega** a nenhum destinatário.

## 1. Conselho e Direção Executiva

**Assunto: Atlas-Harness — validação da arquitetura empresarial**

Foi aprovada como orientação de arquitetura a construção do Atlas-Harness: plataforma AI-Native com Atlas-Bot (governação e interface), Atlas-Agent (execução), Memory Fabric, Operational Knowledge e Workforce. O produto será estruturado publicamente, com limites de autonomia, auditoria, segregação por BU e componentes substituíveis. Solicitamos revisão da ADR-0001, objetivos e limites de risco. Produção, AWS e canais comerciais necessitam de aprovação operacional distinta.

## 2. Infraestrutura — Helena

**Assunto: Preparação AWS / Atlas-Harness, inventário sem alterações**

A nova arquitetura Atlas-Harness está validada para desenvolvimento. A VPS AtlasHub existente poderá funcionar como **LAB de onboarding**, depois de auditoria de capacidade e preservação das configurações LearnHouse/CRM/ARO/Helena. A AWS é candidata à **instalação GWD de referência** se os créditos e custos forem validados. Prioridade: verificar o programa incubador/AWS Activate e créditos efetivamente atribuídos, custos estimados, permissões/IAM, backup, redes e monitorização; criar plano de staging e respetivos GO gates. Não parar serviços, apagar volumes, alterar DNS nem provisionar recursos com custo sem autorização específica. Documentar bloqueios em https://github.com/sergiomonteiro-atlas/Atlas-Harness/issues/2, mantendo dados de billing/credenciais fora do GitHub público.

## 3. Engenharia — Atlas-Bot

**Assunto: Definição do plano de integração do Control Plane**

O fork de OpenBot passa a constituir Atlas-Bot, superfície empresarial e ponto de autorização de tarefas. Rever identidade, políticas, aprovação, auditoria, AG-UI e dependência/licença separada do CopilotKit Intelligence. Não presumir compatibilidade direta com Atlas-Agent. Entregar proposta de interface e testes de missão read-only em https://github.com/sergiomonteiro-atlas/Atlas-Harness/issues/4.

## 4. Engenharia — Atlas-Agent

**Assunto: Motor de execução com autoridade delegada**

O fork de Hermes é o Atlas-Agent, runtime de tarefas e especialistas. O Control Plane Atlas define missão, escopo e orçamento; subagentes herdam esse escopo. Mapear API, aprovação de ferramentas, isolamentos, retries e relatórios; propor adaptador Atlas-Bot ↔ Atlas-Agent para piloto read-only em https://github.com/sergiomonteiro-atlas/Atlas-Harness/issues/5. Não ativar acesso irrestrito a shell, produção ou canais externos.

## 5. Memória / Knowledge / Workforce

**Assunto: Separação das memórias e identidade empresarial**

Implementar a distinção entre memória executiva, RH/interna, conhecimento operacional aprovado, dados transacionais do CRM e memória de sessão. Atlas-Memory-Fabric deve aplicar políticas de pesquisa; Atlas-Operational-Knowledge contém documentação versionada; Atlas-Workforce define os papéis/Souls/skills. Entregar um catálogo de três papéis de piloto e testes de acesso restrito por BU em https://github.com/sergiomonteiro-atlas/Atlas-Harness/issues/6.

## 6. QA / Segurança

**Assunto: Gates de segurança e evidência para primeiro vertical slice**

Auditar acesso entre BUs, prompt injection, autorização de ferramentas, custos, cancelamentos, memória expirada, retenção e origem das respostas. Só aprovar o primeiro piloto quando houver evidência de fluxo read-only completo e capacidade de recuperação segura. Registar riscos e aprovação em https://github.com/sergiomonteiro-atlas/Atlas-Harness/issues/7.

## 7. Diretores de BU e responsáveis por produtos

**Assunto: O Atlas-Harness não absorve os produtos operacionais das BUs**

AtlasClub/Academy, ARO, CRM e demais plataformas continuam com autonomia operacional e fonte de verdade dos próprios dados. Passam a integrar o Atlas-Harness através de contratos e autorizações explícitas. Nesta fase, identificar um fluxo real para **simulação com dados fictícios** e um diretor responsável. Não introduzir clientes, pagamentos ou mensagens reais nos pilotos.

## Registo da confirmação

Cada responsável deve registar `ACK`, nome/função, data, riscos e próxima entrega no issue de alinhamento, ou no canal empresarial apropriado, com referência à decisão. Nenhuma equipa deve afirmar implantação concluída por ter criado um fork ou publicado um documento.
