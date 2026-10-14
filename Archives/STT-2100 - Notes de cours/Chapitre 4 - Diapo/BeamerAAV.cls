% Classe créée par Jérôme Soucy (jsoucy@mat.ulaval.ca)
% Version partagée : 29 décembre 2022
% Modifié par Julien Miron
% Modifié par Audrey-Anne Vallée
% Mai 2026

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{BeamerAAV}
\LoadClass[aspectratio=169,
			handout,
			xcolor=table,12pt]{beamer}
\RequirePackage{iftex}

\ifXeTeX
		\RequirePackage{polyglossia}
			\setdefaultlanguage[frenchpart=false]{french}
		\RequirePackage[math-style=TeX, bold-style=upright]{unicode-math}
		\setmainfont{Linux Libertine O}
		\setsansfont{Linux Biolinum O}[Ligatures=TeX,Scale=MatchLowercase]
		\setmathfont{Latin Modern Math}
		\setmathfont[range=\setminus]{XITS Math}
	\else
		\RequirePackage[french]{babel}
		\RequirePackage[T1]{fontenc}
		\RequirePackage[utf8]{inputenc}
		\RequirePackage{amsmath}
		\RequirePackage{amsfonts}
		\usepackage{libertine}
		\usepackage[frenchmath]{libertinust1math}
	\fi
\RequirePackage{hyperref}
	\hypersetup{
		pdfencoding=auto,
		breaklinks=true,
		colorlinks=true,
		linkcolor=.,
		filecolor=blue,
		urlcolor=blue,
		anchorcolor=.,
		citecolor=blue}
\RequirePackage{url}
	\renewcommand{\UrlFont}{\scriptsize}

\RequirePackage[many]{tcolorbox}
\RequirePackage{fontawesome5}
\RequirePackage{siunitx}
\RequirePackage{centernot}
\newcommand{\defi}[1]{\textbf{{\color{Dominante}{#1}}}}

\usefonttheme{professionalfonts}
\setbeamersize{sidebar width left=0pt}
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{footline}[frame number]

\setbeamerfont{frametitle}{size=\large, series=\bfseries} %titre des diapos, en large + gras
\setbeamerfont{title}{size=\Large, series=\bfseries} %titre des sections, en large + gras



\setbeamercolor{alerted text}{fg=burntorange}

\newcommand{\alerter}[1]{\textcolor{burntorange}{#1}}


\newcounter{examplecounter}
\setcounter{examplecounter}{0}

\newenvironment{exampleframe}{%

\addtocounter{somecounter}{1}
\begin{frame}[t]{Exemple \theexamplecounter}
}{
\end{frame}
}

\usepackage{subfiles}


\newcommand{\mysection}[1]{
\section{{#1}}
\begin{frame}
\begin{sct}
{#1}
\end{sct}
\end{frame}
}

\setbeamercolor{colsection}{fg=Dominante!20,bg=Dominante}

\setbeamertemplate{section page}
{
    \begin{centering}
    \begin{beamercolorbox}[sep=12pt,center]{colsection}
    \usebeamerfont{section title}\insertsection\par
    \end{beamercolorbox}
    \end{centering}
}


\definecolor{burntorange}{RGB}{242, 96, 53}

\definecolor{Dominante}{rgb}{0.8, 0.7, 1.0} % Couleur principale du beamer. Sert pour les 
% - titres de section
% - boite \bte
\definecolor{exemple}{rgb}{0.67, 0.94, 0.82}

\definecolor{Accent}{RGB}{239, 131, 84} % Couleur secondaire du beamer. Sert pour les
% - Théorèmes
% - Propositions

\definecolor{Fond}{RGB}{252,252,252} % couleur du fond

\definecolor{TitreDiapo}{rgb}{0.2, 0.07, 0.48} % Couleur du titre des diapos


\definecolor{TexteBte}{rgb}{0.2, 0.07, 0.48} % Couleur du texte des boîtes
\definecolor{TitreBte}{rgb}{0.2, 0.07, 0.48} % Couleur du titre des boîtes

\definecolor{TexteThm}{RGB}{0, 0, 0} % Couleur du texte des théorèmes
\definecolor{TitreThm}{RGB}{0, 0, 0} % Couleur du titre des théorèmes


\definecolor{itemizecolor}{RGB}{0,0,0} % coleur des énumérations

\definecolor{rougelaval}{RGB}{237,28,36} % couleur Rouge ULaval
\definecolor{jaunelaval}{RGB}{251,199,7} % couleur Jaune ULaval

\colorlet{DefnColorBar}{Dominante} % couleur de la barre des définitions
\colorlet{DefnColorBG}{Dominante!10} % couleur du fond des définitions

\colorlet{ThmColorBar}{Accent} % couleur de la barre des théorèmes
\colorlet{ThmColorBG}{Accent!20} % couleur du fond des théorèmes

\colorlet{PropColorBar}{Accent} % couleur de la barre des propositions
\colorlet{PropColorBG}{Accent!20} % couleur du fond des propositions

\setbeamercolor{background canvas}{bg=Fond} % couleur du fond
\setbeamercolor{block body}{bg=normal text.bg!90!black}
\setbeamercolor{block title}{bg=black!60, fg=white}
\setbeamercolor{block title example}{fg=example text.fg!75!normal text.fg,bg=Fond}
\setbeamercolor{normal text}{bg=Fond,fg=black}


\setbeamercolor{structure}{bg=black, fg=white}
\setbeamercolor{frametitle}{fg=TitreDiapo,bg=Fond}

\setbeamercolor{itemize item}{fg=itemizecolor}
\setbeamercolor{enumerate item}{fg=itemizecolor}
\setbeamercolor{itemize subitem}{fg=itemizecolor}
\setbeamercolor{itemize subsubitem}{fg=itemizecolor}

\setbeamertemplate{itemize item}[circle]
\setbeamertemplate{itemize subitem}[square]
\setbeamertemplate{itemize subsubitem}[triangle]

\newtcolorbox[auto counter]{defn}[1][]{
	boxrule=0pt,
	boxsep=0pt,
	colback=DefnColorBG,
	enhanced jigsaw,
	detach title,
	fonttitle=\bfseries,coltitle=black,
	title=Définition.~, %~\thetcbcounter.
	before upper={\tcbtitle},
	borderline west={2pt}{0pt}{DefnColorBar},
	sharp corners,
	before skip=10pt,
	after skip=10pt,
	breakable,
}

\newtcolorbox[auto counter]{thm}[2][]{
	boxrule=0pt,
	boxsep=0pt,
	colback=ThmColorBG,
	enhanced jigsaw,
	detach title,
	fonttitle=\bfseries,coltitle=TitreThm,
        coltext=TexteThm,
	title=Théorème~#2.,
	before upper={\tcbtitle},
	borderline west={2pt}{0pt}{ThmColorBar},
	sharp corners,
	before skip=10pt,
	after skip=10pt,
	breakable,
}
\newtcolorbox[auto counter]{prp}[2][]{
	boxrule=0pt,
	boxsep=0pt,
	colback=PropColorBG,
	enhanced jigsaw,
	detach title,
	fonttitle=\bfseries,coltitle=black,
	title=Proposition.\ #2, %~\thetcbcounter.
	before upper={\tcbtitle},
	borderline west={2pt}{0pt}{PropColorBar},
	sharp corners,
	before skip=10pt,
	after skip=10pt,
	breakable,
}
\newtcolorbox[auto counter]{bte}[2][]{
	boxrule=0pt,
	boxsep=0pt,
	colback=Dominante!20,
	collower=Fond,
	enhanced jigsaw,
    fonttitle=\medskip\bfseries,coltitle=TitreBte,
	coltext=TexteBte,
	title= #2,
	colbacktitle=Dominante,
	before upper={\tcbtitle},
	borderline west={2pt}{0pt}{Dominante},
	sharp corners,
	before skip=10pt,
	after skip=10pt,
        bottomtitle = 1mm,
        toptitle = 1mm,
	breakable,
}
\newtcolorbox[auto counter]{exe}[2][]{
	boxrule=0pt,
	boxsep=0pt,
	colback=exemple!20,
	collower=Fond,
	enhanced jigsaw,
    fonttitle=\medskip\bfseries,coltitle=TitreBte,
	coltext=TexteBte,
	title= #2,
	colbacktitle=exemple,
	before upper={\tcbtitle},
	borderline west={2pt}{0pt}{exemple},
	sharp corners,
	before skip=10pt,
	after skip=10pt,
        bottomtitle = 1mm,
        toptitle = 1mm,
	breakable,
}


% Define a new counter
\newcounter{exemplecounter}

% Define the example environment
\newenvironment{exemple}
  {
    \stepcounter{exemplecounter} % Increment the counter
    \begin{frame}[t]
      \frametitle{Exemple \theexemplecounter} % Set the frame title with the counter
      % No indentation and start of example content
  }
  {
      % End of example content and end of frame
    \end{frame}
  }

  \newenvironment{exempleblank}
  {
    \begin{frame}[t]
      \frametitle{Exemple \theexemplecounter} % Set the frame title with the counter
      % No indentation and start of example content
  }
  {
      % End of example content and end of frame
    \end{frame}
  }

% Define the example environment
\newenvironment{exemplesuite}[1][]
  {
    \begin{frame}[t]
      \frametitle{Suite de l'exemple de la diapo #1} % Set the frame title with the counter
      % No indentation and start of example content
  }
  {
      % End of example content and end of frame
    \end{frame}
  }

\defbeamertemplate*{title page}{titlepage}
{
	\thispagestyle{empty}
	\vspace{0.5cm}
	\begin{minipage}{0.9\textwidth}
		{\Large\color{black} \inserttitle\par}
		{\large \color{black!67} \insertsubtitle\par}
	\end{minipage}\\[3cm]
	\hspace*{-5cm}\includegraphics{ligneUL.png}\\
	\vspace{1cm}
	\begin{minipage}[c]{0.35\textwidth}
		\includegraphics[width=4cm]{logoUL.pdf}
		\vspace{2cm}
	\end{minipage}
	\hfill
	\begin{minipage}[c]{0.55\textwidth}
		{\color{black} \textbf{\insertauthor}\par}
		\medskip
		{\footnotesize
		\insertinstitute}
  \vspace{2cm}
\end{minipage}}

% Bibliographie
\RequirePackage[backend=biber,
				style=numeric-comp,
				sorting=none]{biblatex}
\addbibresource{reference.bib}
\setbeamercolor{bibliography entry author}{fg=black}
\setbeamercolor{bibliography entry location}{fg=black}
\setbeamercolor{bibliography entry note}{fg=black}
\setbeamercolor{bibliography item}{fg=black}

