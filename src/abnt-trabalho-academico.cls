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
% Não implementado (documentado no README como limitação):
%   - Folha de aprovação (seção 4.2.1.3)
%   - Resumos vernácula/estrangeira (seções 4.2.1.7–4.2.1.8, depende da NBR 6028)
% =============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{abnt-trabalho-academico}{2025/03/21}{0.2.0}
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
% 3. DEDICATÓRIA (seção 4.2.1.4 da NBR 14724:2024)
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
% 4. AGRADECIMENTOS (seção 4.2.1.5 da NBR 14724:2024)
%    Elemento opcional. Inserido após a dedicatória.
%    Título sem indicativo numérico, centralizado (seção 5.2.3).
% =============================================================================
\NewDocumentCommand{\imprimiragradecimentos}{ m }{
  \cleardoublepage
  \begin{center}
    \bfseries AGRADECIMENTOS
  \end{center}
  \vspace{1cm}
  #1
  \clearpage
}

% =============================================================================
% 5. EPÍGRAFE (seção 4.2.1.6 da NBR 14724:2024)
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
% 6. PÓS-TEXTUAL
%    Elementos pós-textuais mantêm a paginação contínua.
% =============================================================================
\NewDocumentCommand{\postextual}{}{
  \pagestyle{fancy}
}

% =============================================================================
% FIM DO ARQUIVO
% =============================================================================
