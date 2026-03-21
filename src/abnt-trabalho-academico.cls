% =============================================================================
% abnt-trabalho-academico.cls
% Classe para Trabalhos Acadêmicos — ABNT NBR 14724:2024
%
% Licença: LPPL 1.3c
% Versão:  0.2.0
%
% Herda de abnt.cls (que fornece metadados, capa, folha de rosto,
% margens, paginação e espaçamento) e adiciona:
%   - Dedicatória (seção 4.2.1.4)
%   - Agradecimentos (seção 4.2.1.5)
%   - Epígrafe (seção 4.2.1.6)
%   - Comando \postextual
%   - Carregamento automático dos pacotes de sumário e numeração
%
%   - Folha de aprovação (seção 4.2.1.3)
%   - Resumos vernácula/estrangeira (seções 4.2.1.7–4.2.1.8, via abnt-resumo.sty)
% =============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{abnt-trabalho-academico}{2025/03/21}{0.3.0}
  {Trabalho~Acadêmico~\textemdash~NBR~14724:2024}

% =============================================================================
% 1. HERANÇA
% =============================================================================
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{abnt}}
\ProcessOptions\relax
\LoadClass{abnt}

% =============================================================================
% 2. PACOTES CARREGADOS AUTOMATICAMENTE
% =============================================================================
\RequirePackage{abnt-sumario}
\RequirePackage{abnt-numeracao}

% =============================================================================
% 3. FOLHA DE APROVAÇÃO (seção 4.2.1.3 da NBR 14724:2024)
%    Elemento obrigatório. Inserida após a folha de rosto.
%    Contém: nome do autor, título, natureza, data de aprovação,
%    nomes e titulações da banca examinadora com linhas para assinatura.
%
%    Metadados do autor/título são herdados de abnt.cls.
%    Membros da banca são adicionados via \membrodabanca{nome}{titulação}.
%    Data de aprovação via \dataaprovacao{data}.
% =============================================================================

\tl_new:N \g__abnt_ta_data_aprovacao_tl
\tl_gset:Nn \g__abnt_ta_data_aprovacao_tl { [data~de~aprovação] }

\seq_new:N \g__abnt_ta_banca_seq

\NewDocumentCommand{\dataaprovacao}{ m }
  { \tl_gset:Nn \g__abnt_ta_data_aprovacao_tl {#1} }

\NewDocumentCommand{\membrodabanca}{ m m }
  { \seq_gput_right:Nn \g__abnt_ta_banca_seq { {#1}{#2} } }

% Comando interno: imprime uma linha de assinatura
\cs_new_protected:Nn \__abnt_ta_assinatura:nn
  {
    \par\vspace{1.5cm}
    \begin{center}
      \rule{8cm}{0.4pt} \\
      #1 \\
      #2
    \end{center}
  }

\NewDocumentCommand{\imprimirfolhadeaprovacao}{}{
  \cleardoublepage
  \begin{center}
    \MakeUppercase{\tl_use:N \g__abnt_autor_tl}
    \par\vspace{2cm}
    {
      \bfseries
      \MakeUppercase{\tl_use:N \g__abnt_titulo_tl}
      \tl_if_empty:NF \g__abnt_subtitulo_tl
        {
          \textnormal{:~\tl_use:N \g__abnt_subtitulo_tl}
        }
    }
  \end{center}
  \par\vspace{1.5cm}
  \begin{flushright}
    \begin{minipage}{0.5\textwidth}
      \singlespacing\small
      \tl_use:N \g__abnt_natureza_tl
    \end{minipage}
  \end{flushright}
  \par\vspace{0.5cm}
  \begin{center}
    Aprovado~em~\tl_use:N \g__abnt_ta_data_aprovacao_tl
  \end{center}
  % Membros da banca
  \seq_if_empty:NTF \g__abnt_ta_banca_seq
    {
      % Placeholders padrão se nenhum membro foi definido
      \__abnt_ta_assinatura:nn { [nome~do~orientador] } { [titulação]~\textendash~[instituição] }
      \__abnt_ta_assinatura:nn { [nome~do~membro~2] } { [titulação]~\textendash~[instituição] }
      \__abnt_ta_assinatura:nn { [nome~do~membro~3] } { [titulação]~\textendash~[instituição] }
    }
    {
      \seq_map_inline:Nn \g__abnt_ta_banca_seq
        { \__abnt_ta_assinatura:nn ##1 }
    }
  \clearpage
}

% =============================================================================
% 5. DEDICATÓRIA (seção 4.2.1.4 da NBR 14724:2024)
%    Elemento opcional. Inserida após a folha de aprovação.
%    Alinhamento do meio da mancha gráfica até a margem direita,
%    na parte inferior da página (seção 5.2.4).
% =============================================================================
\NewDocumentCommand{\imprimirdedicatoria}{ m }{
  \cleardoublepage
  \vspace*{\fill}
  \begin{flushright}
    \begin{minipage}{0.5\textwidth}
      \singlespacing
      #1
    \end{minipage}
  \end{flushright}
  \clearpage
}

% =============================================================================
% 6. AGRADECIMENTOS (seção 4.2.1.5 da NBR 14724:2024)
%    Elemento opcional. Inserido após a dedicatória.
%    Título sem indicativo numérico, centralizado (seção 5.2.3).
% =============================================================================
\NewDocumentCommand{\imprimiragradecimentos}{ +m }{
  \cleardoublepage
  \chapter*{AGRADECIMENTOS}
  #1
  \clearpage
}

% =============================================================================
% 7. EPÍGRAFE (seção 4.2.1.6 da NBR 14724:2024)
%    Elemento opcional. Inserida após os agradecimentos.
%    Mesma formatação da dedicatória (seção 5.2.4).
% =============================================================================
\NewDocumentCommand{\imprimirepigrafe}{ m }{
  \cleardoublepage
  \vspace*{\fill}
  \begin{flushright}
    \begin{minipage}{0.5\textwidth}
      \singlespacing
      #1
    \end{minipage}
  \end{flushright}
  \clearpage
}

% =============================================================================
% 8. PÓS-TEXTUAL
%    Elementos pós-textuais mantêm a paginação contínua.
% =============================================================================
\NewDocumentCommand{\postextual}{}{
  \pagestyle{fancy}
}

% =============================================================================
% FIM DO ARQUIVO
% =============================================================================
