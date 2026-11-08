# Game Brief: Urbs Stellata

**One-sentence pitch:** Explore uma cidade em ruínas sob estrelas apagadas, toda interligada, e derrote três anjos caídos para chegar a quem apagou o céu.

## Core loop
- Sair do hub para uma região e lutar contra inimigos com stamina, rolamento e ataques leve e pesado
- Morrer, deixar a "luz estelar" no chão e voltar para recuperá-la; abrir atalhos que ligam a região ao hub
- Gastar a luz estelar no altar-estrela para subir de nível
- Derrotar o anjo caído da região, o que libera o próximo caminho

## Player goal & fail state — what "working" looks like
- Objetivo: derrotar os 3 anjos caídos e o chefe final. Uma sessão parece completa ao derrotar um anjo ou abrir um atalho.
- Falha: a vida chega a zero, o jogador volta ao último altar e a luz estelar fica no lugar da morte. Se morrer de novo antes de recuperá-la, ela se perde de vez.

## MVP — what must exist to be the game
1. Combate do player: ataque leve e pesado, rolamento com invencibilidade, stamina, vida e cura limitada
2. Altar-estrela: checkpoint, recarrega a cura, faz os inimigos reaparecerem e permite subir de nível com luz estelar
3. Morte e recuperação da luz estelar
4. Hub e 3 regiões interligadas, com pelo menos um atalho por região
5. 2 a 3 tipos de inimigo comum com IA simples
6. 3 anjos caídos (chefes) com padrões de ataque legíveis
7. Chefe final e tela de fim

## Out of scope — not building this
- Multiplayer e invasões
- Mais de uma arma, builds e equipamentos
- Magia e itens arremessáveis
- NPCs com quests e diálogos longos
- NG+, finais múltiplos e mapa ou minimapa
- Dublagem

## Build order
1. Combate do player contra um alvo na arena de teste (já começou), para provar que é gostoso antes de tudo
2. Um inimigo comum, mais morte, altar e recuperação da luz estelar
3. O primeiro anjo caído na arena, para provar a luta de chefe
4. Hub e a primeira região, com atalho
5. Regiões 2 e 3, com os anjos 2 e 3
6. Chefe final e tela de fim

---
**Who it's for / what they feel:** fãs de soulslike que querem uma jornada sombria e completa em 2 a 3 horas: tensão ao explorar e alívio ao abrir um atalho.

**Art & audio direction:** pixel art 2D dark fantasy em visão de cima, no estilo de Fear and Hunger: sprites pequenos e crus, cenários sombrios e opressivos, paleta escura e dessaturada com ouro sacro e luz estelar fria; coral sacro e ambiente grave.

**Reference game:** Blasphemous: o combate corpo a corpo punitivo e os chefes num mundo interligado. O MVP mantém uma arma, 3 chefes mais o final e nenhum sistema extra.
