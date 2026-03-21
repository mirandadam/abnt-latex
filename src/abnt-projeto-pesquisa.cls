% =============================================================================
% abnt-projeto-pesquisa.cls
% Classe para Projeto de Pesquisa — ABNT NBR 15287:2025
%
% Licença: LPPL 1.3c
% Versão:  0.2.0
%
% Herda de abnt.cls (que fornece metadados, capa, folha de rosto,
% margens, paginação e espaçamento) e adiciona:
%   - Carregamento automático dos pacotes de sumário e numeração
%
% A NBR 15287 é um subconjunto da NBR 14724: não possui dedicatória,
% agradecimentos, epígrafe, folha de aprovação nem resumos.
% A capa é elemento opcional (diferente da NBR 14724, onde é obrigatória).
% =============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{abnt-projeto-pesquisa}{2025/03/21}{0.2.0}
  {Projeto~de~Pesquisa~\textemdash~NBR~15287:2025}

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
% FIM DO ARQUIVO
% =============================================================================
