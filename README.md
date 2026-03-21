# latex-abnt

Implementação independente de classes e pacotes LaTeX para produção de documentos acadêmicos conforme as normas ABNT vigentes.

## Status

Em desenvolvimento inicial. O primeiro documento contemplado é o **Projeto de Pesquisa** (ABNT NBR 15287:2025).

O repositório contém atualmente apenas um esboço inicial do pacote `ibge-tabular.sty` (v0.1.0), que demonstra a arquitetura planejada mas não constitui uma implementação completa.

## Motivação

O abnTeX2 é o projeto de referência para LaTeX acadêmico no Brasil, mas apresenta limitações estruturais que dificultam sua atualização:

- Última release em novembro de 2018, enquanto várias normas foram revisadas desde então (NBR 10520:2023, NBR 14724:2024, NBR 6023:2025)
- Classe construída sobre `memoir`, com arquitetura que acumula décadas de dívida técnica
- Estilos bibliográficos implementados em BibTeX, uma linguagem de pilha dos anos 1980 de difícil leitura e manutenção — situação reconhecida pela própria equipe do projeto, que aponta o `biblatex-abnt` como substituto

Este projeto não é uma crítica ao abnTeX2, que cumpriu e ainda cumpre papel importante. É uma alternativa construída do zero com base nas normas atualmente vigentes e em ferramentas modernas do ecossistema LaTeX.

## Arquitetura

O projeto segue a separação canônica do LaTeX entre **classes** (`.cls`) e **pacotes** (`.sty`):

- Uma **classe** por tipo de documento (ex.: `abnt-projeto-pesquisa.cls`), responsável pela estrutura completa: margens, capa, folha de rosto, sumário, paginação
- **Pacotes** modulares e independentes de classe (ex.: `ibge-tabelas.sty`), que podem ser usados em qualquer documento que precise daquela funcionalidade específica

Toda a lógica programática interna é implementada em **`expl3`**, a camada moderna do LaTeX3, com sintaxe legível e separação clara entre interface pública e implementação.

### Estrutura planejada

```
latex-abnt/
├── src/                          # Código-fonte LaTeX
│   ├── abnt.cls                  # Classe base (comum a todos os documentos ABNT)
│   ├── abnt-projeto-pesquisa.cls # Classe: Projeto de Pesquisa (NBR 15287:2025)
│   ├── ibge-tabelas.sty          # Pacote: tabelas (IBGE 1993)
│   ├── abnt-refs.sty             # Pacote: referências (NBR 6023)
│   ├── abnt-citacoes.sty         # Pacote: citações (NBR 10520)
│   ├── abnt-sumario.sty          # Pacote: sumário (NBR 6027)
│   ├── abnt-numeracao.sty        # Pacote: numeração progressiva (NBR 6024)
│   ├── abnt-indice.sty           # Pacote: índice (NBR 6034)
│   └── abnt-lombada.sty          # Pacote: lombada (NBR 12225)
├── templates/                    # Documentos de exemplo
│   └── projeto-pesquisa/
│       ├── main.tex
│       └── refs.bib
└── tests/                        # Testes visuais por norma
    └── (um .tex mínimo por pacote/classe)
```

Os arquivos `.cls` e `.sty` ficam em `src/`. A compilação requer que o diretório `src/` esteja no `TEXINPUTS` (o Tectonic pode ser configurado para isso via `Tectonic.toml`).

### Compatibilidade de engines

O projeto suporta **XeLaTeX** e **pdfLaTeX**. Toda a validação e certificação é feita com o **Tectonic** (que usa XeLaTeX internamente).

### Dependências principais

| Pacote | Função |
|---|---|
| `expl3` | Lógica interna de todos os módulos |
| `tabularray` | Estrutura e estilo de tabelas (nativo em `expl3`) |
| `siunitx` | Formatação de dados numéricos e unidades de medida |
| `biblatex` + `biblatex-abnt` | Citações e referências (não reimplementado aqui) |
| `caption` | Formatação de títulos de tabelas e figuras |

### Relação com o biblatex-abnt

Este projeto **não reimplementa** estilos de citação e referência bibliográfica. Para isso, adota o [`biblatex-abnt`](https://github.com/abntex/biblatex-abnt) como dependência — projeto ativo, moderno e mantido separadamente. As classes deste repositório apenas configuram o `biblatex-abnt` com os parâmetros exigidos por cada norma.

## Normas contempladas

### Em implementação

- **ABNT NBR 15287:2025** — Projeto de pesquisa

### Referências normativas da NBR 15287:2025

As normas abaixo são listadas na seção 2 da NBR 15287:2025 como **referências normativas** — ou seja, constituem requisitos obrigatórios, não meramente informativos, para quem implementa aquela norma.

- ABNT NBR 6023:2025 — Referências
- ABNT NBR 6024:2012 — Numeração progressiva das seções
- ABNT NBR 6027:2012 — Sumário
- ABNT NBR 6034:2004 — Índice
- ABNT NBR 10520:2023 — Citações em documentos
- ABNT NBR 12225:2023 — Lombada
- **IBGE — Normas de Apresentação Tabular (3ª ed., 1993)** — esboço inicial no pacote `ibge-tabular.sty`

A norma IBGE é referência normativa da NBR 15287 com o mesmo status das demais: a seção 5.9 da NBR 15287:2025 determina que tabelas devem ser "padronizadas conforme as normas de apresentação tabular do Instituto Brasileiro de Geografia e Estatística (IBGE)". A distinção relevante é de origem institucional (IBGE, não ABNT) e de escopo de implementação: o pacote `ibge-tabular.sty` é um esboço inicial (v0.1.0) que demonstra a arquitetura planejada — moldura, sinais convencionais, séries temporais, classes de frequência e rodapé — mas ainda não constitui uma implementação completa da norma. O pacote poderá ser usado em qualquer documento que precise dessas convenções, independentemente da NBR 15287.

## Licença

[LPPL 1.3c](https://www.latex-project.org/lppl/lppl-1-3c.html) — LaTeX Project Public License, versão 1.3c.

Esta é a licença padrão do ecossistema LaTeX, adotada também pelo abnTeX2 e pelo biblatex-abnt. Permite uso, modificação e redistribuição, com a obrigação de renomear arquivos modificados.
