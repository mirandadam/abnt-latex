% =============================================================================
% abnt.cls
% Classe base para documentos acadêmicos conforme normas ABNT
%
% Licença: LPPL 1.3c
% Versão:  0.2.0
%
% Dependências:
%   report    — classe base (fornece \chapter)
%   fontspec  — fontes OpenType (XeLaTeX / LuaLaTeX)
%   fontenc   — codificação T1 (pdfLaTeX)
%   geometry  — margens
%   setspace  — espaçamento entre linhas
%   fancyhdr  — paginação customizada
%   babel     — idioma português brasileiro
%   hyperref  — links internos e metadados PDF
%
% Rastreabilidade às normas:
%   NBR 14724:2024 seção 5.1  → papel A4, fonte 12pt, margens 3/2/3/2 cm
%   NBR 14724:2024 seção 5.2  → espaçamento 1,5 entre linhas
%   NBR 14724:2024 seção 5.3  → paginação em arábico, canto superior direito
%   NBR 14724:2024 seção 4.1.1 / NBR 15287:2025 seção 4.1.1  → capa
%   NBR 14724:2024 seção 4.2.1.1 / NBR 15287:2025 seção 4.2.1.1 → folha de rosto
%
% Nota: recuo de parágrafo de 1,25 cm é convenção herdada do abnTeX2.
%   As normas NBR 14724 e NBR 15287 não especificam valor explícito.
% =============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{abnt}{2025/03/21}{0.2.0}
  {Classe~base~para~documentos~ABNT}

% =============================================================================
% 1. CLASSE BASE E OPÇÕES
% =============================================================================
% Herda de report. Força a4paper e 12pt (NBR 14724 seção 5.1).
% report fornece \chapter, necessário para documentos acadêmicos ABNT.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[a4paper, 12pt]{report}

% =============================================================================
% 2. DETECÇÃO DE ENGINE
% =============================================================================
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

% =============================================================================
% 3. FONTE (NBR 14724 seção 5.1 — "fonte tamanho 12")
% =============================================================================
% Padrão: TeX Gyre Termes (equivalente livre do Times New Roman).
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

% =============================================================================
% 4. MARGENS (NBR 14724 seção 5.1 / NBR 15287 seção 5.1)
%    Anverso: esquerda e superior 3 cm, direita e inferior 2 cm.
% =============================================================================
\RequirePackage{geometry}
\geometry{
  a4paper,
  top      = 3cm,
  bottom   = 2cm,
  left     = 3cm,
  right    = 2cm,
}

% =============================================================================
% 5. ESPAÇAMENTO (NBR 14724 seção 5.2 / NBR 15287 seção 5.2)
%    "espaçamento 1,5 entre as linhas"
% =============================================================================
\RequirePackage{setspace}
\onehalfspacing

% =============================================================================
% 6. PAGINAÇÃO (NBR 14724 seção 5.3 / NBR 15287 seção 5.3)
%    Arábicos, canto superior direito da folha.
% =============================================================================
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[R]{\thepage}
\renewcommand{\headrulewidth}{0pt}

% Páginas de abertura de capítulo usam estilo 'plain'
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyhead[R]{\thepage}
  \renewcommand{\headrulewidth}{0pt}
}

% =============================================================================
% 7. PARÁGRAFOS
%    Recuo de 1,25 cm é convenção do abnTeX2 (não especificado nas normas).
% =============================================================================
\setlength{\parindent}{1.25cm}
\setlength{\parskip}{0pt}

% =============================================================================
% 8. IDIOMA
% =============================================================================
\RequirePackage[brazil]{babel}

% =============================================================================
% 9. HYPERREF — links internos e metadados PDF
%
%    O hyperref é carregado no final do preâmbulo (via \AddToHook) para
%    evitar conflitos de ordem com pacotes do usuário.
%
%    Padrão: hidelinks (links funcionais sem indicação visual).
%    As normas ABNT não especificam tratamento de links (são normas
%    para documentos impressos), portanto a classe adota aparência limpa.
%
%    Para reativar indicação visual, use \hypersetup no preâmbulo:
%      \hypersetup{colorlinks, allcolors=blue}     % texto colorido
%      \hypersetup{allbordercolors=blue}            % bordas coloridas
% =============================================================================
\AddToHook{begindocument/before}{
  \RequirePackage{hyperref}
  \hypersetup{
    hidelinks,
    unicode,
    pdfproducer = {LaTeX~com~abnt.cls},
  }
}

% =============================================================================
% 10. METADADOS DO DOCUMENTO
%     Variáveis e comandos públicos comuns a todas as classes ABNT.
% =============================================================================
\tl_new:N \g__abnt_titulo_tl
\tl_new:N \g__abnt_subtitulo_tl
\tl_new:N \g__abnt_autor_tl
\tl_new:N \g__abnt_orientador_tl
\tl_new:N \g__abnt_coorientador_tl
\tl_new:N \g__abnt_instituicao_tl
\tl_new:N \g__abnt_local_tl
\tl_new:N \g__abnt_ano_tl
\tl_new:N \g__abnt_natureza_tl
\tl_new:N \g__abnt_programa_tl
\tl_new:N \g__abnt_area_tl

\NewDocumentCommand{\titulo}{ m }
  { \tl_gset:Nn \g__abnt_titulo_tl {#1} }
\NewDocumentCommand{\subtitulo}{ m }
  { \tl_gset:Nn \g__abnt_subtitulo_tl {#1} }
\NewDocumentCommand{\autor}{ m }
  { \tl_gset:Nn \g__abnt_autor_tl {#1} }
\NewDocumentCommand{\orientador}{ m }
  { \tl_gset:Nn \g__abnt_orientador_tl {#1} }
\NewDocumentCommand{\coorientador}{ m }
  { \tl_gset:Nn \g__abnt_coorientador_tl {#1} }
\NewDocumentCommand{\instituicao}{ m }
  { \tl_gset:Nn \g__abnt_instituicao_tl {#1} }
\NewDocumentCommand{\local}{ m }
  { \tl_gset:Nn \g__abnt_local_tl {#1} }
\NewDocumentCommand{\ano}{ m }
  { \tl_gset:Nn \g__abnt_ano_tl {#1} }
\NewDocumentCommand{\natureza}{ m }
  { \tl_gset:Nn \g__abnt_natureza_tl {#1} }
\NewDocumentCommand{\programa}{ m }
  { \tl_gset:Nn \g__abnt_programa_tl {#1} }
\NewDocumentCommand{\area}{ m }
  { \tl_gset:Nn \g__abnt_area_tl {#1} }

% =============================================================================
% 11. CAPA (NBR 14724 seção 4.1.1 / NBR 15287 seção 4.1.1)
%     Ordem dos elementos:
%       a) nome da instituição (opcional)
%       b) nome do autor
%       c) título (negrito, maiúsculas)
%       d) subtítulo (se houver, sem negrito, precedido de dois pontos)
%       e) local (cidade)
%       f) ano de depósito/entrega
% =============================================================================
\NewDocumentCommand{\imprimircapa}{}{
  \begin{titlepage}
    \centering
    \onehalfspacing

    \tl_if_empty:NF \g__abnt_instituicao_tl
      {
        \MakeUppercase{\tl_use:N \g__abnt_instituicao_tl}
        \par\vspace{1cm}
      }

    \MakeUppercase{\tl_use:N \g__abnt_autor_tl}
    \par\vfill

    {
      \bfseries
      \MakeUppercase{\tl_use:N \g__abnt_titulo_tl}
      \tl_if_empty:NF \g__abnt_subtitulo_tl
        {
          \textnormal{:~\tl_use:N \g__abnt_subtitulo_tl}
        }
    }
    \par\vfill

    \tl_use:N \g__abnt_local_tl
    \par
    \tl_use:N \g__abnt_ano_tl

  \end{titlepage}
}

% =============================================================================
% 12. FOLHA DE ROSTO (NBR 14724 seção 4.2.1.1.1 / NBR 15287 seção 4.2.1.1)
%     Ordem dos elementos:
%       a) nome do autor
%       b) título e subtítulo
%       c) natureza do trabalho (recuado à direita — NBR 14724 seção 5.2)
%       d) orientador e coorientador
%       e) local (cidade)
%       f) ano de depósito/entrega
% =============================================================================
\NewDocumentCommand{\imprimirfolhaderosto}{}{
  \begin{titlepage}
    \centering
    \onehalfspacing

    \MakeUppercase{\tl_use:N \g__abnt_autor_tl}
    \par\vfill

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

    \tl_use:N \g__abnt_local_tl
    \par
    \tl_use:N \g__abnt_ano_tl

  \end{titlepage}
}

% =============================================================================
% 13. PAGINAÇÃO PRÉ-TEXTUAL / TEXTUAL (NBR 14724 seção 5.3)
%     Pré-textuais: contadas mas não numeradas.
%     Textuais: numeração em arábico a partir da primeira página.
%     \pagenumbering{arabic} inicia a contagem em 1.
% =============================================================================
\NewDocumentCommand{\pretextual}{}{
  \pagestyle{empty}
  \pagenumbering{arabic}
}

\NewDocumentCommand{\textual}{}{
  \pagestyle{fancy}
}

\AtBeginDocument{
  \pretextual
  % Propagar metadados para o PDF (requer hyperref já carregado)
  \tl_if_empty:NF \g__abnt_titulo_tl
    { \hypersetup{ pdftitle = {\tl_use:N \g__abnt_titulo_tl} } }
  \tl_if_empty:NF \g__abnt_autor_tl
    { \hypersetup{ pdfauthor = {\tl_use:N \g__abnt_autor_tl} } }
}

% =============================================================================
% FIM DO ARQUIVO
% =============================================================================
