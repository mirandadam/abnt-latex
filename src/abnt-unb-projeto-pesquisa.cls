% =============================================================================
% abnt-unb-projeto-pesquisa.cls
% Modelo institucional (clássico) para Projeto de Pesquisa — UnB
%
% Licença: LPPL 1.3c
% Versão:  0.1.0
%
% Combina a estrutura normativa de abnt-projeto-pesquisa.cls (NBR 15287:2025)
% com a identidade visual da UnB no estilo B (clássico):
%   - Logo pequeno centralizado (sem faixa azul)
%   - Hierarquia institucional em uppercase
%   - Fontes UnB Pro/Office com fallback
%   - Layout puramente via titlepage + vspace
%
% Herança: abnt-unb-projeto-pesquisa → abnt-projeto-pesquisa → abnt
%
% A NBR 15287 é um subconjunto da NBR 14724: não possui dedicatória,
% agradecimentos, epígrafe, folha de aprovação nem resumos.
% A capa é elemento opcional (diferente da NBR 14724, onde é obrigatória).
%
% Dependências adicionais (não carregadas pelos pais):
%   graphicx  — inclusão do logo
%   xcolor    — cores institucionais
% =============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{abnt-unb-projeto-pesquisa}{2025/03/21}{0.1.0}
  {Projeto~de~Pesquisa~UnB~(clássico)~\textemdash~NBR~15287:2025}

% =============================================================================
% 1. HERANÇA
% =============================================================================
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{abnt-projeto-pesquisa}}
\ProcessOptions\relax
\LoadClass{abnt-projeto-pesquisa}

% =============================================================================
% 2. DEPENDÊNCIAS
% =============================================================================
\RequirePackage{graphicx}  % inclusão do logo (não carregado pelos pais)
\RequirePackage{xcolor}    % cores institucionais

% =============================================================================
% 3. CORES INSTITUCIONAIS
% =============================================================================
\definecolor{unb-azul}{HTML}{003366}   % Pantone 654
\definecolor{unb-verde}{HTML}{006633}  % Pantone 348

% =============================================================================
% 4. METADADOS UnB
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
% =============================================================================
\instituicao{Universidade~de~Brasília}
\local{Brasília}

% =============================================================================
% 6. CAMINHO DO LOGO
% =============================================================================
\tl_new:N \g__abnt_unb_logo_tl
\tl_gset:Nn \g__abnt_unb_logo_tl { unb_logo }

\NewDocumentCommand{\unblogo}{ m }
  { \tl_gset:Nn \g__abnt_unb_logo_tl {#1} }

% =============================================================================
% 7. FONTES UnB (condicional por engine)
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
%    Layout clássico ABNT com logo UnB (mesmo estilo do modelo B):
%      Logo UnB pequeno centralizado (~2.5cm)
%      UNIVERSIDADE DE BRASÍLIA (uppercase)
%      Faculdade (uppercase)
%      Departamento (uppercase, se definido)
%      Programa (uppercase, se definido)
%      [vfill]
%      AUTOR (uppercase)
%      [vfill]
%      TÍTULO (bold, uppercase)
%      Subtítulo (se definido)
%      [vfill]
%      Tipo de trabalho (se definido)
%      [vfill]
%      Local
%      Ano
% =============================================================================

% Não usa titlepage para evitar reset do contador de páginas
% (NBR 15287 seção 5.3 — contagem sequencial).
\RenewDocumentCommand{\imprimircapa}{}{
  \clearpage
  \thispagestyle{empty}
  \group_begin:
    \centering
    \onehalfspacing

    % Logo pequeno centralizado
    \tl_if_empty:NF \g__abnt_unb_logo_tl
      {
        \includegraphics[height=2.5cm]{\tl_use:N \g__abnt_unb_logo_tl}
        \par\vspace{0.3cm}
      }

    % Cabeçalho institucional — uppercase
    \MakeUppercase{\tl_use:N \g__abnt_instituicao_tl}
    \par
    \tl_if_empty:NF \g__abnt_unb_faculdade_tl
      {
        \MakeUppercase{\tl_use:N \g__abnt_unb_faculdade_tl}
        \par
      }
    \tl_if_empty:NF \g__abnt_unb_departamento_tl
      {
        \MakeUppercase{\tl_use:N \g__abnt_unb_departamento_tl}
        \par
      }
    \tl_if_empty:NF \g__abnt_unb_curso_tl
      {
        \MakeUppercase{\tl_use:N \g__abnt_unb_curso_tl}
        \par
      }

    \par\vfill

    % Autor
    \MakeUppercase{\tl_use:N \g__abnt_autor_tl}

    \par\vfill

    % Título e subtítulo
    {
      \bfseries
      \MakeUppercase{\tl_use:N \g__abnt_titulo_tl}
      \tl_if_empty:NF \g__abnt_subtitulo_tl
        {
          :\par\textnormal{\tl_use:N \g__abnt_subtitulo_tl}
        }
    }

    \par\vfill

    % Tipo de trabalho (se definido)
    \tl_if_empty:NF \g__abnt_unb_tipotrabalho_tl
      {
        \tl_use:N \g__abnt_unb_tipotrabalho_tl
        \par\vfill
      }

    % Local e ano
    \MakeUppercase{\tl_use:N \g__abnt_local_tl}
    \par
    \tl_use:N \g__abnt_ano_tl

  \group_end:
  \clearpage
  % Capa não é contada (NBR 15287 seção 5.3).
  % Contagem sequencial inicia na folha de rosto.
  \setcounter{page}{1}
}

% =============================================================================
% 9. FOLHA DE ROSTO (sobrescreve \imprimirfolhaderosto de abnt.cls)
%
%    Cabeçalho institucional discreto + layout ABNT padrão.
% =============================================================================

\RenewDocumentCommand{\imprimirfolhaderosto}{}{
  \clearpage
  \thispagestyle{empty}
  \group_begin:
    \centering
    \onehalfspacing

    % Cabeçalho institucional discreto
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

    % Natureza do trabalho
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

  \group_end:
  \clearpage
}

% =============================================================================
% FIM DO ARQUIVO
% =============================================================================
