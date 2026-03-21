% =============================================================================
% abnt.cls
% Classe base para documentos acadêmicos conforme normas ABNT
%
% Licença: LPPL 1.3c
% Versão:  0.1.0
%
% Esta classe fornece a configuração comum a todos os documentos ABNT:
%   - Detecção de engine (XeLaTeX / pdfLaTeX)
%   - Papel A4, fonte 12pt, espaçamento 1,5
%   - Margens padrão (sobrescrevíveis pela classe filha)
%   - Paginação básica
% =============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{abnt}{2025/03/21}{0.1.0}
  {Classe~base~para~documentos~ABNT}

% -----------------------------------------------------------------------------
% 1. CLASSE BASE E OPÇÕES
% -----------------------------------------------------------------------------
% Herda de article. Força a4paper e 12pt.
% Opções do usuário são repassadas.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[a4paper, 12pt]{article}

% -----------------------------------------------------------------------------
% 2. DETECÇÃO DE ENGINE
% -----------------------------------------------------------------------------
\sys_if_engine_xetex:TF
  {
    \RequirePackage{fontspec}
  }
  {
    \sys_if_engine_luatex:TF
      {
        \RequirePackage{fontspec}
      }
      {
        % pdfLaTeX
        \RequirePackage[T1]{fontenc}
        \RequirePackage[utf8]{inputenc}
      }
  }

% -----------------------------------------------------------------------------
% 3. FONTE
% -----------------------------------------------------------------------------
% Padrão: Times New Roman (ou equivalente disponível no engine).
% Em pdfLaTeX usa o pacote 'times' (TeX Gyre Termes).
% Em XeLaTeX/LuaLaTeX tenta carregar Times New Roman do sistema.

\sys_if_engine_xetex:TF
  {
    \setmainfont{TeX~Gyre~Termes}
  }
  {
    \sys_if_engine_luatex:TF
      {
        \setmainfont{TeX~Gyre~Termes}
      }
      {
        \RequirePackage{tgtermes}
      }
  }

% -----------------------------------------------------------------------------
% 4. MARGENS
% -----------------------------------------------------------------------------
% Padrão ABNT para anverso: 3cm esq/sup, 2cm dir/inf
% A classe filha pode sobrescrever esses valores antes de \begin{document}.

\RequirePackage{geometry}
\geometry{
  a4paper,
  top      = 3cm,
  bottom   = 2cm,
  left     = 3cm,
  right    = 2cm,
}

% Comando para classes filhas configurarem margens de verso (impressão frente e verso)
\NewDocumentCommand{\abntSetVerso}{}{
  \geometry{
    twoside,
    top      = 3cm,
    bottom   = 2cm,
    inner    = 3cm,
    outer    = 2cm,
  }
}

% -----------------------------------------------------------------------------
% 5. ESPAÇAMENTO
% -----------------------------------------------------------------------------
% Espaçamento 1,5 conforme exigido pelas normas ABNT.
\RequirePackage{setspace}
\onehalfspacing

% -----------------------------------------------------------------------------
% 6. PAGINAÇÃO
% -----------------------------------------------------------------------------
% Páginas numeradas em arábico, no canto superior direito.
% A classe filha pode ajustar conforme a norma específica (ex.: pré-textuais
% contadas mas não numeradas).

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[R]{\thepage}
\renewcommand{\headrulewidth}{0pt}

% Redefine plain para páginas de abertura de capítulo
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyhead[R]{\thepage}
  \renewcommand{\headrulewidth}{0pt}
}

% -----------------------------------------------------------------------------
% 7. PARÁGRAFOS
% -----------------------------------------------------------------------------
% Recuo de parágrafo e sem espaço extra entre parágrafos.
\setlength{\parindent}{1.25cm}
\setlength{\parskip}{0pt}

% -----------------------------------------------------------------------------
% 8. IDIOMA
% -----------------------------------------------------------------------------
% Carrega babel com português brasileiro como padrão.
\RequirePackage[brazil]{babel}

% =============================================================================
% FIM DO ARQUIVO
% =============================================================================
