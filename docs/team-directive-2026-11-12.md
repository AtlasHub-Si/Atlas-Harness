# DIRETIVA OFICIAL — Evolução para o Atlas-Harness

**Emissão:** 12/11/2026 | **Estado:** Orientação estratégica validada; implementação faseada.
**Fonte canónica:** `sergiomonteiro-atlas/Atlas-Harness` (este repositório).
**Destinatários:** Conselho, Direção Executiva, Diretores das BUs, Shared Services, Infraestrutura/Helena, Engenharia, agentes de desenvolvimento, Arquitetura e QA.

## Decisão comunicada

A AtlasHub consolida a visão de **Empresa AI-Native** no projeto original público **Atlas-Harness**. A empresa deixará de tratar cada agente, chatbot ou aplicação como um sistema de governação autónomo. A organização passa a ter um único contrato de missão e autorização, com componentes especializados e substituíveis.

**Divisão de responsabilidades validada:**

- **Atlas-Bot:** interface empresarial para Conselho, Diretores e supervisão; entrada de missões, políticas, aprovações, relatórios e auditoria.
- **Atlas-Agent:** runtime de execução de agentes, ferramentas e subequipas com escopo delegado.
- **Atlas-Memory-Fabric:** memória empresarial partilhável mediante permissões, proveniência e classificação.
- **Atlas-Operational-Knowledge:** procedimentos, scripts, produtos e FAQs aprovados; edição em Markdown/Obsidian quando conveniente.
- **Atlas-Workforce:** papéis, Souls, skills e modelo de organização.
- **Atlas-WorkSwarms:** investigação de swarms; não integra a primeira produção.
- **Atlas-Crm-OS:** candidato a aplicação de Sales OS por BU, não motor central.
- **Atlas-Harness:** arquitetura e contratos públicos; fonte de verdade para decisões de integração e roadmap.

## Instruções por interveniente

| Interveniente | Entregável imediato | Não autorizado nesta fase |
| --- | --- | --- |
| Conselho / sponsor | Validar prioridades, critérios de risco e limites de autonomia | Anunciar produção concluída sem evidência |
| Arquitetura / Engenharia Lead | Rever ADR-0001 e mapa de contratos; propor interfaces mínimas | Criar novo orquestrador concorrente |
| Infraestrutura / Helena | Inventário de AWS incubator, regiões, quotas, estimativa, IAM e segregação; produzir staging plan | Tocar VPS AtlasHub atual ou implantar sem GO técnico |
| Atlas-Bot team | Inventariar dependências do fork, Intelligence license e entradas de approval | Assumir independência do fork sem validação |
| Atlas-Agent team | Inventariar API, perfis, sandbox, tool approval e execução delegada; plano de adaptador | Ligar shell/SSH à produção, bypass de políticas |
| Memory / Knowledge team | Especificar separação executiva, RH, operações e clientes; publicar piloto BU03 fictício | Inserir dados reais de RH/clientes em GitHub |
| Workforce / HR design | Definir funções, slugs, owner por departamento, escalonamento e limites | Tratar prompt/Soul como autorização |
| Segurança / QA | Redigir ameaça, testes de isolamento, eventos, auditoria e plano de rollback | Certificar features por afirmações de LLM |
| BU owners | Inventariar sistemas de verdade e 1 fluxo de piloto representativo | Ligar canais e transações reais no piloto |

## Protocolo de alinhamento

1. Cada responsável revê a documentação principal e abre uma issue `[Review] <area> — proposta e bloqueios` com responsáveis, riscos, dependências e evidências.
2. Divergências arquiteturais exigem ADR/PR. O README e a ADR-0001 são a direção vigente até decisão formal substitutiva.
3. Nenhuma instrução deste documento autoriza automaticamente ações irreversíveis.
4. Infraestrutura nova na AWS só após verificação dos créditos, custo, acesso, segurança e autorização operacional.
5. Primeiro marco: missão de **leitura apenas**, de ponta a ponta, com um agente e base de conhecimento fictícia.

## Confirmações esperadas

- [ ] Conselho / Executive Lead: aceite
- [ ] Infraestrutura / Helena: plano e capacidade
- [ ] Engenharia / Atlas-Bot: viabilidade e dependências
- [ ] Engenharia / Atlas-Agent: viabilidade de ponte
- [ ] Memory / Knowledge: modelo de permissão
- [ ] Segurança / QA: gates de aceitação
- [ ] Representante BU piloto: produto fictício e validação

**Nota de comunicação:** a publicação desta diretiva em GitHub é documentação oficial, **não prova que cada destinatário tenha recebido e confirmado**. Confirmação efetiva deve ser registada na issue de alinhamento ou no canal empresarial conectado.
