(setq! user-full-name "Corentin Roy"
       user-mail-address "corentin.roy02@laposte.net")

;; Using garbage magic hack.
(use-package! gcmh
  :defer t
  :config
  (gcmh-mode 1))

;; Profile emacs startup
(add-hook! 'emacs-startup-hook
  (lambda ()
    (message "*** Emacs loaded in %s with %d garbage collections."
             (format "%.2f seconds"
                     (float-time
                      (time-subtract after-init-time before-init-time)))
             gcs-done)))

(setq! load-prefer-newer noninteractive)

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

(setq! doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 14 :weight 'medium)
       doom-big-font (font-spec :family "JetBrains Mono Nerd Font" :size 24 :weight 'medium)
       doom-variable-pitch-font (font-spec :family "C059" :size 15 :weight 'regular))
       ;; doom-variable-pitch-font (font-spec :family "DejaVu Serif" :size 14 :weight 'medium))

(setq! doom-font-increment 1)

(use-package! doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comment-face nil :slant 'italic)
;;   '(font-lock-function-name-face nil :slant 'italic)
  '(font-lock-variable-name-face nil :slant 'italic))

;; (setq! doom-theme 'ewal-doom-one)
(setq! doom-theme 'doom-moonlight)

(setq! display-line-numbers-type `visual)

(use-package! corfu
  :custom
  (corfu-preselect 'first)
  :bind (:map corfu-map
              ("M-TAB" . corfu-complete)
              ("M-<tab>" . corfu-complete)))

(load! "corfu-icons")
(setq! nerd-icons-corfu-mapping my-corfu-icons)

(with-eval-after-load 'dired
  (map! :leader
        (:prefix-map ("d" . "dired")
         :desc "Dired Jump Directory" "d" #'dired-jump))
  (define-key dired-mode-map (kbd "M-p") 'peep-dired)
  (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
  (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
  (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file))

(add-hook! 'peep-dired-hook 'evil-normalize-keymaps)
;; ;; With dired-open plugin, you can launch external programs for certain extensions
;; ;; For example, I set all mp4 files to open in 'mpv'
(setq! dired-open-extensions '(("mkv" . "mpv")
                               ("mp4" . "mpv")))

(setq! evil-move-beyond-eol t
       evil-move-cursor-back nil)

(setq! evil-kill-on-visual-paste nil)

(map! "C-M-k" #'drag-stuff-up)
(map! "C-M-j" #'drag-stuff-down)

(setq! olivetti-body-width 120)

(map! :leader
      :desc "Toggle Olivetti Mode" "t o" #'olivetti-mode)

(add-hook! 'magit-mode-hook (olivetti-mode 1))

(add-hook! 'text-mode-hook (olivetti-mode 1))

(evil-define-command +evil-buffer-org-new (count file)
  "Creates a new ORG buffer replacing the current window, optionally
   editing a certain FILE"
  :repeat nil
  (interactive "P<f>")
  (if file
      (evil-edit file)
    (let ((buffer (generate-new-buffer "*new org*")))
      (set-window-buffer nil buffer)
      (with-current-buffer buffer
        (org-mode)
        (setq-local doom-real-buffer-p t)))))

(map! :leader
      (:prefix "b"
       :desc "New empty Org buffer" "o" #'+evil-buffer-org-new))

(setq! org-directory "~/Dropbox/Org/")

(after! org
  (setq org-clock-sound "~/Music/ding.wav"))

(require 'org-faces)

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (mixed-pitch-mode 1)
  ;; (visual-fill-column-mode) ;; restrict lines size
  (olivetti-mode 1) ;; To center buffer as word text
  (visual-line-mode 1)) ;; Use visual line mode

(defun efs/org-font-setup ()
  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.6)
                  (org-level-2 . 1.4)
                  (org-level-3 . 1.2)
                  (org-level-4 . 1.2)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font doom-variable-pitch-font :weight 'medium :height (cdr face)))

  ;; Make the document title bigger
  (set-face-attribute 'org-document-title nil :font doom-variable-pitch-font :weight 'bold :height 2.1)

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground 'unspecified :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil :font doom-font :inherit 'fixed-pitch)
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries of a TODO are done, to TODO otherwise."
  (when (member (org-get-todo-state) org-todo-keywords-1)
    (let (org-log-done org-todo-log-states)   ; turn off logging
      (org-todo (if (= n-not-done 0) "DONE" "TODO")))))

(use-package! org
  :defer t
  :hook (org-mode . efs/org-mode-setup) (org-mode . efs/org-font-setup)
  :config
  (setq org-ellipsis " ▼ "
        org-log-done 'time
        org-default-priority 67
        org-hide-emphasis-markers t
        org-hierarchical-todo-statistics nil
        org-image-actual-width nil) ;; Use the actual image's size in org files
  (add-hook 'org-after-todo-statistics-hook #'org-summary-todo))

(defface my-org-emphasis-bold
  '((default :inherit bold)
    (((class color) (min-colors 88) (background light))
     :foreground "#a60000")
    (((class color) (min-colors 88) (background dark))
     :foreground "#ff8059"))
  "My bold emphasis for Org.")

(after! org
  (setq org-emphasis-alist
        '(("*" my-org-emphasis-bold)
          ("/" italic)
          ("_" underline)
          ("=" org-verbatim verbatim)
          ("~" org-code verbatim)
          ("+" (:strike-through t)))))

(use-package! org-bullets
  :defer t
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(after! org
  (setq org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
        '((sequence
           "TODO(t)"             ; A task that is ready to be tackled
           "IN-PROGRESS(i)"      ; A task that is in progress
           "HOLD(h)"             ; Something is holding up this task
           "|"                   ; The pipe necessary to separate "active" states and "inactive" states
           "DONE(d)"             ; Task has been completed
           "CANCELED(c)" )      ; Task has been canceled
          (sequence
           "🚩TODO(f)"           ; A task that is ready to be tackled
           "👷🏻IN-PROGRESS(w)"    ; A task that is in progress
           "🔒HOLD(l)"           ; Something is holding up this task
           "|"                   ; The pipe necessary to separate "active" states and "inactive" states
           "✔DONE(e)"           ; Task has been completed
           "❌CANCELED(x)" )
          (sequence
           "[ ](T)"               ; A task that is ready tobe tackled
           "[-](I)"               ; A task that is already started
           "[?](H)"               ; A task that is holding up by a reason ?
           "|"                    ; The pipe necessary to separate "active" states and "inactive" states
           "[X](D)" ))))          ; Tash has been completed

(after! org
  (setq org-todo-keyword-faces
        '(("IN-PROGRESS" . (:foreground "#b7a1f5" :weight bold )) ("HOLD" . org-warning)
          ("[ ]" . (:foreground "#82b66a" :weight bold)) ("[-]" . (:foreground "#b7a1f5" :weight bold ))
          ("[?]" . org-warning)
          ("👷🏻IN-PROGRESS" . (:foreground "#b7a1f5" :weight bold )) ("🔒HOLD" . org-warning))))

(use-package! svg-tag-mode
  :defer t
  :after org
  :hook (org-mode . svg-tag-mode)
  :config
  (plist-put svg-lib-style-default :height 1.2)
  (plist-put svg-lib-style-default :padding 2)
  (plist-put svg-lib-style-default :font-size 10)
  (plist-put svg-lib-style-default :scale 2)
  (setq svg-tag-tags
        '(
          ;; Org tags
          ("\\(:[A-Z_]+:\\)" . ((lambda (tag)
                                  (svg-tag-make tag :beg 1 :end -1 :margin 1.5))))
          ("\\(:[A-Z]+:\\)$" . ((lambda (tag)
                                  (svg-tag-make tag :beg 1 :end -1 :margin 1.5))))
          ;; Task priority
          ("\\[#[A]\\]" . ((lambda (tag)
                               (svg-tag-make tag :face 'error
                                             :beg 2 :end -1 :margin 0))))
          ("\\[#[B]\\]" . ((lambda (tag)
                               (svg-tag-make tag :face 'warning
                                             :beg 2 :end -1 :margin 0))))
          ("\\[#[C]\\]" . ((lambda (tag)
                               (svg-tag-make tag :face 'success
                                             :beg 2 :end -1 :margin 0))))
          ;; TODOS/DONES
          ("\\(TODO\\)" . ((lambda (tag)
                             (svg-tag-make tag :inverse t :face 'org-todo))))
          ("\\(DONE\\)" . ((lambda (tag)
                             (svg-tag-make tag :inverse t :face 'org-done))))
          ("\\(IN-PROGRESS\\)" . ((lambda (tag)
                                    (svg-tag-make tag :inverse t :face '+org-todo-active))))
          ("\\(HOLD\\)" . ((lambda (tag)
                             (svg-tag-make tag :inverse t :face '+org-todo-onhold))))
          ("\\(CANCELED\\)" . ((lambda (tag)
                                 (svg-tag-make tag :inverse t :face '+org-todo-cancel))))
          ;; Log Date
          ("\\(\\[[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\s[A-Za-z]\\{3\\}\.\s[0-9]\\{2\\}:[0-9]\\{2\\}\\]\\)"
           . ((lambda (tag)
                (svg-tag-make tag :beg 0 :end -1 :face 'org-date))))
          )))

(add-hook 'org-mode-hook (lambda ()
                           "Beautify Org Checkbox Symbol"
                           (push '("[ ]" .  "☐") prettify-symbols-alist)
                           (push '("[X]" . "☑" ) prettify-symbols-alist)
                           (push '("[-]" . "❍" ) prettify-symbols-alist)
                           (push '("#+BEGIN_SRC" . "↦" ) prettify-symbols-alist)
                           (push '("#+END_SRC" . "⇤" ) prettify-symbols-alist)
                           (push '("#+begin_src" . "↦" ) prettify-symbols-alist)
                           (push '("#+end_src" . "⇤" ) prettify-symbols-alist)
                           (push '("#+BEGIN_EXAMPLE" . "↦" ) prettify-symbols-alist)
                           (push '("#+END_EXAMPLE" . "⇤" ) prettify-symbols-alist)
                           (push '("#+begin_example" . "↦" ) prettify-symbols-alist)
                           (push '("#+end_example" . "⇤" ) prettify-symbols-alist)
                           (push '("#+BEGIN_QUOTE" . "↦" ) prettify-symbols-alist)
                           (push '("#+END_QUOTE" . "⇤" ) prettify-symbols-alist)
                           (push '("#+begin_quote" . "󱆧" ) prettify-symbols-alist)
                           (push '("#+end_quote" . "󱆨⇤" ) prettify-symbols-alist)
                           (push '("#+TITLE:" . "") prettify-symbols-alist)
                           (push '("#+title:" . "") prettify-symbols-alist)
                           (push '("#+DESCRIPTION:" . "󰦨") prettify-symbols-alist)
                           (push '("#+ID:" . "") prettify-symbols-alist)
                           (push '("#+FILETAGS:" . "") prettify-symbols-alist)
                           (push '("#+filetags:" . "") prettify-symbols-alist)
                           (push '("#+STARTUP:" . "󰈈") prettify-symbols-alist)
                           (push '("#+startup:" . "󰈈") prettify-symbols-alist)
                           (push '("#+ACTIVE:" . "") prettify-symbols-alist)
                           (push '("#+START_SPOILER" . "") prettify-symbols-alist)
                           (push '("#+CLOSE_SPOILER" . "") prettify-symbols-alist)
                           (push '("#+BEGIN_HIDDEN" . "󰘓") prettify-symbols-alist)
                           (push '("#+END_HIDDEN" . "󰘓") prettify-symbols-alist)
                           (push '("#+author" . "") prettify-symbols-alist)
                           (push '("#+AUTHOR" . "") prettify-symbols-alist)
                           (push '("#+property:" . "") prettify-symbols-alist)
                           (push '("#+PROPERTY:" . "") prettify-symbols-alist)
                           (prettify-symbols-mode)))

(after! org
  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-custom-commands
        '(("c" "Simple agenda view"
           ((tags-todo "+PRIORITY=\"A\""
                       ((org-agenda-overriding-header "High-priority unfinished tasks:")))
            (tags-todo "+PRIORITY=\"B\""
                       ((org-agenda-overriding-header "Priority unfinished tasks:")))
            (agenda "" ((org-agenda-prefix-format "%-15T\t%s [ ] ")
                        (org-agenda-todo-keyword-format "")
                        (org-agenda-start-on-weekday nil)
                        (org-deadline-warning-days 60)
                        (org-agenda-start-day "0d")
                        (org-agenda-start-with-log-mode nil)
                        (org-agenda-skip-scheduled-if-deadline-is-shown t)
                        (org-agenda-log-mode-items '(state))
                        (org-agenda-overriding-header "Week Todo")))
            (agenda "" ((org-agenda-prefix-format "%-15:T\t%?-12t [X] ")
                        (org-agenda-todo-keyword-format "")
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'scheduled 'deadline))
                        (org-agenda-start-on-weekday nil)
                        (org-agenda-archives-mode t)
                        (org-agenda-start-day "0d")
                        (org-agenda-span 1)
                        (org-agenda-start-with-log-mode 'only)
                        (org-agenda-log-mode-items '(closed clock state))
                        (org-agenda-overriding-header "Today")))
            (agenda "" ((org-agenda-prefix-format "%-15T\t%s [ ] ")
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'scheduled 'deadline))
                        (org-agenda-log-mode-items '(closed state))
                        (org-agenda-archives-mode t)
                        (org-agenda-start-day "-7d")
                        (org-agenda-start-with-log-mode nil)
                        (org-agenda-overriding-header "Week Done")))
            (alltodo "")))
          ("d" "Done of the month"
           ((agenda "" ((org-agenda-prefix-format "%-15:T\t%t [X] ")
                        (org-agenda-todo-keyword-format "")
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'scheduled 'deadline))
                        (org-agenda-start-with-log-mode 'only)
                        (org-agenda-log-mode-items '(closed clock state))
                        (org-agenda-time-grid nil)
                        (org-agenda-span 31)
                        (org-agenda-start-day "-30d")
                        (org-agenda-archives-mode t)
                        (org-agenda-start-on-weekday nil))))))))

(after! org
  (defvar holiday-french-holidays nil
    "French holidays")

  (setq holiday-french-holidays
        `((holiday-fixed 1 1 "Jour de l'an")
          (holiday-fixed 1 6 "Épiphanie")
          (holiday-fixed 2 2 "Chandeleur")
          (holiday-fixed 2 14 "Saint Valentin")
          (holiday-fixed 5 1 "Fête du travail")
          (holiday-fixed 5 8 "Commémoration de la capitulation de l'Allemagne en 1945")
          (holiday-fixed 6 21 "Fête de la musique")
          (holiday-fixed 7 14 "Fête nationale - Prise de la Bastille")
          (holiday-fixed 8 15 "Assomption (Religieux)")
          (holiday-fixed 11 11 "Armistice de 1918")
          (holiday-fixed 11 1 "Toussaint")
          (holiday-fixed 11 2 "Commémoration des fidèles défunts")
          (holiday-fixed 12 25 "Noël")
          ;; fetes a date variable
          (holiday-easter-etc 0 "Pâques")
          (holiday-easter-etc 1 "Lundi de Pâques")
          (holiday-easter-etc 39 "Ascension")
          (holiday-easter-etc 49 "Pentecôte")
          (holiday-easter-etc -47 "Mardi gras")
          (holiday-float 5 0 4 "Fête des mères")
          ;; dernier dimanche de mai ou premier dimanche de juin si c'est le
          ;; même jour que la pentecôte
          (holiday-float 6 0 3 "Fête des pères"))) ;; troisième dimanche de juin

  (setq calendar-holidays holiday-french-holidays))

(defun org-agenda-auto-refresh-agenda-buffer ()
  "If we're in an agenda file, and there is an agenda buffer, refresh it."
  (when (org-agenda-file-p)
    (when-let ((buffer (get-buffer org-agenda-buffer-name)))
      (with-current-buffer buffer
        (org-agenda-redo-all)))))


(after! org
  (add-hook 'after-revert-hook #'org-agenda-auto-refresh-agenda-buffer))

(use-package! org-roam
  :custom
  (org-roam-directory "~/Dropbox/RoamNotes")
  (org-roam-index-file "~/Dropbox/RoamNotes/index.org")
  (org-roam-capture-templates
   `(("d" " Default" plain
      "%?"
      :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)
     ("p" " Problems" plain
      "* [[id:f23824a1-0515-47c6-b386-21d83a9aec21][PROBLEM]]\n%?\n* SOLVING"
      :target (file+head "problems/content/%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n#+filetags: :PROBLEM:\n")
      :unnarrowed t)
     ("a", "󰙅 DataStructure" plain
      "A =${title}= [[id:92421051-83c3-4117-9c25-7f4f9ecf2c0a][Data Structure]] is %?"
      :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n#+filetags: :DATASTRUCTURE:\n")
      :unnarrowed t))))

(use-package! websocket
  :defer t
  :after org-roam)

(use-package! org-roam-ui
  :defer t
  :after org-roam ;; or :after org
  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil))

(use-package! orgnote
  :defer t
  :hook (org-mode . orgnote-sync-mode))

(use-package! org-ai
  :commands (org-ai-mode
             org-ai-global-mode)
  :init
  (add-hook 'org-mode-hook #'org-ai-mode) ; enable org-ai in org-mode
  (org-ai-global-mode) ; installs global keybindings on C-c M-a
  :config
  (setq org-ai-default-chat-model "gpt-3.5-turbo") ; if you are on the gpt-4 beta:
  (org-ai-install-yasnippets)) ; if you are using yasnippet and want `ai` snippets

(setq! which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
   ))

(setq! scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq! mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq! mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq! mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(use-package! treemacs
  :defer t
  :config
  ;; Add ignored files and file extensions
  (setq treemacs-file-ignore-extensions '("o" "gcna" "gcdo" "vscode" "idea")
        treemacs-file-ignore-globs nil)
  (defun my-treemacs-ignore-filter (file full-path)
    "Ignore files specified by `treemacs-file-ignore-extensions' and globs."
    (or (member (file-name-extension file) treemacs-file-ignore-extensions)
        (cl-loop for glob in treemacs-file-ignore-globs
                 thereis (file-name-match-glob glob full-path))))
  (add-to-list 'treemacs-ignored-file-predicates #'my-treemacs-ignore-filter)

  ;; Enable follow mode
  (treemacs-follow-mode t)
  (lsp-treemacs-sync-mode t)

  ;; Set treemacs theme
  (setq doom-themes-treemacs-theme "doom-colors"))

(setq! treesit-language-source-alist
  '((bash "https://github.com/tree-sitter/tree-sitter-bash")
    (c "https://github.com/tree-sitter/tree-sitter-c")
    (cmake "https://github.com/uyha/tree-sitter-cmake")
    (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
    (css "https://github.com/tree-sitter/tree-sitter-css")
    (elisp "https://github.com/Wilfred/tree-sitter-elisp")
    (elixir "https://github.com/elixir-lang/tree-sitter-elixir")
    (go "https://github.com/tree-sitter/tree-sitter-go")
    (go-mod "https://github.com/camdencheek/tree-sitter-go-mod")
    (heex "https://github.com/phoenixframework/tree-sitter-heex")
    (html "https://github.com/tree-sitter/tree-sitter-html")
    (js . ("https://github.com/tree-sitter/tree-sitter-javascript" "master" "src"))
    (json "https://github.com/tree-sitter/tree-sitter-json")
    (make "https://github.com/alemuller/tree-sitter-make")
    (markdown "https://github.com/ikatyang/tree-sitter-markdown")
    (python "https://github.com/tree-sitter/tree-sitter-python")
    (rust "https://github.com/tree-sitter/tree-sitter-rust")
    (ruby "https://github.com/tree-sitter/tree-sitter-ruby")
    (toml "https://github.com/tree-sitter/tree-sitter-toml")
    (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
    (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
    (yaml "https://github.com/ikatyang/tree-sitter-yaml")
    (latex "https://github.com/latex-lsp/tree-sitter-latex")))

(use-package! treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

(add-hook 'bash-ts-mode-hook #'lsp)
(add-hook 'c-ts-mode-hook #'lsp)
(add-hook 'cmake-ts-mode-hook #'lsp)
(add-hook 'c++-ts-mode-hook #'lsp)
(add-hook 'css-ts-mode-hook #'lsp)
(add-hook 'elisp-ts-mode-hook #'lsp)
(add-hook 'elixir-ts-mode-hook #'lsp)
(add-hook 'go-ts-mode-hook #'lsp)
(add-hook 'go-mod-ts-mode-hook #'lsp)
(add-hook 'html-ts-mode-hook #'lsp)
(add-hook 'javascript-ts-mode-hook #'lsp)
(add-hook 'json-ts-mode-hook #'lsp)
(add-hook 'make-ts-mode-hook #'lsp)
(add-hook 'markdown-ts-mode-hook #'lsp)
(add-hook 'python-ts-mode-hook #'lsp)
(add-hook 'rust-ts-mode-hook #'lsp)
(add-hook 'ruby-ts-mode-hook #'lsp)
(add-hook 'toml-ts-mode-hook #'lsp)
(add-hook 'tsx-ts-mode-hook #'lsp)
(add-hook 'typescript-ts-mode-hook #'lsp)
(add-hook 'yaml-ts-mode-hook #'lsp)
(add-hook 'yaml-ts-mode-hook #'lsp)
(add-hook 'latex-ts-mode-hook #'lsp)

(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration '(".*\\.html\\.erb$" . "html"))
  (setq lsp-ui-sideline-show-code-actions t))

(add-hook! 'web-mode-hook
  (when (string-match-p "\\.erb\\'" buffer-file-name)
    (setq! +format-with :none)))

(use-package! web-mode
  :defer t
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-auto-close-style 2)
  (setq web-mode-enable-auto-closing 2))

(map! :ni "C-," #'previous-buffer)
(map! :ni "C-;" #'next-buffer)

(use-package! lsp-mode
  :init
  (add-to-list 'exec-path "~/Applications/elixir-ls")
  :config
  (setq lsp-log-io nil
        lsp-idle-delay 0.5
        read-process-output-max (* 1024 1024)
        lsp-disabled-clients '(rubocop-ls)))

(after! lsp-mode
  (defun lsp-booster--advice-json-parse (old-fn &rest args)
    "Try to parse bytecode instead of json."
    (or
     (when (equal (following-char) ?#)
       (let ((bytecode (read (current-buffer))))
         (when (byte-code-function-p bytecode)
           (funcall bytecode))))
     (apply old-fn args)))
  (advice-add (if (progn (require 'json)
                         (fboundp 'json-parse-buffer))
                  'json-parse-buffer
                'json-read)
              :around
              #'lsp-booster--advice-json-parse)

  (defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
    "Prepend emacs-lsp-booster command to lsp CMD."
    (let ((orig-result (funcall old-fn cmd test?)))
      (if (and (not test?)                             ;; for check lsp-server-present?
               (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
               lsp-use-plists
               (not (functionp 'json-rpc-connection))  ;; native json-rpc
               (executable-find "emacs-lsp-booster"))
          (progn
            (message "Using emacs-lsp-booster for %s!" orig-result)
            (cons "emacs-lsp-booster" orig-result))
        orig-result)))
  (advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command))

(setq! projectile-create-missing-test-files t)

(setq! xeft-directory "~/Dropbox/RoamNotes")

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("C-TAB" . 'copilot-accept-completion)
              ("C-<tab>" . 'copilot-accept-completion)
              ("C-s-TAB" . 'copilot-accept-completion-by-word)
              ("C-s-<tab>" . 'copilot-accept-completion-by-word)))

(use-package elixir-ts-mode)

(use-package! blamer
  :bind (("s-i" . blamer-show-posframe-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 80
                    :italic t)))
  :config
  (global-blamer-mode 0))

(map! :leader
      :desc "Toggle blamer mode" "g i" #'global-blamer-mode)

(use-package arduino-cli-mode
  :hook arduino-mode
  :mode "\\.ino\\'"
  :custom
  (arduino-cli-warnings 'all)
  (arduino-cli-verify t))

(use-package atomic-chrome
  :demand t
  :commands (atomic-chrome-start-server)
  :config
  (setq-default atomic-chrome-extension-type-list '(atomic-chrome))
  (atomic-chrome-start-server))

(load! (expand-file-name "rails-settings.el" doom-user-dir))
(load! (expand-file-name "perso.el" doom-user-dir))
