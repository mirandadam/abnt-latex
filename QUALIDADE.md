# Critérios de qualidade — latex-abnt

Critérios para avaliar se uma implementação (pacote `.sty` ou classe `.cls`) está pronta.

Aplicam-se a todos os módulos do projeto.

---

## 1. Conformidade com a norma

A implementação reproduz fielmente os requisitos da norma ABNT correspondente?

- Cada requisito da norma tem um trecho de código que o atende.
- Decisões que desviam da norma (por impossibilidade técnica ou ambiguidade) estão documentadas com justificativa.
- Requisitos opcionais da norma são configuráveis, não ignorados nem forçados.

**Como verificar:** tabela de rastreabilidade "seção da norma → comportamento no pacote" no cabeçalho do `.sty`/`.cls`.

---

## 2. Experiência do usuário

O pacote é conveniente tanto para quem está começando com LaTeX quanto para quem já usa regularmente?

### Para iniciantes

- O pacote funciona com configuração mínima. Um `\usepackage{abnt-indice}` sem opções produz resultado correto.
- Comandos públicos têm nomes em português, autoexplicativos.
- Erros comuns produzem mensagens claras em português, não stack traces de expl3.

### Para usuários avançados

- Opções de customização existem para quem precisa, sem poluir a interface básica.
- O pacote não impede o acesso às ferramentas subjacentes (ex.: `\index{}` continua funcionando normalmente).
- Comportamentos automáticos podem ser desligados.

### Para ambos

- O documento de exemplo funciona como tutorial: copia, compila, funciona.
- O caminho do "copiar e colar" até um documento funcional tem no máximo 3 passos.

---

## 3. Documentação

Cada documento responde uma pergunta. Nada supérfluo.

### No código-fonte (`.sty` / `.cls`)

- **Cabeçalho:** o quê, qual norma, versão, dependências. Responde: "o que é este arquivo?"
- **Seções numeradas** correspondendo a blocos funcionais. Responde: "onde encontro a lógica de X?"
- **Comentários** apenas onde o código não é autoevidente. Código claro não precisa de comentário.
- **Rastreabilidade:** referências a seções da norma ao lado das decisões de implementação (ex.: `% seção 6.7 — recuo progressivo`).

### No documento de exemplo (`tests/`)

- Compila sem edição. Responde: "como fica o resultado?"
- Cada funcionalidade do pacote aparece pelo menos uma vez. Responde: "como uso o recurso X?"
- Comentários no `.tex` explicam o que cada bloco demonstra.

### Não criar

- Arquivo de documentação separado (`.md` ou `.pdf`) — o código comentado e o exemplo são a documentação.
- README com instruções redundantes ao que o exemplo já mostra.

---

## 4. Testabilidade

É possível verificar que o pacote funciona corretamente sem inspeção visual manual?

- O documento de teste compila sem erros e sem warnings relevantes.
- O teste pode ser executado com um único comando (`make test`, `tectonic ...`, ou equivalente).
- Regressões são detectáveis: se uma mudança quebrar a saída, o teste falha.
- Para propriedades visuais (formatação, espaçamento), um PDF de referência serve como baseline para comparação.

**Nível mínimo aceitável:** o documento de teste compila sem erros. **Nível ideal:** comparação automatizada do PDF gerado contra referência.

---

## 5. Manutenibilidade

Quando uma norma ABNT for revisada ou um bug for reportado, a correção é fácil de fazer?

- **Separação de responsabilidades:** cada arquivo faz uma coisa. Um pacote não mistura lógica de dois assuntos diferentes.
- **Dependências explícitas:** `\RequirePackage` com comentário do porquê. Sem dependências implícitas.
- **Sem código morto:** nada comentado "para uso futuro". Se não é usado, não existe.
- **Rastreabilidade à norma:** quando a norma mudar, a referência no código aponta exatamente o que revisar.
- **Valores mágicos documentados:** números hardcoded (margens, espaçamentos) têm um comentário indicando de onde vêm.

---

## 6. Robustez técnica

O pacote funciona nos ambientes em que o público-alvo realmente trabalha?

- Compila com XeLaTeX (Tectonic) e pdfLaTeX (TeX Live / Overleaf).
- Não conflita com pacotes comuns (`hyperref`, `babel`, `biblatex`, `geometry`).
- Funciona tanto standalone (`\documentclass{article}`) quanto com as classes ABNT do projeto.
- Caracteres acentuados e cedilha funcionam sem intervenção manual do usuário.

---

## Checklist resumido

Ao avaliar se um módulo está pronto para merge:

| #   | Critério     | Pergunta                                                                               |
| --- | ------------ | -------------------------------------------------------------------------------------- |
| 1   | Conformidade | Todos os requisitos aplicáveis da norma estão atendidos ou justificadamente excluídos? |
| 2   | UX básica    | Um usuário consegue usar o pacote apenas lendo o documento de exemplo?                 |
| 3   | UX avançada  | Um usuário experiente consegue customizar o comportamento sem editar o `.sty`?         |
| 4   | Documentação | O código responde "por quê?" e o exemplo responde "como?"                              |
| 5   | Compilação   | O teste compila sem erros em XeLaTeX e pdfLaTeX?                                       |
| 6   | Manutenção   | Consigo achar onde mudar se a norma for revisada?                                      |
| 7   | Robustez     | Funciona com `hyperref`, `babel`, `biblatex` carregados simultaneamente?               |
