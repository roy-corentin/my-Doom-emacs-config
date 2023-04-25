(setq user-full-name "Corentin Roy"
      user-mail-address "corentin.roy02@laposte.net")

;; Using garbage magic hack.
(use-package gcmh
  :config
  (gcmh-mode 1))
;; Setting garbage collection threshold
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; Silence compiler warnings as they can be pretty disruptive (setq comp-async-report-warnings-errors nil)

;; Prefer newer files
(setq load-prefer-newer noninteractive)

(use-package all-the-icons)

;; (setq fancy-splash-image "~/Pictures/Fox.png")
;; (setq fancy-splash-image "~/Pictures/Doom_Logo.png")
;; (setq fancy-splash-image "~/Pictures/cyberpunk_logo.png")
(setq fancy-splash-image "~/Pictures/blackhole-lines.svg")

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

(use-package emojify
  :hook (after-init . global-emojify-mode))

;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;; (setq doom-font (font-spec :family "JetBrainsMono NF" :size 13 :weight 'light))
;; (setq doom-font (font-spec :family "JetBrains Mono" :size 13 :weight 'light))
;; (setq doom-font (font-spec :family "Hack Nerd Font" :size 13 :weight 'medium))
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 13))

;; enable bold and italic
(after! doom-themes
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))

;; comment and keyword in Italic for example "for"
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(set-face-attribute 'font-lock-comment-face nil :foreground "#5B6268" :slant 'italic)
(set-face-attribute 'font-lock-function-name-face nil :foreground "#c678dd" :slant 'italic)
(set-face-attribute 'font-lock-variable-name-face nil :foreground "#dcaeea" :slant 'italic)

;; changes certain keywords to symbols, such as lamda!
;; (setq global-prettify-symbols-mode t)

;; (setq doom-theme 'doom-solarized-dark)
;; (setq doom-theme 'doom-monokai-machine)
;; (setq doom-theme 'doom-henna)
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-acario-dark)

(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

(setq display-line-numbers-type `relative)

(require 'company-tabnine)
(add-to-list 'company-backends #'company-tabnine)

(setq company-idle-delay 0
      company-minimum-prefix-length 1)
(setq company-tooltip-margin 3)
(setq company-require-match nil)
(setq company-format-margin-function 'company-text-icons-margin)
(setq company-text-icons-add-background t)
(custom-set-faces
 '(company-tooltip
   ((t (:background "#57666a" )))))

(with-eval-after-load 'dired
  (map! :leader
        (:prefix-map ("d" . "dired")
         :desc "Dired Jump Directory" "d" #'dired-jump))
  (define-key dired-mode-map (kbd "M-p") 'peep-dired)
  (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
  (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
  (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file))

(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; ;; With dired-open plugin, you can launch external programs for certain extensions
;; ;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(setq evil-move-beyond-eol t)
(setq evil-move-cursor-back nil)

(map! "C-M-k" #'drag-stuff-up)
(map! "C-M-j" #'drag-stuff-down)

(setq org-directory "~/org/")

(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(after! org
  (setq org-clock-sound "~/Music/ding.wav"))

;; Load org-faces to make sure we can set appropriate faces
(require 'org-faces)
;; Set reusable font name variables
(defvar my/fixed-width-font "JetBrainsMono Nerd Font"
  "The font to use for monospaced (fixed width) text.")

(defvar my/variable-width-font "Source Sans Pro"
  "The font to use for variable-pitch (document) text.")

;; NOTE: These settings might not be ideal for your machine, tweak them as needed!
;; (set-face-attribute 'default nil :font my/fixed-width-font :weight 'medium :height 90)
;; (set-face-attribute 'fixed-pitch nil :font my/fixed-width-font :weight 'medium :height 90)
(set-face-attribute 'variable-pitch nil :font my/variable-width-font :weight 'medium :height 1.1)

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.6)
                  (org-level-2 . 1.4)
                  (org-level-3 . 1.3)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font my/variable-width-font :weight 'medium :height (cdr face)))
  ;; Make the document title a bit bigger
  (set-face-attribute 'org-document-title nil :font my/variable-width-font :weight 'bold :height 1.3)

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :font my/fixed-width-font :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▼ ")
  (setq org-hide-emphasis-markers t)
  (efs/org-font-setup))

(setq org-image-actual-width nil)

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package org-fancy-priorities
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '((?A . "[‼]")
                                    (?B . "[❗]")
                                    (?C . "[☕]")
                                    (?D . "[♨]")
                                    (?1 . "[⚡]")
                                    (?2 . "[⮬]")
                                    (?3 . "[⮮]")
                                    (?4 . "[☕]")
                                    (?I . "[IMPORTANT]"))))

(after! org
    (setq org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
        '((sequence
            "TODO(t)"             ; A task that is ready to be tackled
            "IN-PROGRESS(i)"      ; A task that is in progress
            "HOLD(h)"             ; Something is holding up this task
            "|"                   ; The pipe necessary to separate "active" states and "inactive" states
            "DONE(d)"             ; Task has been completed
            "CANCELLED(c)" )      ; Task has been cancelled
          (sequence
            "🚩TODO(f)"           ; A task that is ready to be tackled
            "👷🏻IN-PROGRESS(w)"    ; A task that is in progress
            "🔒HOLD(l)"           ; Something is holding up this task
            "|"                   ; The pipe necessary to separate "active" states and "inactive" states
            "✔DONE(e)"           ; Task has been completed
            "❌CANCELLED(x)" )
          (sequence
           "[ ](T)"               ; A task that is ready tobe tackled
           "[-](I)"               ; A task that is already started
           "[?](H)"               ; A task that is holding up by a reason ?
           "|"                    ; The pipe necessary to separate "active" states and "inactive" states
           "[X](D)" ))))          ; Tash has been completed

(after! org
  (setq org-todo-keyword-faces
    '(("IN-PROGRESS" . (:foreground "#b7a1f5" :weight: bold )) ("HOLD" . org-warning)
      ("[ ]" . (:foreground "#82b66a" :weight: bold)) ("[-]" . (:foreground "#b7a1f5" :weight: bold ))
      ("[?]" . org-warning)
      ("👷🏻IN-PROGRESS" . (:foreground "#b7a1f5" :weight: bold )) ("🔒HOLD" . org-warning))))

;; Configure fill width
(setq visual-fill-column-width 110
      visual-fill-column-center-text t)

(defun my/org-present-start ()
  ;; Center the presentation and wrap lines
  (visual-fill-column-mode 1)
  (visual-line-mode 1))

(defun my/org-present-end ()
  ;; Stop centering the document
  (visual-fill-column-mode 0)
  (visual-line-mode 0))

;; Register hooks with org-present
(add-hook 'org-present-mode-hook 'my/org-present-start)
(add-hook 'org-present-mode-quit-hook 'my/org-present-end)

(after! org
    (setq org-agenda-custom-commands
        '(("c" "Simple agenda view"
            ((tags "PRIORITY=\"A\""
                    ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                    (org-agenda-overriding-header "High-priority unfinished tasks:")))
            (agenda "")
            (alltodo ""))))))

(after! org
  :ensure-t
  :custom
  (setq org-roam-directory "~/RoamNotes")
  (setq org-roam-index-file "~/RoamNotes/index.org")
  (setq org-roam-capture-templates '(("d" "default" plain "%?"
                                      :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                                                         "#+title: ${title}\n") :unnarrowed t)
                                     ("p" "problems" plain "\n* [[id:f23824a1-0515-47c6-b386-21d83a9aec21][PROBLEM]]\n%?\n* SOLVING"
                                      :target (file+head "problems/%<%Y%m%d%H%M%S>-${slug}.org"
                                                         "#+title: ${title}\n#+filetags: :Problem:\n") :unnarrowed t))))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;; :hook (after-init . org-roam-ui-mode) ;; to launch server at start
  :config
  (setq org-roam-ui-follow t
        org-roam-ui-sync-theme t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(setq org-gcal-client-id "809125859117-d4lsgmmpri4bmefhrj2n22uqn63gdf42.apps.googleusercontent.com"
      org-gcal-client-secret "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"
      org-gcal-fetch-file-alist '(("corentin33210@gmail.com" .  "~/org/schedule.org")))
(require 'org-gcal)

(require 'ivy)
(require 'counsel)

(setq ivy-re-builders-alist
      '((counsel-rg . ivy--regex-plus)
        (swiper . ivy--regex-plus)
        (swiper-isearch . ivy--regex-plus)
        (t . ivy--regex-ignore-order)))

(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(use-package treemacs
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

  ;; Set treemacs theme
  (setq doom-themes-treemacs-theme "doom-colors"))

(use-package! python-black
  :demand t
  :after python
  :config
  (add-hook! 'python-mode-hook #'python-black-on-save-mode)
  (map! :leader :desc "Blacken Buffer" "m b b" #'python-black-buffer)
  (map! :leader :desc "Blacken Region" "m b r" #'python-black-region)
  (map! :leader :desc "Blacken Statement" "m b s" #'python-black-statement)
  )

(add-to-list 'auto-mode-alist '("\\.js[x]?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts[x]?\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.astro\\'" . web-mode))

(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration '(".*\\.html\\.erb$" . "html"))
  (setq lsp-ui-sideline-show-code-actions t))

(add-hook! 'web-mode-hook
  (when (string-match-p "\\.erb\\'" buffer-file-name)
    (setq +format-with :none)))

(use-package web-mode
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  :config
  (setq web-mode-tag-auto-close-style 1))

(defun enable-rjsx-mode ()
  (when (or (string-equal "jsx" (file-name-extension buffer-file-name))
            (string-equal "tsx" (file-name-extension buffer-file-name)))
    (rjsx-minor-mode)))

(add-hook 'web-mode-hook #'enable-rjsx-mode)

(defun enable-prettier-mode ()
  (when (or (string-equal "jsx" (file-name-extension buffer-file-name))
            (string-equal "tsx" (file-name-extension buffer-file-name)))
    (prettier-rc-mode)))

(add-hook 'web-mode-hook #'enable-prettier-mode)

(after! centaur-tabs
  (setq centaur-tabs-set-bar 'right))

(map! :leader
      :desc "Toggle Centaur Tabs" "t a" #'centaur-tabs-mode)

(map! :ni "C-," #'previous-buffer)
(map! :ni "C-;" #'next-buffer)

(eval-after-load 'centaur-tabs
    (map! :ni "C-," #'centaur-tabs-backward))
(eval-after-load 'centaur-tabs
    (map! :ni "C-;" #'centaur-tabs-forward))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(crystal-mode . "crystal"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("crystalline"))
                    :activation-fn (lsp-activate-on "crystal")
                    :priority '1
                    :server-id 'crystalline)))

(load (expand-file-name "rails-settings.el" doom-user-dir))
(load (expand-file-name "crystal-settings.el" doom-user-dir))
