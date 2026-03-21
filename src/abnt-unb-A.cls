% =============================================================================
% abnt-unb-A.cls
% Modelo institucional A (engenharia) — Universidade de Brasília (UnB)
%
% Licença: LPPL 1.3c
% Versão:  0.1.0
%
% Herda de abnt-trabalho-academico.cls (que fornece elementos pré-textuais,
% textuais e pós-textuais conforme NBR 14724:2024) e adiciona:
%   - Metadados institucionais (faculdade, departamento, curso, grau)
%   - Logo da UnB na capa e folha de rosto
%   - Cores institucionais (azul e verde UnB)
%   - Fontes oficiais UnB Pro/Office (XeLaTeX/LuaLaTeX) com fallback
%   - Capa e folha de rosto com identidade visual da UnB
%
% Dependências adicionais (não carregadas pelos pais):
%   graphicx  — inclusão do logo
%   xcolor    — cores institucionais
%
% Identidade visual:
%   Azul UnB: Pantone 654, #003366
%   Verde UnB: Pantone 348, #006633
%   Fontes: UnB Pro (OpenType-CFF) ou UnB Office (OpenType-TrueType)
%   Manual: https://www.marca.unb.br/
%
% Nota: esta classe NÃO é normativa — é institucional. Os requisitos
% normativos (ABNT NBR 14724, 6024, etc.) são atendidos pelas classes pai.
% =============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{abnt-unb-A}{2025/03/21}{0.1.0}
  {Modelo~institucional~A~(engenharia)~\textemdash~Universidade~de~Brasília}

% =============================================================================
% 1. HERANÇA
% =============================================================================
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{abnt-trabalho-academico}}
\ProcessOptions\relax
\LoadClass{abnt-trabalho-academico}

% =============================================================================
% 2. DEPENDÊNCIAS
% =============================================================================
\RequirePackage{graphicx}  % inclusão do logo (não carregado pelos pais)
\RequirePackage{xcolor}    % cores institucionais
\RequirePackage{tikz}      % faixa inferior da capa

% =============================================================================
% 3. CORES INSTITUCIONAIS
%    Disponíveis para uso pelo documento, não aplicadas automaticamente.
%    Fonte: Manual de Identidade Visual da UnB (marca.unb.br)
% =============================================================================
\definecolor{unb-azul}{HTML}{003366}   % Pantone 654
\definecolor{unb-verde}{HTML}{006633}  % Pantone 348

% =============================================================================
% 4. METADADOS UnB
%    Complementam os metadados de abnt.cls (\titulo, \autor, etc.)
%    com informações específicas da estrutura acadêmica da UnB.
% =============================================================================

\tl_new:N \g__abnt_unb_faculdade_tl
\tl_new:N \g__abnt_unb_departamento_tl
\tl_new:N \g__abnt_unb_curso_tl
\tl_new:N \g__abnt_unb_grau_tl
\tl_new:N \g__abnt_unb_tipotrabalho_tl

\NewDocumentCommand{\faculdade}{ m }
  { \tl_gset:Nn \g__abnt_unb_faculdade_tl {#1} }
\NewDocumentCommand{\departamento}{ m }
  { \tl_gset:Nn \g__abnt_unb_departamento_tl {#1} }
\NewDocumentCommand{\curso}{ m }
  { \tl_gset:Nn \g__abnt_unb_curso_tl {#1} }
\NewDocumentCommand{\grau}{ m }
  { \tl_gset:Nn \g__abnt_unb_grau_tl {#1} }
\NewDocumentCommand{\tipotrabalho}{ m }
  { \tl_gset:Nn \g__abnt_unb_tipotrabalho_tl {#1} }

% =============================================================================
% 5. DEFAULTS INSTITUCIONAIS
%    O usuário pode sobrescrever com \instituicao{} e \local{}.
% =============================================================================
\instituicao{Universidade~de~Brasília}
\local{Brasília}

% =============================================================================
% 6. CAMINHO DO LOGO
%    Sem extensão — LaTeX escolhe .pdf (pdfLaTeX) ou .eps (outros)
%    conforme a engine. O usuário pode sobrescrever com \unblogo{}.
% =============================================================================
\tl_new:N \g__abnt_unb_logo_tl
\tl_gset:Nn \g__abnt_unb_logo_tl { unb_logo }

\NewDocumentCommand{\unblogo}{ m }
  { \tl_gset:Nn \g__abnt_unb_logo_tl {#1} }

% =============================================================================
% 7. FONTES UnB (condicional por engine)
%
%    XeLaTeX/LuaLaTeX: tenta UnB Pro, fallback UnB Office, fallback
%    TeX Gyre Termes (já definida por abnt.cls) com warning.
%
%    pdfLaTeX: mantém TeX Gyre Termes silenciosamente.
%
%    As fontes UnB Pro e UnB Office são OpenType e devem estar instaladas
%    no sistema. Download: https://www.marca.unb.br/fontesunb.php
% =============================================================================

\msg_new:nnn { abnt-unb } { fonte-nao-encontrada }
  {
    Fontes~'UnB~Pro'~e~'UnB~Office'~não~encontradas.~
    Usando~TeX~Gyre~Termes~como~fallback.~
    Para~usar~as~fontes~oficiais~da~UnB,~instale~UnB~Pro~ou~
    UnB~Office~e~compile~com~XeLaTeX~ou~LuaLaTeX.
  }

\sys_if_engine_xetex:TF
  { \bool_gset_true:N \g_tmpa_bool }
  {
    \sys_if_engine_luatex:TF
      { \bool_gset_true:N \g_tmpa_bool }
      { \bool_gset_false:N \g_tmpa_bool }
  }

\bool_if:NT \g_tmpa_bool
  {
    \IfFontExistsTF{UnB~Pro}
      {
        \setmainfont{UnB~Pro}
      }
      {
        \IfFontExistsTF{UnB~Office}
          {
            \setmainfont{UnB~Office}
          }
          {
            \msg_warning:nn { abnt-unb } { fonte-nao-encontrada }
          }
      }
  }

% =============================================================================
% 8. CAPA (sobrescreve \imprimircapa de abnt.cls)
%
%    Layout baseado no UnBTeX:
%      Logo/marca UnB no topo (~35% da página)
%      Instituição + faculdade + departamento (negrito, centralizado)
%      Título (grande, negrito, centralizado)
%      Autor (centralizado)
%      Faixa azul institucional na parte inferior (~25% da página)
%        contendo: tipo de trabalho, curso, local, ano (texto branco)
% =============================================================================

\RenewDocumentCommand{\imprimircapa}{}{
  \begin{titlepage}
    \centering

    % --- Elementos de fundo (tikz overlay) ---
    \begin{tikzpicture}[remember~picture, overlay]

      % Marca UnB no topo — sangra de borda a borda
      % Escala: largura total da página, posicionado no topo
      \tl_if_empty:NF \g__abnt_unb_logo_tl
        {
          \node[anchor=north, inner~sep=0pt]
            at (current~page.north)
            {\includegraphics[width=\paperwidth]
              {\tl_use:N \g__abnt_unb_logo_tl}};
        }

      % Faixa azul inferior
      \fill[unb-azul]
        (current~page.south~west) rectangle
        ([yshift=7cm] current~page.south~east);

      % Conteúdo da faixa azul (texto branco)
      \tl_if_empty:NF \g__abnt_unb_tipotrabalho_tl
        {
          \node[white, anchor=center, font=\normalsize]
            at ([yshift=5.5cm] current~page.south)
            {\MakeUppercase{\tl_use:N \g__abnt_unb_tipotrabalho_tl}};
        }
      \tl_if_empty:NF \g__abnt_unb_curso_tl
        {
          \node[white, anchor=center, font=\normalsize]
            at ([yshift=4.5cm] current~page.south)
            {\MakeUppercase{\tl_use:N \g__abnt_unb_curso_tl}};
        }
      \node[white, anchor=center, font=\normalsize]
        at ([yshift=3cm] current~page.south)
        {\tl_use:N \g__abnt_local_tl};
      \node[white, anchor=center, font=\normalsize]
        at ([yshift=2cm] current~page.south)
        {\tl_use:N \g__abnt_ano_tl};

    \end{tikzpicture}

    % --- Conteúdo da capa posicionado via tikz (posição absoluta) ---
    % Evita dependência do \vspace dentro de titlepage.
    \begin{tikzpicture}[remember~picture, overlay]

      % Cabeçalho institucional — logo de 10.5cm, texto 1cm abaixo
      \node[anchor=north, font=\large\bfseries, align=center]
        at ([yshift=-11.5cm] current~page.north)
        {
          \tl_use:N \g__abnt_instituicao_tl
          \tl_if_empty:NF \g__abnt_unb_faculdade_tl
            { \\ \tl_use:N \g__abnt_unb_faculdade_tl }
          \tl_if_empty:NF \g__abnt_unb_departamento_tl
            { \\ \tl_use:N \g__abnt_unb_departamento_tl }
        };

      % Título e subtítulo — entre cabeçalho e faixa azul
      % Faixa azul começa a 7cm do fundo. Centro da área livre:
      % de ~14cm (cabeçalho) até ~22.7cm (topo da faixa) do topo
      % = centro em ~18cm do topo = ~11.7cm do fundo
      \node[anchor=center, align=center,
            text~width=0.85\paperwidth]
        at ([yshift=11.5cm] current~page.south)
        {
          \centering
          {\LARGE\bfseries \tl_use:N \g__abnt_titulo_tl
           \tl_if_empty:NF \g__abnt_subtitulo_tl
             { : }
          }
          \tl_if_empty:NF \g__abnt_subtitulo_tl
            {
              \\ {\Large \tl_use:N \g__abnt_subtitulo_tl}
            }
        };

      % Autor — abaixo do título
      \node[anchor=center, font=\large]
        at ([yshift=9cm] current~page.south)
        { \tl_use:N \g__abnt_autor_tl };

    \end{tikzpicture}

    \null % página não vazia

  \end{titlepage}
}

% =============================================================================
% 9. FOLHA DE ROSTO (sobrescreve \imprimirfolhaderosto de abnt.cls)
%
%    Adiciona cabeçalho institucional (logo + universidade + faculdade)
%    e mantém o restante conforme NBR 14724 seção 4.2.1.1.
% =============================================================================

\RenewDocumentCommand{\imprimirfolhaderosto}{}{
  \begin{titlepage}
    \centering
    \onehalfspacing

    % Cabeçalho institucional (menor que na capa)
    \tl_if_empty:NF \g__abnt_unb_logo_tl
      {
        \includegraphics[height=1.5cm]{\tl_use:N \g__abnt_unb_logo_tl}
        \par\vspace{0.3cm}
      }
    {
      \small
      \tl_use:N \g__abnt_instituicao_tl
      \tl_if_empty:NF \g__abnt_unb_faculdade_tl
        {
          \par
          \tl_use:N \g__abnt_unb_faculdade_tl
        }
    }
    \par\vspace{1cm}

    % Autor
    \MakeUppercase{\tl_use:N \g__abnt_autor_tl}
    \par\vfill

    % Título e subtítulo
    {
      \bfseries
      \MakeUppercase{\tl_use:N \g__abnt_titulo_tl}
      \tl_if_empty:NF \g__abnt_subtitulo_tl
        {
          \textnormal{:~\tl_use:N \g__abnt_subtitulo_tl}
        }
    }
    \par\vspace{2cm}

    % Natureza do trabalho — alinhada do meio da mancha até a margem direita
    \begin{flushright}
      \begin{minipage}{0.5\textwidth}
        \singlespacing\small
        \tl_use:N \g__abnt_natureza_tl

        \tl_if_empty:NF \g__abnt_programa_tl
          {
            \par \tl_use:N \g__abnt_programa_tl
          }

        \tl_if_empty:NF \g__abnt_area_tl
          {
            \par Área~de~concentração:~\tl_use:N \g__abnt_area_tl
          }

        \par\vspace{0.5cm}
        Orientador:~\tl_use:N \g__abnt_orientador_tl

        \tl_if_empty:NF \g__abnt_coorientador_tl
          {
            \par Coorientador:~\tl_use:N \g__abnt_coorientador_tl
          }
      \end{minipage}
    \end{flushright}

    \vfill

    % Local e ano
    \tl_use:N \g__abnt_local_tl
    \par
    \tl_use:N \g__abnt_ano_tl

  \end{titlepage}
}

% =============================================================================
% FIM DO ARQUIVO
% =============================================================================
