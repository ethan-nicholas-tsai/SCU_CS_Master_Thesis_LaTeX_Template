% 文件名：scuthesis-cyc.cls
% 文件描述：以 ctexbook 文档类为基础，定义四川大学学位论文文档类
% 作者：Yicheng Cai
% 参考：pkuthss-1.2beta
% 修改日期：2024年4月6日
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{../Template/scuthesis-cyc}[2024/04/06 v0.1]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 声明传入参数，定义对应的论文类别，分别对应博士、硕士和学士学位论文。这里由于tex对中文支持不够，因此不能在此定义论文名称。
% 加载key value options
\RequirePackage{xkeyval}

\def\approval{0}
\def\colortitle{0}
\def\secret{0}
\DeclareOption{doctor}{\def\thesistype{0}}
\DeclareOption{master}{\def\thesistype{1}}
\DeclareOption{approval}{\def\approval{1}}
\DeclareOption{color}{\def\colortitle{1}}
\DeclareOption{secret}{\def\secret{1}}
\DeclareOption{academic}{\def\degreetype{0}}
\DeclareOption{professional}{\def\degreetype{1}}
\DeclareOption{bachelor}{\def\thesistype{2}}

% CYC
% 声明传入参数，定义对应的论文版面，分别对应16开的34字10版、34字24版、36字24版、37字网传版和A4纸38字符计院版
\DeclareOption{34chwd}{\def\pagesize{0}}  % 34字符16开CyberSecurity学院群Word版（2010年老标准）
\DeclareOption{34ch}{\def\pagesize{1}} % 34字符16开24年自用版（一页可以写更多内容，理论上比word版更好用）
\DeclareOption{36ch}{\def\pagesize{2}} % 36字符16开24年自用版（2024最新标准）
\DeclareOption{37ch}{\def\pagesize{3}} % 37字符16开网传版（有点失败，不伦不类）
\DeclareOption{38ch}{\def\pagesize{4}} % 38字符A4计院版（计算机学院A4模板）

% CYC
% 声明传入参数，定义对应的图表标题仅中文还是双语
\DeclareOption{caption-bi}{\def\captiontype{0}}  % 双语图表标题
\DeclareOption{caption-cn}{\def\captiontype{1}} % 中文图表标题

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% （0-1）Setup（CYC）

% 将文档类其他参数全部传递给 ctexbook 文档类。
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax

% 此文档类以 ctexbook 为基础，设定页面尺寸为 A4，默认字号为小四号。
% CJKfntef 宏包提供了 \maketitle 中用到的 \CJKunderline 命令。
% fancyhdr 宏包提供了方便使用的命令用于设置页眉、页脚。
% TODO: 根据条件加载基类

% 单面评审版本（默认）
\LoadClass[fntef, a4paper, fancyhdr, cs4size, oneside]{ctexbook} 
% 双面打印模式
%\LoadClass[a4paper,UTF8,twoside, openright, zihao=-4]{ctexbook} 

% 设置文档默认行距为20pt
\setlength{\baselineskip}{20pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% （0-2）加载宏包（CYC）

% 加入判断支持
\RequirePackage{ifthen}
% 此宏包提供图形支持。
\RequirePackage{graphicx}

%设置字体
\RequirePackage{xeCJK}
% 手动载入xeCJKfntef包，用于兼容2.5以上的ctex版本
\RequirePackage{xeCJKfntef}


% 使用epstopdf宏包重定向eps输出路径，避免图片错误
\RequirePackage[outdir=./]{epstopdf}

% 使用hyperref宏包去除索引上的颜色标记
\RequirePackage{hyperref}
\hypersetup{pdfborder=0 0 0}
% 使用tocloft宏包修改目录样式
\RequirePackage{tocloft}
% 目录中显示目录项和参考文献项
%\RequirePackage{tocbibind}
\RequirePackage[nottoc,notlof,notlot]{tocbibind}

% 颜色
\RequirePackage{xcolor}
% lipsum
\RequirePackage{lipsum}
% 定义表格中的多行单元
\RequirePackage{multirow}
\newcommand{\tabincell}[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}}
% 引入landscape排版
\RequirePackage{lscape}
% 引入算法包
\RequirePackage{algorithm}
\RequirePackage{algorithmic}
\floatname{algorithm}{算法}  
\renewcommand{\algorithmicrequire}{\textbf{输入:}}  
\renewcommand{\algorithmicensure}{\textbf{输出:}}

% 支持ams数学宏包
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amsthm}
\RequirePackage{mathtools}
\RequirePackage{amssymb}
% 支持float图片环境
\RequirePackage{float}
% 三线表支持
\RequirePackage{booktabs}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% （1）参考文献引用格式（CYC）
% 解图表目录引用编号顺序问题
\RequirePackage{notoccite}

%\PassOptionsToPackage{backref=page}{hyperref}

% GBT7714-2015引用格式
\RequirePackage[sort&compress]{gbt7714}
% 失败
%\PassOptionsToPackage{backend=biber,style=gb7714-2015}{biblatex}
%\RequirePackage{biblatex}
% 加入hyperref超链接参考
\RequirePackage{hyperref} 

% 使用natbib宏包修改参考文献段间距
\RequirePackage{natbib}
\setlength{\bibsep}{0pt}

% 使用natbib宏包修改参考文献行距和参考标记样式
%               上标	方括号	逗号分隔	自动排序分类
%\RequirePackage[super,square,comma,sort&compress]{natbib}
%\setlength{\bibsep}{0.5ex}
% 定义 \incite 命令，用于如“文献[1]”这样的引用
\newcommand*{\incite}{}
\DeclareRobustCommand*{\incite}[2][]{
	\begingroup
	% \romannumeral-`\x
	\setcitestyle{numbers}
	\hspace{-1em}~\cite[#1]{#2}\hspace{-0.3em}
	\endgroup
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% （2）论文版面大小（CYC）
% 设置16K页面  0.5cm两字符

\ifthenelse{\equal{\pagesize}{0}}{   % 一行34个中文字符（word版）
	\RequirePackage{anysize}
	\papersize{26cm}{18.4cm}
	% 左边距 1.95cm，右边距 1.95cm，上边距 1.25cm，下边距 1.25cm，版心 215×145mm
	\marginsize{1.95cm}{1.95cm}{2.25cm}{2.25cm}
	\setlength{\topskip}{-0.7cm}
}{}
\ifthenelse{\equal{\pagesize}{1}}{   % 一行34个中文字符（自用版）
	\RequirePackage{anysize}
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 34 其他
	%\papersize{26cm}{18.5cm}
	%%%%%%%%% 16k正度（国内尺寸）：185x260，版心: 145x215mm，对应的上下边距为2.25cm，左右边距为1.95，实际上这里的上下边距是页眉页脚到页边的距离
	%\marginsize{1.95cm}{1.95cm}{1.5cm}{1.75cm}
	%%%%经测试四个值对应边为 ：左，右，上，下
	%\setlength{\topskip}{0cm} %因为 2.25-1.5=0.75

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 34 自用
	\papersize{26cm}{18.4cm}
	%%%%%%%%% 16k正度（国内尺寸）：185x260，版心: 145x215mm，对应的上下边距为2.25cm，左右边距为1.95，实际上这里的上下边距是页眉页脚到页边的距离
	\marginsize{1.95cm}{1.95cm}{1.5cm}{1.75cm}
	%%%%经测试四个值对应边为 ：左，右，上，下
	\setlength{\topskip}{0cm} %因为 2.25-1.5=0.75
}{}
\ifthenelse{\equal{\pagesize}{2}}{   % 一行36个中文字符
	\RequirePackage{anysize}
	\papersize{27cm}{19cm}
	% 左边距 1.95cm，右边距 1.95cm，上边距 1.25cm，下边距 1.25cm，版心 215×145mm
	\marginsize{1.95cm}{1.95cm}{1.25cm}{1.25cm}
	\setlength{\topskip}{-0.7cm}
}{}
\ifthenelse{\equal{\pagesize}{3}}{   % 一行37个中文字符
	\RequirePackage{anysize}
	\papersize{27cm}{19.5cm} % {19.4cm}
	% 左边距 1.95cm，右边距 1.95cm，上边距 1.25cm，下边距 1.25cm，版心 215×145mm ？？？？
	\marginsize{1.94cm}{1.94cm}{1.25cm}{1.25cm}
	\setlength{\topskip}{-0.7cm}
}{}
\ifthenelse{\equal{\pagesize}{4}}{  % 设置A4页面 % 一行38个中文字符
	%使用geometry调整边距
	\RequirePackage{geometry}
	\geometry{a4paper,papersize={21cm,29.7cm}}
	\geometry{left=2.5cm,right=2.5cm,top=2.75cm,bottom=3cm,headsep=0.32cm,footskip=1cm}
	% bottom为2.5 + 0.5cm，考虑到footer的高度，这样与word一致
	% \setlength{\topskip}{0.3cm}
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% （3）定义页眉、页脚

% 设定页眉、页脚样式。
%\fancypagestyle{plain}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}}
\fancypagestyle{plain}{\pagestyle{fancy}}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[RE]{\zihao{-5}\songti\@title}
\fancyhead[RO]{\zihao{-5}\songti\@title}
\fancyhead[LO,LE]{\zihao{-5}\songti\universityname\thesisname}
\fancyfoot[CO,CE]{\zihao{-5}\thepage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  （4）定义论文封面信息

% 这些命令用于设定各项文档信息的具体内容。
\newcommand\unitid[1]{\def\@unitid{#1}}
\newcommand\STUnumber[1]{\def\@STUnumber{#1}}
\newcommand\securityClassification[1]{\def\@securityClassification{#1}}
\newcommand\securityYear[1]{\def\@securityYear{#1}}
% 加入封面标题命令 20161124
\newcommand\CoverTitle[1]{\def\@CoverTitle{#1}}
% 加入封面副标题命令，支持封面标题的换行 2020
\newcommand\CoverSubTitle[1]{\def\@CoverSubTitle{#1}}
% 加入摘要标题命令，支持摘要标题的换行 20240405
\newcommand\AbstractTitle[1]{\def\@AbstractTitle{#1}}
\renewcommand{\title}[1]{\def\@title{#1}}
\newcommand\ENGtitle[1]{\def\@ENGtitle{#1}}
\newcommand\school[1]{\def\@school{#1}}
\newcommand\ENGschool[1]{\def\@ENGschool{#1}}
\newcommand\ENGauthor[1]{\def\@ENGauthor{#1}}
\newcommand\supervisor[1]{\def\@supervisor{#1}}
\newcommand\ENGsupervisor[1]{\def\@ENGsupervisor{#1}}
\newcommand\degreeclass[1]{\def\@degreeclass{#1}}
\newcommand\ENGdegreeclass[1]{\def\@ENGdegreeclass{#1}}
\newcommand\major[1]{\def\@major{#1}}
\newcommand\ENGmajor[1]{\def\@ENGmajor{#1}}
\newcommand\hasmajor[1]{\def\@hasmajor{#1}}
\newcommand\defensedate[1]{\def\@defensedate{#1}}
\newcommand\grantdate[1]{\def\@grantdate{#1}}
\newcommand\accomplishdate[1]{\def\@accomplishdate{#1}}
\newcommand\statementdate[1]{\def\@statementdate{#1}}
\newcommand\direction[1]{\def\@direction{#1}}
\newcommand\ENGdirection[1]{\def\@ENGdirection{#1}}
\newcommand\keywords[1]{\def\@keywords{#1}}
\newcommand\ENGkeywords[1]{\def\@ENGkeywords{#1}}
\newcommand\university[1]{\def\@university{#1}}
\newcommand\ENGuniversity[1]{\def\@ENGuniversity{#1}}

% 判断论文类别，定义不同论文名称
\ifthenelse{\equal{\thesistype}{0}}{
	\def\thesisname{博士学位论文}
	\def\CHSauthortype{研究生}
	\def\ENGauthortype{Postgraduate}
  \def\TypeAbbr{PhD Degree}
	}{}
\ifthenelse{\equal{\thesistype}{1}}{
	\def\thesisname{硕士学位论文}
	\def\CHSauthortype{研究生}
	\def\ENGauthortype{Postgraduate}
  \def\TypeAbbr{MEng Degree} % 视情况修改 MSc、MA
	}{}
\ifthenelse{\equal{\degreetype}{0}}{
	\def\proffieldname{学科专业}
	\def\degreename{学术学位}
}{}
\ifthenelse{\equal{\degreetype}{1}}{
	\def\proffieldname{领域名称}
	\def\degreename{专业学位}
}{}
\ifthenelse{\equal{\thesistype}{2}}{
	\def\thesisname{学士学位论文}
	\def\CHSauthortype{本科生}
	\def\ENGauthortype{Undergraduate}
  \def\TypeAbbr{Bachelor Degree}
}{}

%定义字体格式 (CYC) 方正小标宋 https://zhuanlan.zhihu.com/p/538459335 失败
%\setCJKfamilyfont { zhsong } {"../Template/FZXiaoBiaoSong-B05.ttf"}%{ "C:/Users/50676/AppData/Local/Microsoft/Windows/Fonts/FZXiaoBiaoSong-B05.ttf" }
\newcommand{\fzsongti}{
	\CJKfamily { zhsong  }
}
\newcommand{\fontq}{
	\zihao{-3}\heiti
}
\newcommand{\fonta}{
	\zihao{3}\songti
}
\newcommand{\makesecret}{
	\ifthenelse{\equal{\secret}{1}}{
		\\
		{\makebox[2.2cm][s]{\textbf{密级：}}}       & \hspace{-10pt}\textbf{\@securityClassification\quad\@securityYear 年}
	}{}

}

\newcommand{\makescucoverhead}
{
\ifthenelse{\equal{\approval}{0}}{
		\zihao{-4}\songti
		\begin{tabular}{cl}
			{\makebox[2.2cm][s]{\textbf{单位代码：}}}  & \hspace{-10pt}\textbf{\@unitid}\\
			{\makebox[2.2cm][s]{\textbf{学号：}}}       & \hspace{-10pt}\textbf{\@STUnumber}
			\makesecret
		\end{tabular}
	}{}
\ifthenelse{\equal{\approval}{1}}{
		\zihao{-4}\songti
		\begin{tabular}{cl}
			{\makebox[2.2cm][s]{\textbf{单位代码：}}}  & \hspace{-10pt}\textbf{\@unitid}\\
			{\makebox[2.2cm][s]{\textbf{送审编号：}}}       & \hspace{-10pt}\textbf{\@STUnumber}
			\makesecret
		\end{tabular}
		
	}{}
\ \\[28pt]
}


\newcommand{\makescucoverimage}
{
\ifthenelse{\equal{\colortitle}{0}}{
	\ \\[1.2cm]
	\includegraphics[width=10cm]{../Template/Components/Images/SCU_TITLE_BW}
	\ \\[0.8cm]%\\[0cm]
}{}
\ifthenelse{\equal{\colortitle}{1}}{
	\ \\[1.2cm]
	\includegraphics[width=10cm]{../Template/Components/Images/SCU_TITLE}
	\ \\[0.8cm]%\\[0.5cm]
}{}
{\makebox[9cm][s]{\zihao{1}\heiti\textbf{\thesisname}}}
%{\makebox[9cm][s]{\zihao{1}\fzsongti\textbf{\thesisname}}}
\\[18pt]
{\makebox[5cm][c]{\zihao{3}\songti\text{（}\degreename\text{）}}}
%\\[47pt]
\\[52pt]
}

\newcommand{\makescucovertitle}
{
%非送审版本
\ifthenelse{\equal{\approval}{0}}{
	\begin{tabular}{ll}
		{\hspace{0.1cm}\kaishu\zihao{3}\makebox[2.8cm][s]{\textbf{题\hspace{1em}目}}}  & \hspace{-3.6cm}\fillinblank{10.5cm}{\kaishu\zihao{3}\textbf{\@CoverTitle}} 
		\\[15pt]
		\ifthenelse{\equal{\@CoverSubTitle}{}}{}{
		{\hspace{0.1cm}\makebox[2.8cm][s]{}}       & \hspace{-3.6cm}\fillinblank{10.5cm}{\kaishu\zihao{3}\textbf{\@CoverSubTitle}} 
		}
		\\[17pt]
		{\hspace{0.1cm}\kaishu\zihao{3}\makebox[2.8cm][l]{作\hspace{1em}者}}       
		\hspace{-1.2cm}\fillinblank{3cm}{\kaishu\zihao{3}\textbf{\@author}} & {\hspace{-0.5cm}\kaishu\zihao{3}\makebox[2.8cm][l]{\textbf{完成日期}}}   \hspace{-0.7cm}\fillinblank{5.2cm}{\kaishu\zihao{3}\textbf{$\quad$年$\quad$月$\quad$日}}    
	\end{tabular}
	}{}
%送审版本
\ifthenelse{\equal{\approval}{1}}{
	\begin{tabular}{ll}
		{\hspace{0.1cm}\kaishu\zihao{3}\makebox[2.8cm][s]{\textbf{题\hspace{1em}目}}}  & \hspace{-3.6cm}\fillinblank{10.5cm}{\kaishu\zihao{3}\textbf{\@CoverTitle}} 
		\\[15pt]
		\ifthenelse{\equal{\@CoverSubTitle}{}}{}{
		{\hspace{0.1cm}\makebox[2.8cm][s]{}}       & \hspace{-3.6cm}\fillinblank{10.5cm}{\kaishu\zihao{3}\textbf{\@CoverSubTitle}} 
		}
		\\[17pt]
		{\hspace{0.1cm}\kaishu\zihao{3}\makebox[2.8cm][l]{作\hspace{1em}者}}       
		\hspace{-1.2cm}\fillinblank{3cm}{\kaishu\zihao{3}\textbf{***}} & {\hspace{-0.5cm}\kaishu\zihao{3}\makebox[2.8cm][l]{\textbf{完成日期}}}   \hspace{-0.7cm}\fillinblank{5.2cm}{\kaishu\zihao{3}\textbf{$\quad$年$\quad$月$\quad$日}}    
	\end{tabular}
	}{}
%\\[45pt]
\\[50pt]
}

\newcommand{\makescucovercontent}
{
%非送审版本
\ifthenelse{\equal{\approval}{0}}{
	\zihao{3}\kaishu
	\begin{tabular}{cc}
		{\vspace{0.2em}\hspace{-0.5cm}\kaishu\makebox[2.8cm][l]{培养单位}}  & \hspace{-2.2cm}\kaishu\zihao{3}\fillinblank{8.3cm}{\@school}
		\\[5pt]
		{\vspace{0.2em}\hspace{-0.5cm}\kaishu\makebox[2.8cm][l]{指导教师}}       & \hspace{-2.2cm}\kaishu\zihao{3}\fillinblank{8.3cm}{\@supervisor}
		\\[5pt]
		{\vspace{0.2em}\hspace{-0.5cm}\kaishu\zihao{3}\makebox[2.8cm][l]{专\hspace{2em}业}} & \hspace{-2.2cm}\kaishu\zihao{3}\fillinblank{8.3cm}{\@major}
		\\[5pt]
		{\vspace{0.2em}\hspace{-0.5cm}\kaishu\makebox[2.8cm][l]{研究方向}}   & \hspace{-2.2cm}\kaishu\zihao{3}\fillinblank{8.3cm}{\@direction}
		\\[5pt]
		{\vspace{0.2em}\hspace{0.9cm}\kaishu\makebox[4.2cm][l]{授予学位日期}}  & \hspace{-1cm}\kaishu\zihao{3}\fillinblank{7.2cm}{$\quad$年$\quad$月$\quad$日}
		
	\end{tabular}
	}{}
%送审版本
\ifthenelse{\equal{\approval}{1}}{
	\zihao{3}\kaishu
	\begin{tabular}{cc}
		{\vspace{0.2em}\hspace{-0.5cm}\kaishu\makebox[2.8cm][l]{培养单位}}  & \hspace{-2.2cm}\kaishu\zihao{3}\fillinblank{8.3cm}{\@school}
		\\[5pt]
		{\vspace{0.2em}\hspace{-0.5cm}\kaishu\makebox[2.8cm][l]{指导教师}}       & \hspace{-2.2cm}\kaishu\zihao{3}\fillinblank{8.3cm}{***}
		\\[5pt]
		{\vspace{0.2em}\hspace{-0.5cm}\kaishu\zihao{3}\makebox[2.8cm][l]{专\hspace{2em}业}} & \hspace{-2.2cm}\kaishu\zihao{3}\fillinblank{8.3cm}{\@major}
		\\[5pt]
		{\vspace{0.2em}\hspace{-0.5cm}\kaishu\makebox[2.8cm][l]{研究方向}}   & \hspace{-2.2cm}\kaishu\zihao{3}\fillinblank{8.3cm}{\@direction}
		\\[5pt]
		{\vspace{0.2em}\hspace{0.9cm}\kaishu\makebox[4.2cm][l]{授予学位日期}}  & \hspace{-1cm}\kaishu\zihao{3}\fillinblank{7.2cm}{$\quad$年$\quad$月$\quad$日}
		
	\end{tabular}
	}{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  % （5）设置标题格式（CYC魔改版）

% 设置标题深度为4
\setcounter{secnumdepth}{4}
% CTEX设置各级标题对齐方式，字号，字体及前后段间距
% “章节”标题，小三号黑体，左对齐，段前为18pt，段后12pt
\CTEXsetup[
	format+={\zihao{-3}\rm\heiti\flushleft},
	% 设置序号和各级标题之间为一个空格，这里范例和写作说明不一致
	aftername={\hspace{\ccwd}},
	beforeskip={-12pt},
	afterskip={12pt}
]{chapter}
% “节”标题，四号黑体，左对齐，段前12pt，段后6pt
\CTEXsetup[
	format+={\zihao{4}\rm\heiti\flushleft},
	aftername={\hspace{\ccwd}},
	beforeskip={0pt},
	afterskip={6pt}
]{section}
% “小节”标题，小四号黑体，左对齐，段前12pt，段后6pt
\CTEXsetup[
	format+={\zihao{-4}\rm\heiti\flushleft},
	aftername={\hspace{\ccwd}},
	beforeskip={6pt},
	afterskip={6pt}
]{subsection}
% “次小节”标题，小四号楷体，左对齐，段前6pt，段后6pt
\CTEXsetup[
	format+={\zihao{-4}\rm\kaishu\flushleft},
	aftername={\hspace{\ccwd}},
	beforeskip={0pt},
	afterskip={6pt}
]{subsubsection}
% “段”标题，小四号楷体，左对齐，前后段间距为0pt
\renewcommand{\theparagraph}{(\arabic{paragraph})}
\CTEXsetup[
	name={,},
	number={\theparagraph},
	format+={\zihao{-4}\rm\kaishu\flushleft},
	beforeskip={0pt},
	afterskip={0pt}
]{paragraph}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% （6）设置图表标题样式，中文版（CYC）和双语版

\ifthenelse{\equal{\captiontype}{0}}{   % 双语图表标题
	% 此包用于双语图表标题
	\RequirePackage[list=off]{bicaption}
	\RequirePackage{subcaption}
	% 设置图表标题样式，五号黑体不加粗
	\DeclareCaptionFont{tubiaozihao}{\zihao{5}\rm\heiti}
	\captionsetup{font={bf},bi-slc=0}
	\captionsetup[figure][bi-first]{name=图,labelsep=quad,labelfont={tubiaozihao},font={tubiaozihao}}
	\captionsetup[figure][bi-second]{name=Figure,labelsep=quad,labelfont={rm,small},font={rm,small}}
	\captionsetup[table][bi-first]{name=表,labelsep=quad,labelfont={tubiaozihao},font={tubiaozihao}}
	\captionsetup[table][bi-second]{name=Table,labelsep=quad,labelfont={rm,small},font={rm,small}}
	% 修改图题和正文间距，上行距8pt，下行距8pt
	%\setlength{\belowcaptionskip}{-8pt}
	%\setlength{\abovecaptionskip}{8pt}
	% 修改图题和正文间距，上行距8pt，下行距5pt
	\setlength{\belowcaptionskip}{-8pt}
	\setlength{\abovecaptionskip}{5pt}
}{}
\ifthenelse{\equal{\captiontype}{1}}{   % 中文图表标题
	%此包用于中文图表标题（cyc）
	\RequirePackage{caption}
	\RequirePackage{subcaption}
	% 设置图表标题样式，五号黑体不加粗，上行距8pt，下行距5pt
	\DeclareCaptionFont{tubiaozihao}{\zihao{5}\rm\heiti}
	\captionsetup[figure]{name=图,labelsep=quad,labelfont={tubiaozihao},font={tubiaozihao},aboveskip=8pt,belowskip=5pt}	\captionsetup[table]{name=表,labelsep=quad,labelfont={tubiaozihao},font={tubiaozihao},aboveskip=8pt,belowskip=5pt}
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% （5）设置公式、列表样式（CYC）

%定义破折号
\newcommand{\cdash}[0]{\text{\ ——\ }}
% 公式编号格式(chapter-equation)
\renewcommand{\theequation}{\arabic{chapter}-\arabic{equation}}

% 支持自定义列表环境 https://blog.csdn.net/fandroid/article/details/54644966
\RequirePackage{enumitem}
\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
\setdescription{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% （5）设置目录标题格式（章节、图表）

% 定义目录标题格式，小三号黑体居中，段前后距10pt
\renewcommand{\cfttoctitlefont}{\hfill\zihao{-3}\rm\heiti}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftbeforetoctitleskip}{10pt}
\renewcommand{\cftaftertoctitleskip}{10pt}
% 定义引导线格式，为点，点距0.5，章节标题也使用引导线
\renewcommand{\cftdot}{.}
\renewcommand{\cftdotsep}{0.5}
\renewcommand{\cftchapdotsep}{\cftdotsep}
% 定义章节目录项前后距
\setlength{\cftbeforechapskip}{0pt}

% 定义图表目录标题格式，三号黑体居中，段前后距10pt
\renewcommand\listfigurename{插图目录}
\renewcommand\listtablename{表格目录}
\renewcommand{\cftloftitlefont}{\hfill\zihao{3}\rm\heiti\bfseries}
\renewcommand{\cftlottitlefont}{\hfill\zihao{3}\rm\heiti\bfseries}
\renewcommand{\cftafterloftitle}{\hfill}
\renewcommand{\cftafterlottitle}{\hfill}
%此处魔改目录标题前间距
\renewcommand{\cftbeforeloftitleskip}{8pt}
\renewcommand{\cftbeforelottitleskip}{8pt}
\renewcommand{\cftafterloftitleskip}{10pt}
\renewcommand{\cftafterlottitleskip}{10pt}

\newcommand{\loflabel}{图.}
\newcommand{\lotlabel}{表.}
\newlength{\mylen}
\renewcommand{\cftfigpresnum}{\figurename\enspace}
\settowidth{\mylen}{\cftfigpresnum\cftfigaftersnum}
\addtolength{\cftfignumwidth}{\mylen}

\renewcommand{\cfttabpresnum}{\tablename\enspace}
\settowidth{\mylen}{\cfttabpresnum\cfttabaftersnum}
\addtolength{\cfttabnumwidth}{\mylen}
% 生成图表目录
\newcommand{\makefigtablist}{
		\cleardoublepage
		\listoffigures
		\cleardoublepage
		\listoftables
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  % 自定义手动调整格式命令

% 定义\makechaptertitlecenter命令，可使命令后章节标题居中
\newcommand{\makechaptertitlecenter}{\CTEXsetup[format+={\center}]{chapter}}
% 定义\makechaptertitleleft命令，可使命令后章节标题居左
\newcommand{\makechaptertitleleft}{\CTEXsetup[format+={\flushleft}]{chapter}}

% 定义\fillinblank命令，用下划线填充指定的空间。
\newcommand{\fillinblank}[2]{
	\CJKunderline[thickness=0.8pt,depth=0.2em]{\makebox[#1]{#2}}
}
% 定义\putonbottom命令，将对象放到页面底部。
\newcommand{\putonbottom}[1]{
	\begin{figure}[b!]%
		\begin{minipage}{\textwidth}
			{#1}
		\end{minipage}
	\end{figure}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  % 制作目录命令（CYC）

% 双页打印版启用

% 定义\maketoc命令，将自动生成符合要求的目录。
%\newcommand{\maketoc}{
%	\thispagestyle{empty}\cleardoublepage
%	\tableofcontents\pagenumbering{roman}
%	\thispagestyle{fancy}
%}

% 单页版启用（CYC）TODO: 和LoadClass选项一起设置
\newcommand{\maketoc}{
\cleardoublepage
\tableofcontents
\thispagestyle{fancy}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


	% 设定封面页格式
	\renewcommand\maketitle{
	\cleardoublepage
	\pagestyle{empty}
	\begin{titlepage}
		%\makescucoverhead
		\begin{center}
			% 校名和论文类别、“四川大学”字样
			\makescucoverimage
			
			%封面论文标题
			\makescucovertitle

			%封面主要内容
			\makescucovercontent

			\end{center}
		\end{titlepage}
		%\thispagestyle{empty}
	}
	
	% 设定英文封面格式
	\newenvironment{ENGinner}
	{

		\renewcommand{\baselinestretch}{1.5}

		\begin{center}
			\ \\[12pt]
			\zihao{3}\rm
			{\parbox[c]{15.8cm}{\centering\textbf{\@ENGtitle}}}
			\\[4cm]
			\textbf{A dissertation submitted to Sichuan University} \\
			\textbf{in partial fulfillment of the requirements} \\
			\textbf{for the degree of } \\[14pt]
			\textbf{\@ENGdegreeclass} \\
			\ifthenelse{\equal{\@hasmajor}{1}}{
				\textbf{in \@ENGmajor}}
		\ \\[29pt]
		\textbf{By} \\
		\textbf{\@ENGauthor}\\
		\textbf{Supervisor: \@ENGsupervisor}\\[3.4cm]
		{\parbox[c]{15.8cm}{\centering\textbf{\@ENGschool, Sichuan University, Chengdu, China}}}\\[0.8cm]
		\textbf{\@statementdate}
		\end{center}
		\ \vspace{0cm}\par
	}{}
	
	
	%设置致谢
	\newcommand{\makethanks}{
		\include{Chapters/Thanks}
	% \ \\
	}

	%设置声明
	\newcommand{\makestatement}{
	\ifthenelse{\equal{\approval}{0}}{
		\cleardoublepage
		\pagestyle{empty}
		\begin{ENGinner}
		\end{ENGinner}
		
		% 中文声明
		{
			\cleardoublepage
			\setlength{\baselineskip}{20pt}
			\chapter*{声\hspace{1em}明}
			\thispagestyle{empty}
			本人声明所呈交的学位论文是本人在导师指导下（或联合培养导师组合作指导下）进行的研究工作及取得的研究成果。据我所知，除了文中特别加以标注和致谢的地方外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得四川大学或其他教育机构的学位或证书而使用过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表示谢意。

			本学位论文成果是本人在四川大学读书期间在导师指导下（或联合培养导师组合作指导下）取得的，论文成果归四川大学所有（或联合培养单位共有），特此声明。
			\vspace{4cm}
			\autograph
		}
	}{}
	% \ \\
	}

	% 重定义autoref标签
	%\renewcommand{\partautorefname}{\part}
	%\renewcommand{\figureautorefname}{\figurename}
	%\renewcommand{\tableautorefname}{\tablename}
	%\renewcommand{\appendixautorefname}{\appendixname}
	%\renewcommand{\equationautorefname}{\equationname}
	%\renewcommand{\Itemautorefname}{\Itemname}

	%\newcommand{\equationname}{式}
	%\renewcommand{\equationautorefname}{\equationname}

	% 定义\specialchap命令，生成没有编号的章节。从pkuthss-1.2beta保留，本模版中未使用。
	\newcommand{\specialchap}[1]{
		\chapter*{#1}\markboth{#1}{}
		\addcontentsline{toc}{chapter}{#1}\phantomsection
	}

	% 定义\autograph命令，生成版权授权书等的签名栏。
	\newcommand{\autograph}{
		\begin{center}
			\begin{tabular*}{\textwidth}{p{0.5\textwidth}p{0.5\textwidth}}
				学位论文作者签名：& 导师签名：\\[0.5cm]
				签字日期：$\quad$年$\quad$月$\quad$日 & 签字日期：$\quad$年$\quad$月$\quad$日
			\end{tabular*}
		\end{center}
	}
	
	\newcommand{\autographak}{
		\begin{center}
			\begin{tabular*}{\textwidth}{p{0.5\textwidth}p{0.5\textwidth}}
				学位论文作者签名：& 导师签名：\\[0.5cm]
				签字日期：$\quad$年$\quad$月$\quad$日 & 签字日期：$\quad$年$\quad$月$\quad$日 \\[2cm]
				学位论文作者毕业后去向：\\[0.5cm]
				工作单位：$\quad$$\quad$$\quad$ & 电话：\\[0.25cm]
				通讯地址：$\quad$$\quad$$\quad$ & 邮编：\\
			\end{tabular*}
		\end{center}
	}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% 定义中文摘要环境
	\newenvironment{CHSabstract}
	{
		\cleardoublepage
		\ \vspace{0cm}%\par
		\begin{center}
			\zihao{3}\heiti{\@AbstractTitle} \\[1em]
			\zihao{-4}
			{\songti{\@major$\ $专业}} \\[1em]
			\ifthenelse{\equal{\approval}{0}}{
				{\heiti{{\CHSauthortype}{$\ $}}}{\kaishu{\@author}}
			}{}
			\ifthenelse{\equal{\approval}{1}}{
				{\heiti{{\CHSauthortype}{$\ $}}}{\kaishu{\;***}}
			}{}
			\quad
			\ifthenelse{\equal{\approval}{0}}{
				{\heiti{{\label@supervisor}{$\ $}}}{\kaishu{\@supervisor}}
			}{}
			\ifthenelse{\equal{\approval}{1}}{
				{\heiti{{\label@supervisor}{$\ $}}}{\kaishu{\;***}}
			}{}
		\end{center}
		\ \vspace{0cm}\par
		%\ \\[-0.5cm]
	}
	{
		\vspace{1em}\par
		\noindent\textbf{关键词：}\@keywords
		%\putonbottom{\textbf{关键词：}\@keywords}
	}
	% 定义英文摘要环境
	\newenvironment{ENGabstract}
	{
		\cleardoublepage
		\ \vspace{0cm}%\par
		\begin{center}
			\zihao{3}\bfseries{\@ENGtitle} \\[1.5em]
			\zihao{-4}
      {\rm{Presented for \TypeAbbr}} \\[0.5em]
			{\textbf{{\label@ENGmajor: }}\rm\@ENGmajor} \\[0.5em]
			\ifthenelse{\equal{\approval}{0}}{
				{\textbf{{\ENGauthortype: }}\rm\@ENGauthor}
			}{}
			\ifthenelse{\equal{\approval}{1}}{
				{\textbf{{\ENGauthortype: }}\rm\;***}
			}{}
			\quad
			\ifthenelse{\equal{\approval}{0}}{
				{\textbf{{\label@ENGsupervisor: \rm\@ENGsupervisor}}}
			}{}
			\ifthenelse{\equal{\approval}{1}}{
				{\textbf{{\label@ENGsupervisor: \rm\;***}}}
			}{}
		\end{center}
		\ \vspace{0cm}\par
		%\ \\[-0.5cm]\setlength\parindent{2em}
	}
	{
		\vspace{1em}\par
		\noindent\textbf{Keywords:} \@ENGkeywords%\putonbottom{\textbf{Keywords:} \@E	NGkeywords}
	}
	% 定义参考文献环境
	\newenvironment{reference}
	{
		\makechaptertitlecenter
		\cleardoublepage
		\zihao{5}
		\setlength{\baselineskip}{16pt}
	}
	
	% 定义附录环境
	\newenvironment{appendix*}
	{
		\begin{center}
		\zihao{5}
	}{\end{center}}
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	\newcommand{\thankchapter}[1]{
	  \chapter*{\centering #1}
	  \addcontentsline{toc}{chapter}{#1} % 如果需要添加到目录
	}
	
	
	% 定义致谢环境
	\newenvironment{thanks*}
	{	
		%\makefancyhf{致谢}
		%\chapter{致\hspace{1em}谢}
		\thankchapter{致\hspace{1em}谢}
	}

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% 加载cleveref宏，支持智能化引用
	\RequirePackage{cleveref}
	\crefformat{chapter}{第~#2#1#3~章}
  \Crefformat{chapter}{第~#2#1#3~章}
	\crefrangeformat{chapter}{第~#3#1#4~-~#5#2#6~章}
  \Crefrangeformat{chapter}{第~#3#1#4~-~#5#2#6~章}
  \crefmultiformat{chapter}{第~#2#1#3~章}{和第~#2#1#3~章}{,~第~#2#1#3~章}{和第~#2#1#3~章}
  \Crefmultiformat{chapter}{第~#2#1#3~章}{和第~#2#1#3~章}{,~第~#2#1#3~章}{和第~#2#1#3~章}
  \crefrangemultiformat{chapter}{第~#3#1#4~-~#5#2#6~章}{和第~#3#1#4~-~#5#2#6~章}{,~ 第~#3#1#4~-~#5#2#6~章}{和第~#3#1#4~-~#5#2#6~章}
  \Crefrangemultiformat{chapter}{第~#3#1#4~-~#5#2#6~章}{和第~#3#1#4~-~#5#2#6~章}{,~ 第~#3#1#4~-~#5#2#6~章}{和第~#3#1#4~-~#5#2#6~章}

	\crefformat{section}{第~#2#1#3~节}
  \Crefformat{section}{第~#2#1#3~节}
	\crefrangeformat{section}{第~#3#1#4~-~#5#2#6~节}
  \Crefrangeformat{section}{第~#3#1#4~-~#5#2#6~节}
  \crefmultiformat{section}{第~#2#1#3~节}{和第~#2#1#3~节}{,~第~#2#1#3~节}{和第~#2#1#3~节}
  \Crefmultiformat{section}{第~#2#1#3~节}{和第~#2#1#3~节}{,~第~#2#1#3~节}{和第~#2#1#3~节}
  \crefrangemultiformat{section}{第~#3#1#4~-~#5#2#6~节}{和第~#3#1#4~-~#5#2#6~节}{,~ 第~#3#1#4~-~#5#2#6~节}{和第~#3#1#4~-~#5#2#6~节}
  \Crefrangemultiformat{section}{第~#3#1#4~-~#5#2#6~节}{和第~#3#1#4~-~#5#2#6~节}{,~ 第~#3#1#4~-~#5#2#6~节}{和第~#3#1#4~-~#5#2#6~节}

	\crefformat{subsection}{第~#2#1#3~小节}
  \Crefformat{subsection}{第~#2#1#3~小节}
	\crefrangeformat{subsection}{第~#3#1#4~-~#5#2#6~小节}
  \Crefrangeformat{subsection}{第~#3#1#4~-~#5#2#6~小节}
  \crefmultiformat{subsection}{第~#2#1#3~小节}{和第~#2#1#3~小节}{,~第~#2#1#3~小节}{和第~#2#1#3~小节}
  \Crefmultiformat{subsection}{第~#2#1#3~小节}{和第~#2#1#3~小节}{,~第~#2#1#3~小节}{和第~#2#1#3~小节}
  \crefrangemultiformat{subsection}{第~#3#1#4~-~#5#2#6~小节}{和第~#3#1#4~-~#5#2#6~小节}{,~ 第~#3#1#4~-~#5#2#6~小节}{和第~#3#1#4~-~#5#2#6~小节}
  \Crefrangemultiformat{subsection}{第~#3#1#4~-~#5#2#6~小节}{和第~#3#1#4~-~#5#2#6~小节}{,~ 第~#3#1#4~-~#5#2#6~小节}{和第~#3#1#4~-~#5#2#6~小节}

	\crefformat{subsubsection}{第~#2#1#3~项}
  \Crefformat{subsubsection}{第~#2#1#3~项}
	\crefrangeformat{subsubsection}{第~#3#1#4~-~#5#2#6~项}
  \Crefrangeformat{subsubsection}{第~#3#1#4~-~#5#2#6~项}
  \crefmultiformat{subsubsection}{第~#2#1#3~项}{和第~#2#1#3~项}{,~第~#2#1#3~项}{和第~#2#1#3~项}
  \Crefmultiformat{subsubsection}{第~#2#1#3~项}{和第~#2#1#3~项}{,~第~#2#1#3~项}{和第~#2#1#3~项}
  \crefrangemultiformat{subsubsection}{第~#3#1#4~-~#5#2#6~项}{和第~#3#1#4~-~#5#2#6~项}{,~ 第~#3#1#4~-~#5#2#6~项}{和第~#3#1#4~-~#5#2#6~项}
  \Crefrangemultiformat{subsubsection}{第~#3#1#4~-~#5#2#6~项}{和第~#3#1#4~-~#5#2#6~项}{,~ 第~#3#1#4~-~#5#2#6~项}{和第~#3#1#4~-~#5#2#6~项}

	\crefname{table}{表}{表}
  \Crefname{table}{表}{表}
	\creflabelformat{table}{#2#1#3~}
	\crefrangelabelformat{table}{#3#1#4~-~#5#2#6~}
  \crefmultiformat{table}{表~#2#1#3}{和表~#2#1#3}{,~表~#2#1#3}{和表~#2#1#3}
  \Crefmultiformat{table}{表~#2#1#3}{和表~#2#1#3}{,~表~#2#1#3}{和表~#2#1#3}
  \crefrangemultiformat{table}{表~#3#1#4~-~#5#2#6}{和表~#3#1#4~-~#5#2#6}{,~表~#3#1#4~-~#5#2#6}{和表~#3#1#4~-~#5#2#6}
  \Crefrangemultiformat{table}{表~#3#1#4~-~#5#2#6}{和表~#3#1#4~-~#5#2#6}{,~表~#3#1#4~-~#5#2#6}{和表~#3#1#4~-~#5#2#6}

	\crefname{figure}{图}{图}
  \Crefname{figure}{图}{图}
	\creflabelformat{figure}{#2#1#3~}
	\crefrangelabelformat{figure}{#3#1#4~-~#5#2#6~}
  \crefmultiformat{figure}{图~#2#1#3}{和图~#2#1#3}{,~图~#2#1#3}{和图~#2#1#3}
  \Crefmultiformat{figure}{图~#2#1#3}{和图~#2#1#3}{,~图~#2#1#3}{和图~#2#1#3}
  \crefrangemultiformat{figure}{图~#3#1#4~-~#5#2#6}{和图~#3#1#4~-~#5#2#6}{,~图~#3#1#4~-~#5#2#6}{和图~#3#1#4~-~#5#2#6}
  \Crefrangemultiformat{figure}{图~#3#1#4~-~#5#2#6}{和图~#3#1#4~-~#5#2#6}{,~图~#3#1#4~-~#5#2#6}{和图~#3#1#4~-~#5#2#6}

	\crefname{equation}{式}{式}
  \Crefname{equation}{式}{式}
	\creflabelformat{equation}{(#2#1#3)~}
	\crefrangelabelformat{equation}{(#3#1#4)~-~(#5#2#6)~}
  \crefmultiformat{equation}{式~(#2#1#3)}{和式~(#2#1#3)}{,~式~(#2#1#3)}{和式~(#2#1#3)}
  \Crefmultiformat{equation}{式~(#2#1#3)}{和式~(#2#1#3)}{,~式~(#2#1#3)}{和式~(#2#1#3)}
  \crefrangemultiformat{equation}{式~(#3#1#4)~-~(#5#2#6)}{和式~(#3#1#4)~-~(#5#2#6)}{,~式~(#3#1#4)~-~(#5#2#6)}{和式~(#3#1#4)~-~(#5#2#6)}
  \Crefrangemultiformat{equation}{式~(#3#1#4)~-~(#5#2#6)}{和式~(#3#1#4)~-~(#5#2#6)}{,~式~(#3#1#4)~-~(#5#2#6)}{和式~(#3#1#4)~-~(#5#2#6)}

  \crefformat{page}{第~#2#1#3~页}
  \Crefformat{page}{第~#2#1#3~页}
  \crefrangeformat{page}{第~#3#1#4~-~#5#2#6~页}
  \Crefrangeformat{page}{第~#3#1#4~-~#5#2#6~页}
  \crefmultiformat{page}{第~#2#1#3~页}{和第~#2#1#3~页}{,~第~#2#1#3~页}{和第~#2#1#3~页}
  \Crefmultiformat{page}{第~#2#1#3~页}{和第~#2#1#3~页}{,~第~#2#1#3~页}{和第~#2#1#3~页}
  \crefrangemultiformat{page}{第~#3#1#4~-~#5#2#6~页}{和第~#3#1#4~-~#5#2#6~页}{,~ 第~#3#1#4~-~#5#2#6~页}{和第~#3#1#4~-~#5#2#6~页}
  \Crefrangemultiformat{page}{第~#3#1#4~-~#5#2#6~页}{和第~#3#1#4~-~#5#2#6~页}{,~ 第~#3#1#4~-~#5#2#6~页}{和第~#3#1#4~-~#5#2#6~页}



	\newcommand{\crefpairconjunction}{,}
	\newcommand{\crefmiddleconjunction}{,}
	\newcommand{\creflastconjunction}{,}
	\newcommand{\crefrangeconjunction}{-}
	
	% 加载配置文件
	\AtEndOfClass{\input{../Template/scuthesis.def}}
	\endinput


