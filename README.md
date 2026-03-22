# latex-abnt

**Esta introdução foi integralmente escrita por um ser humano, sem nenhuma interferência, opinião, correção ou qualquer contribuição baseada em IA**

Este projeto implementa classes e pacotes LaTeX para gerar documentos no formato determinado pelas normas ABNT NBR exigidas por instituições acadêmicas no Brasil.

Esta foi uma experiênca pessoal bem-sucedida para implementar praticamente do zero essa conformidade utilizando o Claude Code com o modelo Opus 4.6.

Disciplinei a implementação com requisitos de qualidade do código LaTeX e incluí testes para verificação visual. Realizei inúmeras intervenções quando vi que a ferramenta não estava indo pelo caminho certo, mas não toquei em quase nada do código.

Após os testes, fiquei seguro de utilizar estas classes para meus próprios documentos, no entanto recomendo cautela. Este código não tem o mesmo histórico de testes do excelente projeto em `https://github.com/fga-unb/template-latex-tcc` e provavelmente já existe um modelo no OverLeaf com o padrão que você precisa. No futuro, se eu estiver convencido de que este projeto apresenta alguma vantagem definitiva sobre os demais, alterarei esta parte do texto.

Fora desta seção, considere que tudo foi gerado pelo Claude sob minha supervisão.

## Classes

| Classe                        | Documento                 | Norma          |
| ----------------------------- | ------------------------- | -------------- |
| `abnt-trabalho-academico.cls` | Teses, dissertações, TCCs | NBR 14724:2024 |
| `abnt-projeto-pesquisa.cls`   | Projetos de pesquisa      | NBR 15287:2025 |

Ambas herdam de `abnt.cls` (classe base com margens, capa, folha de rosto, paginação e espaçamento). O projeto inclui também variantes institucionais para a Universidade de Brasília (`abnt-unb-*.cls`).

## Pacotes

Os pacotes são modulares e podem ser usados independentemente das classes.

| Pacote               | Norma                                 |
| -------------------- | ------------------------------------- |
| `abnt-numeracao.sty` | NBR 6024:2012 — Numeração progressiva |
| `abnt-sumario.sty`   | NBR 6027:2012 — Sumário               |
| `abnt-resumo.sty`    | NBR 6028:2021 — Resumo e abstract     |
| `abnt-indice.sty`    | NBR 6034:2004 — Índice                |
| `abnt-refs.sty`      | NBR 6023:2025 — Referências           |
| `abnt-citacoes.sty`  | NBR 10520:2023 — Citações             |
| `ibge-tabelas.sty`   | IBGE 1993 — Tabelas                   |
| `abnt-quadros.sty`   | NBR 14724:2024 — Quadros              |
| `abnt-lombada.sty`   | NBR 12225:2023 — Lombada              |

Citações e referências bibliográficas são delegadas ao [`biblatex-abnt`](https://github.com/abntex/biblatex-abnt); este projeto apenas o configura com os parâmetros de cada norma.

## Exemplo mínimo

```latex
\documentclass{abnt-trabalho-academico}
\usepackage{abnt-resumo}
\usepackage{abnt-citacoes}   % carrega abnt-refs automaticamente

\addbibresource{refs.bib}

\titulo{Título do Trabalho}
\autor{Nome do Autor}
\orientador{Nome do Orientador}
\instituicao{Universidade}
\local{Cidade}
\ano{2026}
\natureza{Dissertação apresentada ao Programa de Pós-Graduação
  em X da Universidade Y como requisito parcial para obtenção
  do título de Mestre em X.}
\programa{Programa de Pós-Graduação em X}

\begin{document}
\imprimircapa
\imprimirfolhaderosto
\imprimirsumario

\chapter{Introdução}
Texto da introdução \cite{referencia}.

\postextual
\printbibliography
\end{document}
```

## Templates

Cada classe tem um template pronto para uso em `templates/`:

| Diretório | Classe | Descrição |
|---|---|---|
| `trabalho-academico/` | `abnt-trabalho-academico` | Trabalho acadêmico genérico |
| `projeto-pesquisa/` | `abnt-projeto-pesquisa` | Projeto de pesquisa genérico |
| `unb-A/` | `abnt-unb-A` | UnB — Modelo A (engenharia, capa com faixa azul) |
| `unb-B/` | `abnt-unb-B` | UnB — Modelo B (clássico) |
| `unb-projeto-pesquisa/` | `abnt-unb-projeto-pesquisa` | UnB — Projeto de pesquisa |

## Como usar

### Uso local

Clone o repositório e compile qualquer template apontando `TEXINPUTS` para `src/`:

```bash
git clone https://github.com/seu-usuario/latex-abnt.git
cd latex-abnt

# Compilar um template:
TEXINPUTS=./src: latexmk -pdf templates/trabalho-academico/main.tex
```

Para seus próprios documentos, basta manter o caminho até `src/` no `TEXINPUTS`:

```bash
TEXINPUTS=/caminho/para/latex-abnt/src: latexmk -pdf meu-documento.tex
```

### Uso no Overleaf

O script `scripts/overleaf-zip.sh` gera um `.zip` pronto para upload no Overleaf, contendo o template escolhido e todos os arquivos `.cls`/`.sty` necessários:

```bash
./scripts/overleaf-zip.sh trabalho-academico
# Criado: dist/latex-abnt-trabalho-academico.zip
```

No Overleaf: **Novo Projeto > Carregar Projeto > selecione o .zip**. Em **Menu > Compiler**, selecione **pdfLaTeX**. O Overleaf já inclui o `biblatex-abnt` na sua distribuição TeX Live.

## Documentação

O guia do usuário em `templates/guia-usuario/main.tex` é simultaneamente o manual de referência de todos os comandos e um exemplo compilável de trabalho acadêmico ABNT válido.

## Licença

[LPPL 1.3c](https://www.latex-project.org/lppl/lppl-1-3c.html) — LaTeX Project Public License, versão 1.3c.
