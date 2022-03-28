;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;;(set-face-attribute 'default nil
;; :family "JetBrains Mono"
;; :weight 'medium)

;;(setq doom-font (font-spec :family "JetBrains Mono" :size 1 :weight 'bold))
(setq doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'medium))

;; enable bold and italic
(after! doom-themes
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))

;; keyword in Italic for example "for"
(custom-set-faces!
  '(font-lock-keyword-face :slant italic))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-one)

;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(97 97))
(add-to-list 'default-frame-alist '(alpha 97 97))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "CANCELED(c)" "DONE(d)")))
(setq org-todo-keyword-faces
      '(("TODO" :foreground "#7c7c75", :weight normal :underline t)
        ("WAITING" :foreground "#9f7efe" :weight normal :underline t)
        ("INPROGRESS" :foreground "#0098dd",:weight normal :underline t)
        ("DONE" :foreground "#50#a14f" :weight normal :underline t)
        ("CANCELED" :foreground "#ff6480" :weight normal :underline t)))


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(map! :leader
      :desc "Un/Comment region"
      "/" #'comment-or-uncomment-region)

(require 'company-tabnine)
(add-to-list 'company-backends #'company-tabnine)
(setq company-idle-delay 0)
(setq company-show-quick-access t)

(setq doom-themes-treemacs-theme "doom-colors")

;; disabled move backward between different mode
(setq evil-move-beyond-eol t)
(setq evil-move-cursor-back nil)

;; powerline enable
;; (require 'powerline-evil)
;; (powerline-evil-vim-theme)

;; filter to treemacs
(after! treemacs
  (defvar treemacs-file-ignore-extensions '()
    "File extension which `treemacs-ignore-filter' will ensure are ignored")
  (defvar treemacs-file-ignore-globs '()
    "Globs which will are transformed to `treemacs-file-ignore-regexps' which `treemacs-ignore-filter' will ensure are ignored")
  (defvar treemacs-file-ignore-regexps '()
    "RegExps to be tested to ignore files, generated from `treeemacs-file-ignore-globs'")
  (defun treemacs-file-ignore-generate-regexps ()
    "Generate `treemacs-file-ignore-regexps' from `treemacs-file-ignore-globs'"
    (setq treemacs-file-ignore-regexps (mapcar 'dired-glob-regexp treemacs-file-ignore-globs)))
  (if (equal treemacs-file-ignore-globs '()) nil (treemacs-file-ignore-generate-regexps))
  (defun treemacs-ignore-filter (file full-path)
    "Ignore files specified by `treemacs-file-ignore-extensions', and `treemacs-file-ignore-regexps'"
    (or (member (file-name-extension file) treemacs-file-ignore-extensions)
        (let ((ignore-file nil))
          (dolist (regexp treemacs-file-ignore-regexps ignore-file)
            (setq ignore-file (or ignore-file (if (string-match-p regexp full-path) t nil)))))))
  (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-filter))

(setq treemacs-file-ignore-extensions
      '(;; C/C++
        "o"
        "gcna"
        "gcdo"
        ;; other
        "vscode"
        "idea"
        ))

;; calc default value
(setq calc-angle-mode 'rad  ; radians are rad
      calc-symbolic-mode t) ; keeps expressions like \sqrt{2} irrational for as long as possible

;; use LaTeX
;; (package! calctex :recipe (:host github :repo "johnbcoughlin/calctex"
;;                            :files ("*.el" "calctex/*.el" "calctex-contrib/*.el" "org-calctex/*.el" "vendor"))
;;   :pin "67a2e76847a9ea9eff1f8e4eb37607f84b380ebb")


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
