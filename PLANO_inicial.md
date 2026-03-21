# Plano: Estrutura inicial do projeto latex-abnt

## Contexto

O projeto latex-abnt é uma implementação independente de classes e pacotes LaTeX para documentos acadêmicos conforme ABNT. O primeiro documento-alvo é o Projeto de Pesquisa (NBR 15287:2025). O projeto deve suportar XeLaTeX e pdfLaTeX, com validação e certificação exclusivamente via Tectonic. A arquitetura é modular (classe .cls + pacotes .sty separados por norma) para facilitar expansão futura a outros tipos de documento e permitir testes individuais por norma.

Toda a lógica programática interna usa `expl3` (`\ProvidesExplClass`, `\ProvidesExplPackage`).

## Estrutura de pastas proposta

```
latex-abnt/
├── CLAUDE.md
├── README.md
├── .gitignore
├── Tectonic.toml                 # Configuração do Tectonic
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
│       ├── main.tex              # Template preenchido de exemplo
│       └── refs.bib              # Referências de exemplo
└── tests/                        # Testes visuais por norma
    └── (um .tex mínimo por pacote/classe)
```

## Plano de implementação (Fase 1 — esqueleto funcional)

### 1. ~~Criar estrutura de pastas e mover arquivos~~ ✅
- ~~Criar `src/`, `templates/projeto-pesquisa/`, `tests/`~~
- ~~Mover `ibge-tabular.sty` para `src/ibge-tabelas.sty` (renomear)~~
- ~~Atualizar `.gitignore`~~

### 2. ~~Configurar Tectonic~~ ✅
- ~~`Tectonic.toml` na raiz~~
- O Tectonic V2 usa `src/` como diretório de inputs por padrão (via `[[output]]` + `inputs`), sem necessidade de `TEXINPUTS` explícito.

### 3. ~~Criar `abnt.cls` — classe base~~ ✅
- ~~Identificação da classe (`\ProvidesExplClass`)~~
- ~~Detecção de engine (XeLaTeX/LuaLaTeX vs pdfLaTeX) para carregar `fontspec` ou `fontenc`+`inputenc`~~
- ~~Fonte padrão: TeX Gyre Termes (equivalente livre de Times New Roman)~~
- ~~Papel A4, fonte 12pt, espaçamento 1,5~~
- ~~Margens padrão anverso: 3cm esq/sup, 2cm dir/inf~~
- ~~Comando `\abntSetVerso` para margens de verso~~
- ~~Paginação com `fancyhdr` (número no canto superior direito)~~
- ~~Recuo de parágrafo 1,25cm, `babel` com `brazil`~~

### 4. ~~Criar `abnt-projeto-pesquisa.cls`~~ ✅
- ~~Herda de `abnt.cls`~~
- ~~Metadados: `\titulo`, `\subtitulo`, `\autor`, `\orientador`, `\coorientador`, `\instituicao`, `\local`, `\ano`, `\natureza`, `\programa`, `\area`~~
- ~~`\imprimircapa` (capa conforme seção 4.1.1)~~
- ~~`\imprimirfolhaderosto` (folha de rosto conforme seção 4.2.1.1)~~
- ~~Comandos `\pretextual` e `\textual` para controle de paginação~~
- ~~Carrega automaticamente `abnt-sumario` e `abnt-numeracao`~~

### 5. ~~Criar pacotes .sty (stubs iniciais)~~ ✅
- ~~Cada pacote com `\ProvidesExplPackage`~~
- Stubs criados: `abnt-sumario`, `abnt-citacoes`, `abnt-refs`, `abnt-numeracao`, `abnt-indice`, `abnt-lombada`
- `abnt-sumario` tem implementação mínima (título do sumário em maiúsculas/negrito/centralizado)
- Os demais são stubs com TODOs

### 6. Reescrever `ibge-tabelas.sty`
- O rascunho original já foi movido para `src/ibge-tabelas.sty` e renomeado
- **Ainda não reescrito.** O conteúdo atual é o rascunho original com nome do pacote desatualizado (`ibge-tabular` → deve ser `ibge-tabelas`)
- Manter a interface pública existente (sinais convencionais, rodapé, séries temporais, classes de frequência)
- Revisar e completar a implementação conforme a norma IBGE 1993

### 7. Criar testes visuais por norma
- Um `.tex` mínimo por pacote em `tests/` (ex.: `tests/test-ibge-tabelas.tex`)
- Cada teste exercita a funcionalidade do pacote isoladamente
- Verificação manual com checklist; automação de medições quando possível

### 8. Criar template de exemplo
- `templates/projeto-pesquisa/main.tex` com estrutura completa preenchida
- `templates/projeto-pesquisa/refs.bib` com algumas referências de exemplo
- Compilável com `tectonic`

## Critério de conclusão da Fase 1

O esqueleto funcional está pronto quando:

1. O template `templates/projeto-pesquisa/main.tex` compila com `tectonic` e gera PDF
2. O PDF gerado contém capa, folha de rosto e sumário com formatação reconhecível (ainda que não perfeita)
3. Cada teste em `tests/` compila individualmente e gera PDF
4. Margens, fonte (12pt) e espaçamento (1,5) estão visualmente corretos no template

## Verificação

- Compilar cada teste em `tests/` com `tectonic` e verificar que gera PDF
- Compilar `templates/projeto-pesquisa/main.tex` com `tectonic` e verificar que gera PDF
- Conferir visualmente: margens, fonte, espaçamento, capa, folha de rosto
- Validar contra os requisitos da NBR 15287:2025 seções 4 e 5
