# latex-abnt

**Esta introdução foi integralmente escrita por um ser humano, sem nenhuma interferência, opinião, correção ou qualquer contribuição baseada em IA**

Este projeto implementa classes e pacotes LaTeX para gerar documentos no formato determinado pelas normas ABNT NBR exigidas por instituições acadêmicas no Brasil.

Esta foi uma experiênca pessoal bem-sucedida para implementar praticamente do zero essa conformidade utilizando o Claude Code com o modelo Opus 4.6.

Disciplinei a implementação com requisitos de qualidade do código LaTeX e incluí testes para verificação visual. Realizei inúmeras intervenções quando vi que a ferramenta não estava indo pelo caminho certo, mas não toquei em quase nada do código.

Após os testes, fiquei seguro de utilizar estas classes para meus próprios documentos, no entanto recomendo cautela. Este código não tem o mesmo histórico de testes do excelente projeto em `https://github.com/fga-unb/template-latex-tcc` e provavelmente já existe um modelo no OverLeaf com o padrão que você precisa. No futuro, se eu estiver convencido de que este projeto apresenta alguma vantagem definitiva sobre os demais, alterarei esta parte do texto.

Fora desta seção, considere que tudo foi gerado pelo Claude sob minha supervisão.

## Status

Em desenvolvimento. Os dois tipos de documento contemplados são:

- **Trabalho acadêmico** (ABNT NBR 14724:2024) — teses, dissertações, TCCs e similares
- **Projeto de pesquisa** (ABNT NBR 15287:2025)

Todos os pacotes planejados estão implementados e testados:

| Pacote | Norma | Versão |
|---|---|---|
| `abnt-numeracao.sty` | NBR 6024:2012 | 1.0.0 |
| `abnt-sumario.sty` | NBR 6027:2012 | 1.0.0 |
| `abnt-resumo.sty` | NBR 6028:2021 | 1.0.0 |
| `abnt-indice.sty` | NBR 6034:2004 | 1.0.0 |
| `abnt-refs.sty` | NBR 6023:2025 | 1.0.0 |
| `abnt-citacoes.sty` | NBR 10520:2023 | 1.0.0 |
| `ibge-tabelas.sty` | IBGE 1993 | 1.0.0 |
| `abnt-lombada.sty` | NBR 12225:2023 | 1.0.0 |

## Motivação

O abnTeX2 é o projeto de referência para LaTeX acadêmico no Brasil, mas apresenta limitações estruturais que dificultam sua atualização:

- Última release em novembro de 2018, enquanto várias normas foram revisadas desde então (NBR 10520:2023, NBR 14724:2024, NBR 6023:2025)
- Classe construída sobre `memoir`, com arquitetura que acumula décadas de dívida técnica
- Estilos bibliográficos implementados em BibTeX, uma linguagem de pilha dos anos 1980 de difícil leitura e manutenção — situação reconhecida pela própria equipe do projeto, que aponta o `biblatex-abnt` como substituto

Este projeto não é uma crítica ao abnTeX2, que cumpriu e ainda cumpre papel importante. É uma alternativa construída do zero com base nas normas atualmente vigentes e em ferramentas modernas do ecossistema LaTeX.

## Arquitetura

O projeto segue a separação canônica do LaTeX entre **classes** (`.cls`) e **pacotes** (`.sty`):

- Uma **classe** por tipo de documento, responsável pela estrutura completa: margens, capa, folha de rosto, sumário, paginação
- **Pacotes** modulares e independentes de classe, que podem ser usados em qualquer documento que precise daquela funcionalidade específica

Toda a lógica programática interna é implementada em **`expl3`**, a camada moderna do LaTeX3, com sintaxe legível e separação clara entre interface pública e implementação.

### Estrutura planejada

```
latex-abnt/
├── src/                               # Código-fonte LaTeX
│   ├── abnt.cls                       # Classe base (comum a todos os documentos ABNT)
│   ├── abnt-trabalho-academico.cls    # Classe: Trabalho Acadêmico (NBR 14724:2024)
│   ├── abnt-projeto-pesquisa.cls      # Classe: Projeto de Pesquisa (NBR 15287:2025)
│   ├── ibge-tabelas.sty              # Pacote: tabelas (IBGE 1993)
│   ├── abnt-refs.sty                  # Pacote: referências (NBR 6023)
│   ├── abnt-citacoes.sty              # Pacote: citações (NBR 10520)
│   ├── abnt-sumario.sty               # Pacote: sumário (NBR 6027)
│   ├── abnt-numeracao.sty             # Pacote: numeração progressiva (NBR 6024)
│   ├── abnt-indice.sty                # Pacote: índice (NBR 6034)
│   ├── abnt-resumo.sty                # Pacote: resumo e abstract (NBR 6028)
│   └── abnt-lombada.sty               # Pacote: lombada (NBR 12225)
├── templates/                         # Documentos de exemplo
│   ├── trabalho-academico/
│   │   ├── main.tex
│   │   └── refs.bib
│   └── projeto-pesquisa/
│       ├── main.tex
│       └── refs.bib
└── tests/                             # Testes visuais por norma
    └── (um .tex mínimo por pacote/classe)
```

Os arquivos `.cls` e `.sty` ficam em `src/`. A compilação requer que o diretório `src/` esteja no `TEXINPUTS`:

```bash
export TEXINPUTS=./src:
latexmk -pdf tests/test-abnt-numeracao.tex
```

### Compatibilidade de engines

O projeto suporta **pdfLaTeX** e **XeLaTeX**. A validação é feita com **TeX Live 2023** (pdfLaTeX + Biber 2.19).

### Dependências principais

| Pacote | Função |
|---|---|
| `expl3` | Lógica interna de todos os módulos |
| `imakeidx` | Geração e processamento de índices |
| `tabularray` | Estrutura e estilo de tabelas (nativo em `expl3`) |
| `siunitx` | Formatação de dados numéricos e unidades de medida |
| `biblatex` + `biblatex-abnt` | Citações e referências (não reimplementado aqui) |
| `caption` | Formatação de títulos de tabelas e figuras |

### Relação com o biblatex-abnt

Este projeto **não reimplementa** estilos de citação e referência bibliográfica. Para isso, adota o [`biblatex-abnt`](https://github.com/abntex/biblatex-abnt) como dependência — projeto ativo, moderno e mantido separadamente. As classes deste repositório apenas configuram o `biblatex-abnt` com os parâmetros exigidos por cada norma.

## Normas contempladas

### Em implementação

- **ABNT NBR 14724:2024** — Trabalhos acadêmicos (teses, dissertações, TCCs)
- **ABNT NBR 15287:2025** — Projeto de pesquisa

### Relação entre as normas

As duas normas compartilham a mesma estrutura geral (parte externa + parte interna com elementos pré-textuais, textuais e pós-textuais) e referenciam o mesmo conjunto de normas auxiliares, com uma diferença:

| Aspecto | NBR 14724 (Trabalho acadêmico) | NBR 15287 (Projeto de pesquisa) |
|---|---|---|
| Capa | Obrigatória | Opcional |
| Folha de rosto | Obrigatória | Obrigatória |
| Folha de aprovação | Obrigatória | — |
| Errata | Opcional | — |
| Dedicatória | Opcional | — |
| Agradecimentos | Opcional | — |
| Epígrafe | Opcional | — |
| Resumo (vernácula) | Obrigatório | — |
| Resumo (estrangeira) | Obrigatório | — |
| Listas (ilustrações, tabelas, siglas, símbolos) | Opcionais | Opcionais |
| Sumário | Obrigatório | Obrigatório |
| Referências | Obrigatórias | Obrigatórias |
| Glossário, apêndice, anexo, índice | Opcionais | Opcionais |

A NBR 14724 é a norma mais completa e exigente; a NBR 15287 é um subconjunto estrutural com elementos pré-textuais reduzidos. A arquitetura do projeto reflete isso: `abnt-trabalho-academico.cls` implementa o conjunto completo, e `abnt-projeto-pesquisa.cls` reutiliza o que for aplicável.

### Referências normativas comuns

Ambas as normas referenciam o seguinte conjunto (requisitos obrigatórios, não meramente informativos):

- ABNT NBR 6023 — Referências
- ABNT NBR 6024 — Numeração progressiva das seções
- ABNT NBR 6027 — Sumário
- ABNT NBR 6034 — Índice
- ABNT NBR 10520 — Citações em documentos
- ABNT NBR 12225 — Lombada
- IBGE — Normas de Apresentação Tabular (3ª ed., 1993)

A NBR 14724 adiciona:

- ABNT NBR 6028 — Resumo, resenha e recensão

## Licença

[LPPL 1.3c](https://www.latex-project.org/lppl/lppl-1-3c.html) — LaTeX Project Public License, versão 1.3c.

Esta é a licença padrão do ecossistema LaTeX, adotada também pelo abnTeX2 e pelo biblatex-abnt. Permite uso, modificação e redistribuição, com a obrigação de renomear arquivos modificados.
