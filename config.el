(setq! user-full-name "Corentin Roy"
       user-mail-address "corentin.roy02@laposte.net")

;; Using garbage magic hack.
(use-package! gcmh
  :defer t
  :config
  (gcmh-mode 1))

;; Setting garbage collection threshold
(setq! gc-cons-threshold 100000000
       gc-cons-percentage 0.6)

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))
;; Silence compiler warnings as they can be pretty disruptive (setq!comp-async-report-warnings-errors nil)

(setq! load-prefer-newer noninteractive)

;; (setq! fancy-splash-image "~/Pictures/blackhole-lines.svg")

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

(use-package! emojify
  :defer t
  :hook (after-init . global-emojify-mode))

;;(setq!doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;; (setq!doom-font (font-spec :family "JetBrainsMono NF" :size 13 :weight 'light))
;; (setq!doom-font (font-spec :family "JetBrains Mono" :size 13 :weight 'light))
;; (setq!doom-font (font-spec :family "Hack Nerd Font" :size 13 :weight 'medium))

(setq! doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 13 :weight 'medium)
       doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 24 :weight 'medium)
       doom-variable-pitch-font (font-spec :family "DejaVu Serif" :size 14 :weight 'medium))

(setq! doom-font-increment 1)

;; (setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 13)
;;       doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 24)
;;       doom-variable-pitch-font (font-spec :family "Overpass" :size 26)
;;       doom-unicode-font (font-spec :family "JuliaMono")
;;       doom-emoji-font (font-spec :family "Twitter Color Emoji") ; Just used by me
;;       doom-serif-font (font-spec :family "IBM Plex Mono" :size 22 :weight 'light))

(defvar required-fonts '("JetBrainsMono.*" "Overpass" "JuliaMono" "IBM Plex Mono"
                         "Merriweather" "Alegreya" "Twitter Color Emoji"))

(defvar available-fonts
  (delete-dups (or (font-family-list)
                   (split-string (shell-command-to-string "fc-list : family")
                                 "[,\n]"))))

(defvar missing-fonts
  (delq nil (mapcar
             (lambda (font)
               (unless (delq nil (mapcar (lambda (f)
                                           (string-match-p (format "^%s$" font) f))
                                         available-fonts))
                 font))
             required-fonts)))

(if missing-fonts
    (pp-to-string
     `(unless noninteractive
        (add-hook! 'doom-init-ui-hook
          (run-at-time nil nil
                       (lambda ()
                         (message "%s missing the following fonts: %s"
                                  (propertize "Warning!" 'face '(bold warning))
                                  (mapconcat (lambda (font)
                                               (propertize font 'face 'font-lock-variable-name-face))
                                             ',missing-fonts
                                             ", "))
                         (sleep-for 0.5))))))
  ";; No missing fonts detected")

(after! doom-themes
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comment-face nil :slant 'italic)
  '(font-lock-function-name-face nil :slant 'italic)
  '(font-lock-variable-name-face nil :slant 'italic))

;; (setq global-prettify-symbols-mode t)

;; (setq! doom-theme 'doom-monokai-machine)
;; (setq! doom-theme 'doom-henna)
(setq! doom-theme 'doom-one)
;; (setq! doom-theme 'doom-acario-dark)
;; (setq! doom-theme 'doom-dracula)
;; (setq! doom-theme 'doom-nord-aurora)

(set-frame-parameter (selected-frame) 'alpha '(97 97))
(add-to-list 'default-frame-alist '(alpha 97 97))

(setq! tab-width 2)

(setq! display-line-numbers-type `visual)

(after! company
  (setq company-idle-delay 0.2
         company-minimum-prefix-length 2)
  (setq company-tooltip-margin 1)
  (setq company-format-margin-function 'company-text-icons-margin)
  (setq company-text-icons-add-background t)
  (setq company-text-face-extra-attributes '(:weight bold))
  (add-hook 'evil-normal-state-entry-hook #'company-abort))

(defvar companyBackground (face-attribute 'default :background) "background color for company faces")
(defvar companyFontColor (face-attribute 'default :foreground) "font color for company")
(defvar companySelectedBackground (face-attribute 'tool-bar :background) "background color for seletec item in company faces")

(custom-set-faces
 ;; '(company-tooltip ((t ((:background companyBackground) (:foreground companyFontColor)))))
 ;; '(company-scrollbar-bg ((t (:background "gray10"))))
 ;; '(company-scrollbar-fg ((t (:background "white"))))
 ;; '(company-tooltip-selection ((t ((:background companyBackground)))))
 '(company-tooltip-common ((t (:foreground "#c3ac43"))))                  ;; Kind of Yellow
 '(company-tooltip-common-selection ((t (:foreground "#ffd100"))))        ;; Same Yellow but Lighter
 '(company-tooltip-annotation ((t (:foreground "#8ccf64"))))              ;; Kind of Green
 '(company-tooltip-annotation-selection ((t (:foreground "#ffd100")))))   ;; Same Yellow as above

(setq! company-box-doc-enable nil)

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
;; ;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq! dired-open-extensions '(("gif" . "sxiv")
                               ("jpg" . "sxiv")
                               ("png" . "sxiv")
                               ("mkv" . "mpv")
                               ("mp4" . "mpv")))

(setq! evil-move-beyond-eol t
       evil-move-cursor-back nil)

(setq! evil-kill-on-visual-paste nil)

(map! "C-M-k" #'drag-stuff-up)
(map! "C-M-j" #'drag-stuff-down)

(setq! olivetti-body-width 120)

(map! :leader
      :desc "Toggle Olivetti Mode" "t o" #'olivetti-mode)

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

(setq! org-directory "~/org/")

(after! org
  (setq org-clock-sound "~/Music/ding.wav"))

;; Load org-faces to make sure we can set appropriate faces
(require 'org-faces)

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (mixed-pitch-mode 1)
  ;; (visual-fill-column-mode) ;; restrict lines size
  (olivetti-mode 1) ;; To center buffer as word text
  (visual-line-mode 1)) ;; Use visual line mode

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

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
  ;; Make the document title a bit bigger
  (set-face-attribute 'org-document-title nil :font doom-variable-pitch-font :weight 'bold :height 1.3)

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
  "Switch entry to DONE when all subentries are done, to TODO otherwise.
   Only operates on entries with the TODO keyword."
  (let ((org-log-done t)
        (org-log-states nil)
        (todo-state (org-get-todo-state)))
    (when (member todo-state org-todo-keywords-1) ; only operate on entries with the TODO keyword
      (let ((new-state (if (= n-not-done 0) "DONE" "TODO")))
        (org-todo new-state)))))

(use-package! org
  :defer t
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq! org-ellipsis " ▼ ")
  (setq! org-log-done 'time)
  (setq! org-default-priority 67)
  (setq! org-hide-emphasis-markers t)
  (setq! org-hierarchical-todo-statistics nil)
  (efs/org-font-setup)
  :init
  (add-hook 'org-after-todo-statistics-hook #'org-summary-todo))

(setq! org-emphasis-alist
       '(("*" my-org-emphasis-bold)
         ("/" italic)
         ("_" underline)
         ("=" org-verbatim verbatim)
         ("~" org-code verbatim)
         ("+" (:strike-through t))))

(defface my-org-emphasis-bold
  '((default :inherit bold)
    (((class color) (min-colors 88) (background light))
     :foreground "#a60000")
    (((class color) (min-colors 88) (background dark))
     :foreground "#ff8059"))
  "My bold emphasis for Org.")

(setq! org-image-actual-width nil)

(use-package! org-bullets
  :defer t
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package! org-fancy-priorities
  :defer t
  :after org
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq! org-fancy-priorities-list '((?A . "[‼]")
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

  (setq! holiday-french-holidays
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
           ;; même jour que la pentecôte TODO
           (holiday-float 6 0 3 "Fête des pères"))) ;; troisième dimanche de juin

  (setq! calendar-holidays holiday-french-holidays))

(defun org-agenda-auto-refresh-agenda-buffer ()
  "If we're in an agenda file, and there is an agenda buffer, refresh it."
  (when (org-agenda-file-p)
    (when-let ((buffer (get-buffer org-agenda-buffer-name)))
      (with-current-buffer buffer
        (org-agenda-redo-all)))))


(after! org
  (add-hook 'after-revert-hook #'org-agenda-auto-refresh-agenda-buffer))

(after! org
  :ensure-t
  :custom
  (setq org-roam-directory "~/RoamNotes")
  (setq org-roam-index-file "~/RoamNotes/index.org")
  (setq org-roam-capture-templates `(("d" " Default" plain "\n\n* %?"
                                      :icon ("nf-fa-file_text_o" :set "faicon" :color "lcyan")
                                      :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                                                         "#+title: ${title}\n") :unnarrowed t)
                                     ("p" " Problems" plain "\n* [[id:f23824a1-0515-47c6-b386-21d83a9aec21][PROBLEM]]\n%?\n* SOLVING"
                                      :icon ("nf-fa-eye" :set "faicon" :color "lcyan")
                                      :target (file+head "problems/%<%Y%m%d%H%M%S>-${slug}.org"
                                                         "#+title: ${title}\n#+filetags: :Problem:\n") :unnarrowed t))))

(use-package! websocket
  :defer t
  :after org-roam)

(use-package! org-roam-ui
  :defer t
  :after org-roam ;; or :after org
  :hook (after-init . org-roam-ui-mode)
  :config
  (setq! org-roam-ui-follow t
         org-roam-ui-sync-theme t
         org-roam-ui-update-on-save t
         org-roam-ui-open-on-start nil))

(setq! org-gcal-client-id "809125859117-d4lsgmmpri4bmefhrj2n22uqn63gdf42.apps.googleusercontent.com"
       org-gcal-client-secret "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"
       org-gcal-fetch-file-alist '(("corentin33210@gmail.com" .  "~/org/schedule.org")))
(require 'org-gcal)

(use-package! org-ai
  :defer t
  :commands (org-ai-mode
             org-ai-global-mode)
  :init
  (add-hook 'org-mode-hook #'org-ai-mode) ; enable org-ai in org-mode
  (org-ai-global-mode) ; installs global keybindings on C-c M-a
  :config
  (setq! org-ai-default-chat-model "gpt-3.5-turbo") ; gpt-4 if you are on the gpt-4 beta:
  (org-ai-install-yasnippets) ; if you are using yasnippet and want `ai` snippets
  )

(use-package! emacs-everywhere
  :if (daemonp)
  :config
  (require 'spell-fu)
  (setq emacs-everywhere-major-mode-function #'org-mode
        emacs-everywhere-frame-name-format "Edit ∷ %s — %s")
  (defadvice! emacs-everywhere-raise-frame ()
    :after #'emacs-everywhere-set-frame-name
    (setq emacs-everywhere-frame-name (format emacs-everywhere-frame-name-format
                                (emacs-everywhere-app-class emacs-everywhere-current-app)
                                (truncate-string-to-width
                                 (emacs-everywhere-app-title emacs-everywhere-current-app)
                                 45 nil nil "…")))
    ;; need to wait till frame refresh happen before really set
    (run-with-timer 0.1 nil #'emacs-everywhere-raise-frame-1))
  (defun emacs-everywhere-raise-frame-1 ()
    (call-process "wmctrl" nil nil nil "-a" emacs-everywhere-frame-name)))

(setq! which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
   ))

;; (require 'ivy)
;; (require 'counsel)

;; (setq! ivy-re-builders-alist
;;        '((counsel-rg . ivy--regex-plus)
;;          (swiper . ivy--regex-plus)
;;          (swiper-isearch . ivy--regex-plus)
;;          (t . ivy--regex-ignore-order)))

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

  ;; Set treemacs theme
  (setq doom-themes-treemacs-theme "doom-colors"))

(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration '(".*\\.html\\.erb$" . "html"))
  (setq lsp-ui-sideline-show-code-actions t))

(add-hook! 'web-mode-hook
  (when (string-match-p "\\.erb\\'" buffer-file-name)
    (setq! +format-with :none)))

(use-package! web-mode
  :defer t
  :config
  (setq! web-mode-markup-indent-offset 2)
  (setq! web-mode-css-indent-offset 2)
  (setq! web-mode-code-indent-offset 2)
  (setq! web-mode-auto-close-style 2)
  (setq! web-mode-enable-auto-closing 2))

;; (after! centaur-tabs
;;   (centaur-tabs-group-by-projectile-project))
;; (after! centaur-tabs
;;   (setq! centaur-tabs-set-bar 'right))
;; (add-hook 'server-after-make-frame-hook 'centaur-tabs-mode)
;; Enable centaur-tabs without faulty theming in daemon mode.
;; (if (not (daemonp))
;;         (centaur-tabs-mode)

;;   (defun centaur-tabs-daemon-mode (frame)
;;     (unless (and (featurep 'centaur-tabs) (centaur-tabs-mode-on-p))
;;       (run-at-time nil nil (lambda () (centaur-tabs-mode)))))
;;   (add-hook 'after-make-frame-functions #'centaur-tabs-daemon-mode))

(map! :leader
      :desc "Toggle Centaur Tabs" "t a" #'centaur-tabs-mode)

(map! :ni "C-," #'+tabs:previous-or-goto)
(map! :ni "C-;" #'+tabs:next-or-goto)

(after! lsp-mode
  (setq lsp-log-io nil)
  (setq lsp-idle-delay 0.200)
  (setq read-process-output-max (* 1024 1024)))

;; (setq! gc-cons-threshold 100000000))

;; (require 'yasnippet)
;; (yas-global-mode 1)

;; (after! lsp-mode
;;   (setq lsp-enable-completion nil))

;; (add-to-list 'load-path "~/Application/lsp-bridge")

;; (require 'lsp-bridge)
;; (global-lsp-bridge-mode)
;; (setq acm-menu-length 15)
;; (evil-define-key 'insert acm-mode-map (kbd "C-j") 'acm-select-next)
;; (evil-define-key 'insert acm-mode-map (kbd "C-k") 'acm-select-prev)
;; (add-hook 'acm-mode-hook 'evil-normalize-keymaps)

(setq! projectile-create-missing-test-files t)

(setq! xeft-directory "~/RoamNotes")

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(setq helm-display-function #'pop-to-buffer)

(setq shackle-rules '(("\\`\\*helm.*?\\*\\'" :regexp t :align t :ratio 0.46)))
(shackle-mode)

(load! (expand-file-name "rails-settings.el" doom-user-dir))
