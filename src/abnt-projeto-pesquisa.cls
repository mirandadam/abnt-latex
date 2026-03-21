% =============================================================================
% abnt-projeto-pesquisa.cls
% Classe para Projeto de Pesquisa — ABNT NBR 15287:2025
%
% Licença: LPPL 1.3c
% Versão:  0.1.0
%
% Herda de abnt.cls e implementa:
%   - Comandos de metadados (título, autor, orientador, etc.)
%   - Capa (seção 4.1.1)
%   - Folha de rosto (seção 4.2.1.1)
%   - Estrutura pré-textual
%   - Carregamento automático dos pacotes relevantes
% =============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{abnt-projeto-pesquisa}{2025/03/21}{0.1.0}
  {Projeto~de~Pesquisa~\textemdash~NBR~15287:2025}

% -----------------------------------------------------------------------------
% 1. HERANÇA
% -----------------------------------------------------------------------------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{abnt}}
\ProcessOptions\relax
\LoadClass{abnt}

% -----------------------------------------------------------------------------
% 2. PACOTES CARREGADOS AUTOMATICAMENTE
% -----------------------------------------------------------------------------
\RequirePackage{abnt-sumario}
\RequirePackage{abnt-numeracao}

% -----------------------------------------------------------------------------
% 3. VARIÁVEIS DE METADADOS
% -----------------------------------------------------------------------------
\tl_new:N \g_abnt_titulo_tl
\tl_new:N \g_abnt_subtitulo_tl
\tl_new:N \g_abnt_autor_tl
\tl_new:N \g_abnt_orientador_tl
\tl_new:N \g_abnt_coorientador_tl
\tl_new:N \g_abnt_instituicao_tl
\tl_new:N \g_abnt_local_tl
\tl_new:N \g_abnt_ano_tl
\tl_new:N \g_abnt_natureza_tl
\tl_new:N \g_abnt_programa_tl
\tl_new:N \g_abnt_area_tl

% Comandos públicos para definir metadados
\NewDocumentCommand{\titulo}{ m }{
  \tl_gset:Nn \g_abnt_titulo_tl {#1}
}
\NewDocumentCommand{\subtitulo}{ m }{
  \tl_gset:Nn \g_abnt_subtitulo_tl {#1}
}
\NewDocumentCommand{\autor}{ m }{
  \tl_gset:Nn \g_abnt_autor_tl {#1}
}
\NewDocumentCommand{\orientador}{ m }{
  \tl_gset:Nn \g_abnt_orientador_tl {#1}
}
\NewDocumentCommand{\coorientador}{ m }{
  \tl_gset:Nn \g_abnt_coorientador_tl {#1}
}
\NewDocumentCommand{\instituicao}{ m }{
  \tl_gset:Nn \g_abnt_instituicao_tl {#1}
}
\NewDocumentCommand{\local}{ m }{
  \tl_gset:Nn \g_abnt_local_tl {#1}
}
\NewDocumentCommand{\ano}{ m }{
  \tl_gset:Nn \g_abnt_ano_tl {#1}
}
\NewDocumentCommand{\natureza}{ m }{
  \tl_gset:Nn \g_abnt_natureza_tl {#1}
}
\NewDocumentCommand{\programa}{ m }{
  \tl_gset:Nn \g_abnt_programa_tl {#1}
}
\NewDocumentCommand{\area}{ m }{
  \tl_gset:Nn \g_abnt_area_tl {#1}
}

% -----------------------------------------------------------------------------
% 4. CAPA (seção 4.1.1 da NBR 15287:2025)
%    Elementos obrigatórios:
%      a) nome da instituição (opcional na norma, mas usual)
%      b) nome do autor
%      c) título
%      d) subtítulo (se houver)
%      e) local (cidade)
%      f) ano de entrega
% -----------------------------------------------------------------------------
\NewDocumentCommand{\imprimircapa}{}{
  \begin{titlepage}
    \centering
    \onehalfspacing

    % Instituição
    \tl_if_empty:NF \g_abnt_instituicao_tl
      {
        \MakeUppercase{\tl_use:N \g_abnt_instituicao_tl}
        \par\vspace{1cm}
      }

    % Autor
    \MakeUppercase{\tl_use:N \g_abnt_autor_tl}
    \par\vfill

    % Título (em negrito e maiúsculas)
    {
      \bfseries
      \MakeUppercase{\tl_use:N \g_abnt_titulo_tl}
      % Subtítulo (não negrito, separado por dois pontos)
      \tl_if_empty:NF \g_abnt_subtitulo_tl
        {
          \textnormal{:~\tl_use:N \g_abnt_subtitulo_tl}
        }
    }
    \par\vfill

    % Local e ano
    \tl_use:N \g_abnt_local_tl
    \par
    \tl_use:N \g_abnt_ano_tl

  \end{titlepage}
}

% -----------------------------------------------------------------------------
% 5. FOLHA DE ROSTO (seção 4.2.1.1 da NBR 15287:2025)
%    Elementos obrigatórios:
%      a) nome do autor
%      b) título
%      c) subtítulo (se houver)
%      d) natureza (tipo do trabalho, objetivo, instituição, área)
%      e) nome do orientador e coorientador (se houver)
%      f) local (cidade)
%      g) ano de entrega
% -----------------------------------------------------------------------------
\NewDocumentCommand{\imprimirfolhaderosto}{}{
  \begin{titlepage}
    \centering
    \onehalfspacing

    % Autor
    \MakeUppercase{\tl_use:N \g_abnt_autor_tl}
    \par\vfill

    % Título e subtítulo
    {
      \bfseries
      \MakeUppercase{\tl_use:N \g_abnt_titulo_tl}
      \tl_if_empty:NF \g_abnt_subtitulo_tl
        {
          \textnormal{:~\tl_use:N \g_abnt_subtitulo_tl}
        }
    }
    \par\vspace{2cm}

    % Natureza do trabalho (recuado à direita)
    \begin{flushright}
      \begin{minipage}{0.5\textwidth}
        \singlespacing\small
        \tl_use:N \g_abnt_natureza_tl

        \tl_if_empty:NF \g_abnt_programa_tl
          {
            \par \tl_use:N \g_abnt_programa_tl
          }

        \tl_if_empty:NF \g_abnt_area_tl
          {
            \par Área~de~concentração:~\tl_use:N \g_abnt_area_tl
          }

        \par\vspace{0.5cm}
        Orientador:~\tl_use:N \g_abnt_orientador_tl

        \tl_if_empty:NF \g_abnt_coorientador_tl
          {
            \par Coorientador:~\tl_use:N \g_abnt_coorientador_tl
          }
      \end{minipage}
    \end{flushright}

    \vfill

    % Local e ano
    \tl_use:N \g_abnt_local_tl
    \par
    \tl_use:N \g_abnt_ano_tl

  \end{titlepage}
}

% -----------------------------------------------------------------------------
% 6. PAGINAÇÃO PRÉ-TEXTUAL
%    Páginas pré-textuais são contadas mas não numeradas.
%    A numeração aparece a partir da primeira página textual.
% -----------------------------------------------------------------------------
\NewDocumentCommand{\pretextual}{}{
  \pagestyle{empty}
  \pagenumbering{arabic}
}

\NewDocumentCommand{\textual}{}{
  \pagestyle{fancy}
}

% Iniciar em modo pré-textual
\AtBeginDocument{\pretextual}

% =============================================================================
% FIM DO ARQUIVO
% =============================================================================
