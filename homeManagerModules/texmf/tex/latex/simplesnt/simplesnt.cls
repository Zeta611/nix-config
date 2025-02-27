%%
%% This is file `simplesnt.cls'.
%%
%% ---------------------------------------------------------------------------
%% The simplesnt class --- A simple package to create show and tell slides
%% Maintained by Jay Lee
%% E-mail: jaeho.lee@snu.ac.kr
%% Released under the MIT License.
%% ---------------------------------------------------------------------------
%%
\RequirePackage{expl3}
\ProvidesExplClass
  {simplesnt}
  {2023/07/04}
  {1.0}
  {A simple package to create show and tell slides}

\RequirePackage{l3keys2e}
\keys_define:nn { simplesnt } {
  no-progressbar .bool_set:N = \l_simplesnt_no_progressbar_bool,
}
\ProcessKeysOptions { simplesnt }

\LoadClass{beamer}

\RequirePackage{kotex}

%%% Math settings
\usepackage{amssymb, amsmath, mathtools} % Before unicode-math


%%% Beamer settings
\usetheme[
  numbering = fraction,
  progressbar = \bool_if:NTF \l_simplesnt_no_progressbar_bool { frametitle } { none }
]{metropolis}
\useoutertheme[subsection=false]{miniframes}
\usecolortheme{rose}

\setbeamertemplate{itemize~item}[square]
\setbeamertemplate{itemize~subitem}[triangle]
\setbeamertemplate{itemize~subsubitem}[circle]

\setbeamercolor{background~canvas}{bg=white}

\titlegraphic{%
  \begin{tikzpicture}[overlay,remember~picture]
    \node at (current~page.145) [xshift=3em, yshift=-1.3em] {
      \includegraphics[width=3em]{img/snu-symbol.png}
    };
    \node at (current~page.35) [xshift=-3em, yshift=-1.3em] {
      \includegraphics[width=2.5em]{img/ropas-symbol.png}
    };
  \end{tikzpicture}%
}


%%% Font settings
% Works for pdfLaTeX, XeLaTeX, and LuaLaTeX
\usepackage{libertine}

% Math/Mono font setup
\usepackage[
  math-style=ISO,
  warnings-off={mathtools-colon, mathtools-overbracket},
]{unicode-math}
\setmathfont{LibertinusMath-Regular.otf}[Scale = MatchUppercase]
\setmathfont{Garamond-Math.otf}[
  Scale = MatchUppercase,
  range = {\Coloneq, \coloneq},
]
\setmathfont{XITSMath-Regular.otf}[
  Scale = MatchUppercase,
  range = {\cup, bb},
]
\DeclareMathAlphabet{\mathcal}{OMS}{cmsy}{m}{n}
%\setmathfont{TeX Gyre Pagella Math}[range={\lbrace,\rbrace},Scale=1.1]
%\setmathfont{TeX Gyre Pagella Math}[range={\mathbb,\mathfrak},Scale=MatchUppercase]
%\setmathfont{Asana Math}[range={\checkmark,\bigtriangledown,\cup,\sqcup,\cap,\sqcap,\subseteq,\supseteq,\sqsubseteq,\sqsupseteq,\subset,\supset,\sqsubset,\sqsupset,\in,\ni,\notin},Scale=MatchUppercase]


\setmonofont{JuliaMono}[
  Scale=MatchLowercase,
]

\setmainhangulfont{Noto~Serif~CJK~KR}[AutoFakeSlant=0.15]
\setsanshangulfont{KoPubWorldDotum_Pro}[BoldFont={*~Bold}]
\setmonohangulfont{D2Coding}


\usepackage{newunicodechar}
\newfontfamily{\fallbackfont}{JuliaMono}[Scale=MatchLowercase]
\DeclareTextFontCommand{\textfallback}{\fallbackfont}
\newunicodechar{⚛}{\textfallback{⚛}}


%% Default info
\institute{ROPAS@SNU}

% \AtBeginDocument{
% }


%% The MIT License (MIT)
%%
%% Copyright © 2023 Jay Lee <jaeho.lee@snu.ac.kr>
%%
%% Permission is hereby granted, free of charge, to any person obtaining
%% a copy of this software and associated documentation files (the "Software"),
%% to deal in the Software without restriction, including without limitation
%% the rights to use, copy, modify, merge, publish, distribute, sublicense,
%% and/or sell copies of the Software, and to permit persons to whom the
%% Software is furnished to do so, subject to the following conditions:
%%
%% The above copyright notice and this permission notice shall be included
%% in all copies or substantial portions of the Software.
%%
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
%% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
%% OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
%% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
%% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
%% TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
%% OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%%
%% End of file `simplesnt.cls'.
