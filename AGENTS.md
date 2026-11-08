# AGENTS.md — Urbs Stellata

Instruções para qualquer agente de IA (Codex, Cursor, Copilot, Claude etc.).

## Antes de começar
1. Leia `production/devlog.md`: estado atual, decisões e o que já foi feito.
2. Leia `design/game-brief.md`: o design do jogo em uma página.
3. Leia `project.yaml`: engine, rigor, comandos. É a fonte de verdade da configuração.
4. `CLAUDE.md` tem as regras completas do framework (Claude Code Game Studios).

## Regras principais
- Pergunte antes de criar ou alterar arquivos e mostre o rascunho antes.
- Não faça commit sem pedido explícito.
- Godot 4.7.2 com GDScript. Antes de usar uma API do Godot, consulte
  `docs/engine-reference/godot/` (a 4.7 é mais nova que o treino da maioria dos modelos).
- Código novo vai em `src/`. `stellata/` é um protótipo antigo, só para referência.
- Nomes: classes em PascalCase; variáveis, funções, arquivos e cenas em snake_case;
  sinais no passado (`health_changed`); constantes em UPPER_SNAKE_CASE.

## Ao terminar um passo importante
Adicione uma entrada no topo de "Entradas" em `production/devlog.md`
(data, quem, o que foi feito, pendências) e atualize "Estado atual" e "Decisões" se mudaram.
