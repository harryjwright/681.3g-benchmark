\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{embassy}[2026/04/02 Mobile Embassy Forensic Class - V2.1]

% ==========================================
% 1. BASE CONFIGURATION & LAYOUT
% ==========================================
\LoadClass[a4paper,11pt]{article}

\RequirePackage[margin=1in]{geometry}
\RequirePackage{atbegshi}
\RequirePackage{float}
\RequirePackage{lastpage}
\RequirePackage{graphicx}
\RequirePackage{capt-of}
\RequirePackage[most]{tcolorbox}

% --- Typography (LuaLaTeX Required for IBM Plex Mono) ---
\RequirePackage{fontspec}
\RequirePackage{unicode-math}
\RequirePackage{amsmath}
\RequirePackage{censor}

% The "Intelligence Archive" Font Face
\setmainfont[LetterSpace=5.0]{IBM Plex Mono}
\setmonofont[LetterSpace=5.0]{IBM Plex Mono}
\setsansfont[LetterSpace=5.0]{IBM Plex Mono}
\setmathfont{IBM Plex Math}

% ==========================================
% 2. TABLES & LANDSCAPE MANAGEMENT
% ==========================================
\RequirePackage{rotating}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{pdflscape}
\RequirePackage[table]{xcolor}

% ==========================================
% 3. BIBLIOGRAPHY & HYPERREF (CRITICAL ORDER)
% ==========================================
% Load natbib BEFORE hyperref to prevent citation jitter
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage{xurl}
\RequirePackage{breakurl}

\definecolor{CiteRed}{rgb}{0.7, 0.0, 0.0}
\definecolor{UrlBlue}{rgb}{0.0, 0.1, 0.4}
\definecolor{DateGold}{rgb}{0.5, 0.4, 0.1} % A dense, heavy metallic tone

\RequirePackage{hyperref}
\hypersetup{
	colorlinks=true,
	linkcolor=black,
	citecolor=CiteRed,
	urlcolor=UrlBlue,
	bookmarksopen=true,
	bookmarksnumbered=true,
	pdfauthor={SYSTEM_AUDIT_SIG-01},
	pdftitle={681.3g_ASSET_VALUATION_NON_SPOLIATION},
	pdfsubject={FORENSIC_LEDGER_REF_2664144}
}

% --- Paragraph & HBox Control (Prevent Margin Bleed) ---
\emergencystretch=3em
\tolerance=2000
\hbadness=10000

% ==========================================
% 5. FORENSIC MACROS
% ==========================================

% Personnel Audit Box
\newcommand{\personnel}[6]{%
	\begin{tcolorbox}[
			colback=white, colframe=black, sharp corners, boxrule=1.5pt,
			title=\textbf{CLASSIFIED PERSONNEL AUDIT: SUBJECT REF #1},
			colbacktitle=black, coltitle=white, fonttitle=\small\bfseries,
			before skip=15pt, after skip=15pt
		]
		\begin{minipage}[t]{0.40\textwidth}
			\vspace{0pt}\centering
			\includegraphics[width=\textwidth]{#2}
			\captionof{figure}{#3}
		\end{minipage}\hfill
		\begin{minipage}[t]{0.55\textwidth}
			\vspace{0pt}\small
			\textbf{ALIAS:} #4 \\
			\textbf{DESIGNATION:} #5 \\
			\textbf{FORENSIC NOTE:} #6
		\end{minipage}
		\vspace{5pt}\hrule\vspace{5pt}
		\footnotesize \textbf{STATUTORY STATUS:} Subject to \textbf{MAR} and \textbf{SFO} scrutiny via the \textbf{14/03 Statutory Default}. Record spoliation (Ref: \S173 DPA) is actively being mapped.
	\end{tcolorbox}
}

% Sovereign Signoff
\newcommand{\signoff}[1]{
	\vspace{1cm}
	\noindent Sincerely,
	\vspace{0.5cm}
	\noindent\includegraphics[width=0.4\textwidth]{SIG.png}
	\vspace{0.5cm}
	\noindent\textbf{Harry Wright}\\
	#1
}

\newcommand{\dinkus}{\begin{center}\vspace{1em}* \quad * \quad *\vspace{1em}\end{center}}

% ==========================================
% 6. HEADERS & FOOTERS (GHOST FENCE)
% ==========================================
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\rfoot{\thepage\ of \pageref{LastPage}}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt} % Restore the footer boundary
\setlength{\headheight}{14pt} % Satisfies the 13.59999pt requirement
\addtolength{\topmargin}{-2pt} % Offsets the headheight increase to maintain layout

% ==========================================
% 7. NODE ANONYMIZATION (LuaTeX Only)
% ==========================================
\pdfvariable trailerid{}
\pdfvariable suppressoptionalinfo 511

% Bold URL and Href Overrides
\renewcommand{\UrlFont}{\bfseries\ttfamily}
\AtBeginDocument{
	\let\oldhref\href
	\renewcommand{\href}[2]{\oldhref{#1}{\textbf{#2}}}
}


\endinput
