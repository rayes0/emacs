;; -*- eval: (flycheck-mode -1) -*-

(require 'org)

(with-eval-after-load 'ox-latex
  (setq org-latex-compiler "xelatex")
  (add-to-list 'org-latex-classes
    '("tufte-book"
       "\\documentclass{tufte-book}
\\usepackage{ifluatex, ifxetex}
%Next block avoids bug, from  http://tex.stackexchange.com/a/200725/1913 
\\ifx\\ifxetex\\ifluatex\\else % if lua- or xelatex http://tex.stackexchange.com/a/140164/1913
  \\newcommand{\\textls}[2][5]{%
    \\begingroup\\addfontfeatures{LetterSpace=#1}#2\\endgroup
  }
  \\renewcommand{\\allcapsspacing}[1]{\\textls[15]{#1}}
  \\renewcommand{\\smallcapsspacing}[1]{\\textls[10]{#1}}
  \\renewcommand{\\allcaps}[1]{\\textls[15]{\\MakeTextUppercase{#1}}}
  \\renewcommand{\\smallcaps}[1]{\\smallcapsspacing{\\scshape\\MakeTextLowercase{#1}}}
  \\renewcommand{\\textsc}[1]{\\smallcapsspacing{\\textsmallcaps{#1}}}
\\fi "
       ("\\section{%s}" . "\\section*{%s}")
       ("\\subsection{%s}" . "\\subsection*{%s}")
       ("\\paragraph{%s}" . "\\paragraph*{%s}")
       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-classes
    '("tufte-handout"
       "\\documentclass{tufte-handout}
\\usepackage{ifluatex, ifxetex}
%Next block avoids bug, from  http://tex.stackexchange.com/a/200725/1913 
\\ifx\\ifxetex\\ifluatex\\else % if lua- or xelatex http://tex.stackexchange.com/a/140164/1913
  \\newcommand{\\textls}[2][5]{%
    \\begingroup\\addfontfeatures{LetterSpace=#1}#2\\endgroup
  }
  \\renewcommand{\\allcapsspacing}[1]{\\textls[15]{#1}}
  \\renewcommand{\\smallcapsspacing}[1]{\\textls[10]{#1}}
  \\renewcommand{\\allcaps}[1]{\\textls[15]{\\MakeTextUppercase{#1}}}
  \\renewcommand{\\smallcaps}[1]{\\smallcapsspacing{\\scshape\\MakeTextLowercase{#1}}}
  \\renewcommand{\\textsc}[1]{\\smallcapsspacing{\\textsmallcaps{#1}}}
\\fi "
       ("\\section{%s}" . "\\section*{%s}")
       ("\\subsection{%s}" . "\\subsection*{%s}")
       ("\\paragraph{%s}" . "\\paragraph*{%s}")
       ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))