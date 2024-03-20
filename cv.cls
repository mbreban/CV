\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2024/04/10 CV LaTeX class]

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}

\newcommand{\headlinecolor}{\normalcolor}
\RequirePackage{xcolor}
\definecolor{slcolor}{HTML}{882B21}

\RequirePackage{etoolbox}

% --------------------------------------------------------------------------------------------------
% Fonts
\RequirePackage[fixed]{fontawesome5}
\RequirePackage{iwona}

% --------------------------------------------------------------------------------------------------
% Options

\newcommand{\multilang}[2] {#1|#2}

\DeclareOption{fr}{\renewcommand{\multilang}[2]{#1}}
\DeclareOption{en}{\renewcommand{\multilang}[2]{#2}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[a4paper]{article}

% --------------------------------------------------------------------------------------------------
% Key-value options

\RequirePackage{xkeyval}

\newlength\mymargin

\DeclareOptionX{margin}{\setlength{\mymargin}{#1}}
\ExecuteOptionsX{margin=0.5in}
\ProcessOptionsX\relax

% --------------------------------------------------------------------------------------------------
% Layout

\RequirePackage{fancyhdr,calc}

\pagestyle{fancy}
\fancyhf{}

\renewcommand{\headrulewidth}{0pt}

\RequirePackage{geometry} % ,showframe

\geometry{
  margin = \the\mymargin,
  headsep = 10pt,
  textheight = 780pt,
}

\setlength{\topmargin}{-1in}

% --------------------------------------------------------------------------------------------------
% Header

\def\CV@AuthorFirstName {John}
\def\CV@AuthorLastName {Doe}
\def\CV@PhoneNumber {}
\def\CV@Email {}
\def\CV@Address {}
\def\CV@LinkedInLink {}
\def\CV@LinkedInName {}
\def\CV@GithubLink {}
\def\CV@GithubName {}
\def\CV@MediumLink {}
\def\CV@MediumName {}
\def\CV@Tagline {}
\def\CV@PicPath {}

\DeclareDocumentCommand{\AuthorName}{ m m }{%
  \renewcommand{\CV@AuthorFirstName}{#1}%
  \renewcommand{\CV@AuthorLastName}{#2}%
}

\DeclareDocumentCommand{\PhoneNumber}{ m }{%
  \renewcommand{\CV@PhoneNumber}{#1}%
}

\DeclareDocumentCommand{\Email}{ m }{%
  \renewcommand{\CV@Email}{#1}%
}

\DeclareDocumentCommand{\Address}{ m }{%
  \renewcommand{\CV@Address}{#1}%
}

\DeclareDocumentCommand{\LinkedIn}{ m m }{%
  \renewcommand{\CV@LinkedInLink}{#1}%
  \renewcommand{\CV@LinkedInName}{#2}%
}

\DeclareDocumentCommand{\Github}{ m m }{%
  \renewcommand{\CV@GithubLink}{#1}%
  \renewcommand{\CV@GithubName}{#2}%
}

\DeclareDocumentCommand{\Medium}{ m m }{%
  \renewcommand{\CV@MediumLink}{#1}%
  \renewcommand{\CV@MediumName}{#2}%
}

\DeclareDocumentCommand{\Tagline}{ m }{%
  \renewcommand{\CV@Tagline}{#1}%
}

\DeclareDocumentCommand{\PicPath}{ m }{%
  \renewcommand{\CV@PicPath}{#1}%
}

\RequirePackage{adjustbox}

\newlength\myheaderheight

\newcommand{\headergobble}{%
  \begin{adjustbox}{minipage={\textwidth},gstore totalheight=\myheaderheight,gobble}
    \headercontent%
  \end{adjustbox}
}

\newcommand{\header}{%
  \begin{adjustbox}{minipage={\textwidth}}
    \headercontent%
  \end{adjustbox}
}

\RequirePackage{hyperref}
\RequirePackage{graphicx}

\newcommand{\headercontent}{%
  \hypersetup{
    linkcolor=text-color,
    urlcolor=text-color,
    citecolor=text-color,
  }
  \ifcsvoid{CV@PicPath}{%
    \begin{minipage}[c]{0.5\textwidth}
  }{%
    \begin{minipage}[c]{0.15\textwidth}
      \includegraphics[width=\textwidth - \mymargin]{\CV@PicPath}
    \end{minipage}%
    \begin{minipage}[c]{0.35\textwidth}
  }%
    \smallskip
    {\Huge\CV@AuthorFirstName\ \textsc{\textbf{\CV@AuthorLastName}}}

    \ifcsvoid{CV@Tagline}{}{
      \medskip
      \CV@Tagline
    }
    \smallskip
  \end{minipage}%
  \begin{minipage}[c]{0.5\textwidth}
    \setlength{\tabcolsep}{3pt}

    \begin{flushright}
      \smallskip
      \begin{tabular}{rl}
        \ifcsvoid{CV@Email}{}{
        \faEnvelope & \CV@Email\\
        }
        \ifcsvoid{CV@PhoneNumber}{}{
        \faPhone* & \CV@PhoneNumber\\
        }
        \ifcsvoid{CV@Address}{}{
        \faMapMarker* & \CV@Address\\
        }
        \ifcsvoid{CV@LinkedInLink}{}{
        \faLinkedin & \href{\CV@LinkedInLink}{\CV@LinkedInName}\\
        }
        \ifcsvoid{CV@GithubLink}{}{
        \faGithub & \href{\CV@GithubLink}{\CV@GithubName}\\
        }
        \ifcsvoid{CV@MediumLink}{}{
        \faMedium & \href{\CV@MediumLink}{\CV@MediumName}\\
        }
      \end{tabular}
      \smallskip
    \end{flushright}
  \end{minipage}
}

\RequirePackage{tikz}

\renewcommand{\maketitle}{
  \fancyhead{%
    \color{text-color}
    \begin{tikzpicture}[remember picture,overlay]
      \fill[fill=primary-color] (current page.north west) rectangle +(\paperwidth,-\myheaderheight);
    \end{tikzpicture}%
    \header
  }
}

\RequirePackage{titlesec}

\newcommand{\strip} {%
  \noindent\begin{tikzpicture}[baseline=(Strip.text)]
    \useasboundingbox (0,0) rectangle (0,0);
    \node[rectangle,minimum width={0.3in - 0.3ex},fill=light-primary-color,text=light-primary-color,inner ysep=0pt,anchor=base west] (Strip) at (-0.3in,0) {I};
  \end{tikzpicture}%
}

\titleformat{name=\section}
  {\color{primary-text-color}\normalfont\bfseries\Large} % formatting commands to apply to the whole heading
  {} % the label and number
  {0pt} % space between label/number and section title
  {\strip} % formatting commands applied just to section title
  [] % punctuation or other commands following section title

\titleformat{name=\section,numberless}[runin] % runin puts it in the same paragraph
  {\color{primary-text-color}\normalfont\bfseries\Large} % formatting commands to apply to the whole heading
  {} % the label and number
  {0pt} % space between label/number and section title
  {\strip} % formatting commands applied just to section title
  [\hspace*{10pt}] % punctuation or other commands following section title

\titlespacing*{\section}
  {0pt} % left
  {1ex plus .2ex} % before
  {1ex plus .2ex} % after

% -------------
% Colors

\definecolor{gray-50}{HTML}{FAFAFA}
\definecolor{gray-100}{HTML}{F5F5F5}
\definecolor{gray-200}{HTML}{EEEEEE}
\definecolor{gray-300}{HTML}{E0E0E0}
\definecolor{gray-400}{HTML}{BDBDBD}
\definecolor{gray-500}{HTML}{9E9E9E}
\definecolor{gray-600}{HTML}{757575}
\definecolor{gray-700}{HTML}{616161}
\definecolor{gray-800}{HTML}{424242}
\definecolor{gray-900}{HTML}{212121}

\definecolor{blue-50}{HTML}{E3F2FD}
\definecolor{blue-100}{HTML}{BBDEFB}
\definecolor{blue-200}{HTML}{90CAF9}
\definecolor{blue-300}{HTML}{64B5F6}
\definecolor{blue-400}{HTML}{42A5F5}
\definecolor{blue-500}{HTML}{2196F3}
\definecolor{blue-600}{HTML}{1E88E5}
\definecolor{blue-700}{HTML}{1976D2}
\definecolor{blue-800}{HTML}{1565C0}
\definecolor{blue-900}{HTML}{0D47A1}


\colorlet{dark-primary-color}  {blue-700}
\colorlet{light-primary-color} {blue-100}
\colorlet{primary-color}       {blue-500}
\colorlet{text-color}          {white}
\colorlet{accent-color}        {gray-500}
\colorlet{primary-text-color}  {gray-900}
\colorlet{secondary-text-color}{gray-600}
\colorlet{divider-color}       {gray-400}

\color{primary-text-color}

\AtBeginDocument{
  \headergobble

  \addtolength{\textheight}{\the\headheight - \the\myheaderheight}
  \setlength{\headheight}{\the\myheaderheight}

  \savegeometry{hack}
  \loadgeometry{hack}

  \colorlet{defaultcolor}{.}
}

% --------------------------------------------------------------------------------------------------
% Misc

\hypersetup{
colorlinks=true,
linkcolor=dark-primary-color,
urlcolor=dark-primary-color,
citecolor=dark-primary-color,
frenchlinks=true,
pdfborder={0 0.6 1}
}

\RequirePackage{makecell}
\RequirePackage{tabularx}

\newcolumntype{R}[1]{>{\raggedleft\arraybackslash }b{#1}}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash }b{#1}}
\newcolumntype{C}[1]{>{\centering\arraybackslash }b{#1}}

\RequirePackage{keyval}
\RequirePackage{environ}

\define@key{experience@keys}{start}{\def\experience@start{#1}}%
\define@key{experience@keys}{end}{\def\experience@end{#1}}%
\define@key{experience@keys}{city}{\def\experience@city{#1}}%
\define@key{experience@keys}{color}{\def\experience@color{#1}}%

\newenvironment{experience}[3][]{
  \setkeys{experience@keys}{start=,end=,city=,color=dark-primary-color,#1}

  \noindent
  \tabularx{\textwidth}{>{\begin{sc}}R{0.8in}<{\end{sc}} !{\color{\experience@color}\vrule} X}

  \experience@start & \textbf{#2} \\
  \experience@end & #3 \ifcsvoid{experience@city}{}{-- \experience@city} \\
     & \begin{minipage}[t]{\linewidth}\begin{small}
}{%
  \end{small}\end{minipage} \\
  \endtabularx
  \medskip
}


\RequirePackage{enumitem}
\RequirePackage{multicol}

\setlist[itemize]{label=\checkmark,nolistsep,noitemsep,leftmargin=*,topsep=0pt,partopsep=0pt}

\newlist{itemulticols}{itemize}{1}
\setlist[itemulticols]{
    label=\checkmark,
    before=\setlength{\multicolsep}{0pt}\begin{multicols}{2},
    after=\end{multicols},
	nolistsep,noitemsep,leftmargin=*,topsep=0pt,partopsep=0pt
}

\newcommand{\bkt}[1] {\hfill{\color{secondary-text-color}(\textit{#1})}}
