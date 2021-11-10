%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Felipe Portales' HomeWorks
% Maintainer: Felipe Portales-Oliva (f.portales.oliva@gmail.com)
% 
% Document class to produce simple yet stylish homework submissions 
%
% This package is public domain, according to :
%    The Unlicense <https://unlicense.org>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Identification

\NeedsTeXFormat{LaTeX2e} % we need to have LaTeX2e for this to compile
\ProvidesClass{fphw_assignment}[2020/10/01] % fphw is the name we need to provide to the documentclass command on the .tex file        % I have edited this class on 01/10/2020

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Preliminary declarations:
%%%% These are some commands where we declare new commands for the class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \usepackage{comment} % enables the use of multi-line comments (\ifx \fi) 
% \usepackage{lipsum} %This package just generates Lorem Ipsum filler text. 
% \usepackage{fullpage} % changes the margin
% \usepackage[a4paper, total={7in, 10in}]{geometry}
% \usepackage[fleqn]{amsmath}
% \usepackage{amssymb,amsthm}  % assumes amsmath package installed
% \newtheorem{theorem}{Theorem}
% \newtheorem{corollary}{Corollary}
% \usepackage{graphicx}
% \usepackage{tikz}
% \usetikzlibrary{arrows}
% \usepackage{verbatim}
% \usepackage[numbered]{mcode}
% \usepackage{float}
% \usepackage{tikz}
%     \usetikzlibrary{shapes,arrows}
%     \usetikzlibrary{arrows,calc,positioning}

%     \tikzset{
%         block/.style = {draw, rectangle,
%             minimum height=1cm,
%             minimum width=1.5cm},
%         input/.style = {coordinate,node distance=1cm},
%         output/.style = {coordinate,node distance=4cm},
%         arrow/.style={draw, -latex,node distance=2cm},
%         pinstyle/.style = {pin edge={latex-, black,node distance=2cm}},
%         sum/.style = {draw, circle, node distance=1cm},
%     }
% \usepackage{xcolor}
% \usepackage{mdframed}
% \usepackage[shortlabels]{enumitem}
% \usepackage{indentfirst}
% \usepackage{hyperref}
    
% \renewcommand{\thesubsection}{\thesection.\alph{subsection}}

% \newenvironment{problem}[2][Problem]
%     { \begin{mdframed}[backgroundcolor=gray!20] \textbf{#1 #2} \\}
%     {  \end{mdframed}}

% % Define solution environment
% \newenvironment{solution}
%     {\textit{Solution:}}
%     {}

% \renewcommand{\qed}{\quad\qedsymbol}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% We define the macro for the name of the professor
\newcommand{\professor}[1]{ \newcommand{\professorloc}{#1} }
% We define the macro for the name of the course
\newcommand{\course}[1]{ \newcommand{\courseloc}{#1} }
% We define the macro for the name of the institution
\newcommand{\institute}[1]{ \newcommand{\instituteloc}{#1} }
% We define the macro for the name of the class roll
\newcommand{\roll}[1]{ \newcommand{\rollloc}{#1} }
% We define the macro for the name of the class
\newcommand{\class}[1]{ \newcommand{\classloc}{#1} }
% We define the macro for the name of the session
\newcommand{\session}[1]{ \newcommand{\sessionloc}{#1} }
% We define the macro for the email
\newcommand{\email}[1]{ \newcommand{\emailloc}{#1} }

%these are auxiliary definitions used in the title section
\newcommand{\CourseLang}{Course}
\newcommand{\DateLang}{Submission date}
\newcommand{\StudentLang}{}
\newcommand{\ProfessorLang}{Teacher}
\newcommand{\RollLang}{Roll}           % created by me on [01-10-20]
\newcommand{\ClassLang}{Class}                 % created by me on [01-10-20]
\newcommand{\SessionLang}{Session}     % created by me on [01-10-20]
%\newcommand{\InstituteLang}{}   % created by me on [17-08-20]
\newcommand{\EmailLang}{Email}     % created by me on [01-10-20]

% Header and footers, we will use the titles also
\RequirePackage{fancyhdr}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Options
%%%% We now pass the options of the class

% Two Columns are difficult to read and grade, we will not use them
\DeclareOption{twocolumn}{\OptionNotUsed}

% Two sided paper are difficult to read and grade, we will not use them
\DeclareOption{twoside}{\OptionNotUsed}


\PassOptionsToClass{a4paper}{article}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Bulk Declarations
%%%% Here we do more declarations and call other files

% we need to load 
\LoadClass{article}

% all my packages are loaded here
%\RequirePackage{my_packages}

% we will modify sections, subsections and sub subsections
\RequirePackage{titlesec}
% Modification of section 
\titleformat{\section}[block]{\normalsize\bfseries\filcenter}{\thesection.}{.3cm}{} 

% modification of subsection and sub sub section
\titleformat{\subsection}[runin]{\bfseries}{ \thesubsection.}
{1mm}{}[\break]
\titleformat{\subsubsection}[runin]{\bfseries\itshape}{ \thesubsubsection.}
{1mm}{}[\break]

% Geometry lets us modify the sizes of the document nicely
\RequirePackage{geometry}
% Decent margins for the documents, as it is meant to be printed
\geometry{left=2.5cm,right=2.5cm,top=2.5cm,bottom=2.5cm}



\fancypagestyle{head}{%
 \fancyhf{}% clear all header and footer fields
 \renewcommand{\headrulewidth}{0.4pt} % we want rules 
 \renewcommand{\footrulewidth}{0.4pt}
 \fancyhead[RO] {\footnotesize\thepage}
 \fancyhead[LO] {\footnotesize{\ifx\courseloc\undefined{}\else\itshape\courseloc{} --{} \fi}\makeatletter\@title\makeatother }
 \fancyfoot[RO] {\footnotesize\itshape\makeatletter\@author\makeatother}
 \fancyfoot[LO] {\footnotesize\thepage}            % created by me on [3-10-20]  
}
\fancypagestyle{nohead}{%
 \fancyhf{}% clear all header and footer fields
 \renewcommand{\headrulewidth}{0pt}
 \renewcommand{\footrulewidth}{0.4pt}
 \fancyfoot [CO]{\footnotesize\thepage}
}

% New title style for the document
\renewcommand{\maketitle}{
    \newpage      % ensure this is in a new page 
    \thispagestyle{nohead}
    \begin{center}
        \includegraphics[scale=.3]{bits_logo.png}\\
        \ifx\instituteloc\undefined\else {\scshape \instituteloc}\\[10pt] \fi              % for academic assignment
        \hrule
        \vspace{10pt}
        {\LARGE  \bfseries \@title} \\[5pt]
        \StudentLang {\itshape \@author} \\ [0pt]
        \ifx\rollloc\undefined\else\RollLang: {\itshape\rollloc} \\ [0pt]                % created by me on [01-10-20]  
        \ifx\classloc\undefined\else \ClassLang: {\itshape\classloc} \\ [0pt]             % created by me on [01-10-20]    
        \ifx\sessionloc\undefined\else \SessionLang: {\itshape\sessionloc} \\ [0pt]       % created by me on [01-10-20]
        \ifx\emailloc\undefined \else \EmailLang: {\itshape\href{mailto:\emailloc}{\emailloc}} \\ [0pt]  % created by me on [04-10-20]
        %\ifx\instituteloc\undefined{}\else{\InstituteLang {\itshape\instituteloc}}
        \vspace{8pt}
        \hrule
        \vspace{10pt}
        \ifx\courseloc\undefined\else\CourseLang: {\itshape \courseloc{} \ifx\professorloc\undefined{}\else{-- }\fi  }\fi
        \ifx\professorloc\undefined\else{\ProfessorLang: {\itshape\professorloc}} \\ [0pt] \fi 
        \DateLang: {\itshape\@date}
        \vspace{8pt}
        \hrule
        \vspace{20pt}
    \end{center}
}



\pagestyle{head}
% definition of the "problem" environment
\newsavebox{\problembox}
\newenvironment{problem}
    {\begin{center} \begin{lrbox}{\problembox}\begin{minipage}{.98\textwidth}}
    {\end{minipage}\end{lrbox}\fbox{\usebox{\problembox}} \end{center} }

%%% We finish the class with this command
\endinput