# Devlog — Urbs Stellata

Diário compartilhado do projeto. Toda pessoa (e todo agente de IA) lê isto
antes de começar e adiciona uma entrada ao terminar um passo importante.
Entradas mais novas no topo da seção "Entradas".

## Como se localizar (leia nesta ordem)
1. `CLAUDE.md` — regras do framework (Claude Code Game Studios)
2. `project.yaml` — configuração: engine, rigor, automação, comandos
3. `design/game-brief.md` — o jogo em uma página (é o design inteiro no rigor minimal)
4. Este devlog — o que já foi feito, decisões e próximos passos

Os comandos (`/create-stories`, `/dev-story`...) estão em `.claude/skills/`.
Funcionam no Claude Code aberto na raiz do repositório.

## Estado atual
- Estágio: Concept · Rigor: minimal · Automação: collaborative
- Engine: Godot 4.7.2, GDScript, Forward+, Godot Physics 2D, só PC, teclado/mouse
- Projeto Godot na raiz (`project.godot`); o código novo vai em `src/`
- `stellata/` = protótipo antigo (player com rolamento e ataques leve/pesado, arena de teste), mantido como referência
- Testes: estrutura em `tests/`, GdUnit4 em `addons/`, CI em `.github/workflows/tests.yml`
- Próximo passo: `/create-stories` → `/dev-story`

## Decisões
| Data | Decisão | Por quê |
|---|---|---|
| 2026-11-07 | Rigor minimal | Jogo curto; o brief de uma página substitui os GDDs |
| 2026-11-07 | Arte 2D de cima, estilo Fear and Hunger | Correção do "2.5D" inicial |
| 2026-11-07 | Blasphemous como referência de combate e mundo | Fear and Hunger é por turnos |
| 2026-11-07 | Projeto Godot na raiz, stellata/ só como referência | O framework espera project.godot na raiz e código em src/ |
| 2026-11-07 | Build sem export preset ainda | Configurar no /settings quando existir um preset |

## Entradas

### 2026-11-07 — Levi (com Claude)
- /start: estágio Concept, rigor minimal, automação collaborative
- /brainstorm: escrito design/game-brief.md (cidade interligada, hub, 3 anjos caídos, chefe final; MVP com 7 itens)
- /setup-engine: Godot 4.7.2 + GDScript; project.godot criado na raiz; caminho do editor em project.yaml (engine.path é da máquina do Levi)
- /test-setup: tests/, production/qa/evidence/, CI do GdUnit4
- Criado este devlog e o AGENTS.md
- Pendências: export preset; quem clonar ajusta engine.path no próprio project.local.yaml
