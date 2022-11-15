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

;; Silence compiler warnings as they can be pretty disruptive
(if (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation nil)
    (setq native-comp-deferred-compilation nil))
;; In noninteractive sessions, prioritize non-byte-compiled source files to
;; prevent the use of stale byte-code. Otherwise, it saves us a little IO time
;; to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

(use-package all-the-icons)

;; (use-package dashboard
;;   :init      ;; tweak dashboard config before loading it
;;   (setq dashboard-set-heading-icons t)
;;   (setq dashboard-set-file-icons t)
;;   (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
;;   ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
;;   ;; (setq dashboard-startup-banner "~/.emacs.d/emacs-dash.png")  ;; use custom image as banner
;;   (setq dashboard-center-content nil) ;; set to 't' for centered content
;;   (setq dashboard-items '((recents . 5)
;;                           (agenda . 5 )
;;                           (bookmarks . 3)
;;                           (projects . 3)
;;                           (registers . 3)))
;;   :config
;;   (dashboard-setup-startup-hook)
;;   (dashboard-modify-heading-icons '((recents . "file-text")
;; 			      (bookmarks . "book"))))

;; (setq fancy-splash-image "~/Pictures/Fox.png")
;; (setq fancy-splash-image "~/Pictures/Doom_Logo.png")
(setq fancy-splash-image "~/Pictures/cyberpunk_logo.png")

;; (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

;; (use-package elfeed
;;   :config
;;   (setq elfeed-search-feed-face ":foreground #fff :weight bold"
;;         elfeed-feeds (quote
;;                        (("https://www.reddit.com/r/linux.rss" reddit linux)
;;                         ("https://www.reddit.com/r/commandline.rss" reddit commandline)
;;                         ("https://www.reddit.com/r/distrotube.rss" reddit distrotube)
;;                         ("https://www.reddit.com/r/emacs.rss" reddit emacs)
;;                         ("https://www.gamingonlinux.com/article_rss.php" gaming linux)
;;                         ("https://hackaday.com/blog/feed/" hackaday linux)
;;                         ("https://opensource.com/feed" opensource linux)
;;                         ("https://linux.softpedia.com/backend.xml" softpedia linux)
;;                         ("https://itsfoss.com/feed/" itsfoss linux)
;;                         ("https://www.zdnet.com/topic/linux/rss.xml" zdnet linux)
;;                         ("https://www.phoronix.com/rss.php" phoronix linux)
;;                         ("http://feeds.feedburner.com/d0od" omgubuntu linux)
;;                         ("https://www.computerworld.com/index.rss" computerworld linux)
;;                         ("https://www.networkworld.com/category/linux/index.rss" networkworld linux)
;;                         ("https://www.techrepublic.com/rssfeeds/topic/open-source/" techrepublic linux)
;;                         ("https://betanews.com/feed" betanews linux)
;;                         ("http://lxer.com/module/newswire/headlines.rss" lxer linux)
;;                         ("https://distrowatch.com/news/dwd.xml" distrowatch linux)))))

;; (use-package elfeed-goodies
;;   :init
;;   (elfeed-goodies/setup)
;;   :config
;;   (setq elfeed-goodies/entry-pane-size 0.5))

;; (add-hook 'elfeed-show-mode-hook 'visual-line-mode)
;; (evil-define-key 'normal elfeed-show-mode-map
;;   (kbd "J") 'elfeed-goodies/split-show-next
;;   (kbd "K") 'elfeed-goodies/split-show-prev)
;; (evil-define-key 'normal elfeed-search-mode-map
;;   (kbd "J") 'elfeed-goodies/split-show-next
;;   (kbd "K") 'elfeed-goodies/split-show-prev)

(use-package emojify
  :hook (after-init . global-emojify-mode))

;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "JetBrainsMono NF" :size 13 :weight 'medium))
;; (setq doom-font (font-spec :family "Hack Nerd Font" :size 12 :weight 'medium))

;; enable bold and italic
(after! doom-themes
      (setq doom-themes-enable-bold t)
      (setq doom-themes-enable-italic t))

;; keyword in Italic for example "for"
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(set-face-attribute 'font-lock-comment-face nil :foreground "#5B6268" :slant 'italic)
(set-face-attribute 'font-lock-function-name-face nil :foreground "#c678dd" :slant 'italic)
(set-face-attribute 'font-lock-variable-name-face nil :foreground "#dcaeea" :slant 'italic)

;; changes certain keywords to symbols, such as lamda!
(setq global-prettify-symbols-mode t)

(setq doom-theme 'doom-monokai-machine)
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-solarized-dark)

(set-frame-parameter (selected-frame) 'alpha '(97 97))
(add-to-list 'default-frame-alist '(alpha 97 97))

(setq display-line-numbers-type `relative)

(require 'company-tabnine)
(add-to-list 'company-backends #'company-tabnine)
(setq company-idle-delay 0
      company-minimum-prefix-length 1)
(setq company-tooltip-margin 3)
(setq company-format-margin-function 'company-text-icons-margin)
(setq company-text-icons-add-background t)
(custom-set-faces
 '(company-tooltip
   ((t (:background "#57666a" )))))

;; (use-package all-the-icons-dired)
;; (use-package dired-open)
;; (use-package peep-dired)

;; (nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
;;                "d d" '(dired :which-key "Open dired")
;;                "d j" '(dired-jump :which-key "Dired jump to current")
;;                "d p" '(peep-dired :which-key "Peep-dired"))

;; (with-eval-after-load 'dired
;;   ;;(define-key dired-mode-map (kbd "M-p") 'peep-dired)
;;   (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
;;   (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
;;   (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
;;   (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file))

;; (add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; ;; Get file icons in dired
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; ;; With dired-open plugin, you can launch external programs for certain extensions
;; ;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
;; (setq dired-open-extensions '(("gif" . "sxiv")
;;                               ("jpg" . "sxiv")
;;                               ("png" . "sxiv")
;;                               ("mkv" . "mpv")
;;                               ("mp4" . "mpv")))

;; disabled move backward between different mode
(setq evil-move-beyond-eol t)
(setq evil-move-cursor-back nil)

(map! :ni "C-," #'previous-buffer)
(map! :ni "C-;" #'next-buffer)

(map! "C-M-k" #'drag-stuff-up)
(map! "C-M-j" #'drag-stuff-down)

(after! lsp-mode
        (add-to-list 'lsp-language-id-configuration '(".*\\.html\\.erb$" . "html"))
        (setq lsp-ui-sideline-show-code-actions t)
)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; (after! org
;;   (setq org-clock-sound "PATH"))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  ;; (variable-pitch-mode 1)
  (visual-line-mode 1))

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▼ ")
  (efs/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; (defun efs/org-mode-visual-fill ()
;;   (setq visual-fill-column-width 100
;;         visual-fill-column-center-text t)
;;   (visual-fill-column-mode 1))

;; (use-package visual-fill-column
;;   :hook (org-mode . efs/org-mode-visual-fill))

(setq org-image-actual-width nil)

(after! org
        (setq org-roam-directory "~/RoamNotes")
        (setq org-roam-index-file "~/RoamNotes/index.org"))

;; (use-package org-roam
;;   ;; :ensure t

;;   :custom
;;   (org-roam-directory "~/RoamNotes")
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n i" . org-roam-node-insert))
;;   :config
;;   (org-roam-setup))

(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

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

(use-package treemacs
  :defer t
  :config
  (progn
    (treemacs-follow-mode t))
)

(setq doom-themes-treemacs-theme "doom-colors")

(use-package! python-black
  :demand t
  :after python
  :config
  (add-hook! 'python-mode-hook #'python-black-on-save-mode)
  (map! :leader :desc "Blacken Buffer" "m b b" #'python-black-buffer)
  (map! :leader :desc "Blacken Region" "m b r" #'python-black-region)
  (map! :leader :desc "Blacken Statement" "m b s" #'python-black-statement)
)

;; (use-package prettier
;;   :after js2-mode
;;   :init
;;   (add-hook 'js2-mode-hook 'prettier-mode)
;;   (add-hook 'web-mode-hook 'prettier-mode))

(add-to-list 'auto-mode-alist '("/some/react/path/.*\\.js[x]?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/some/react/path/.*\\.ts[x]?\\'" . web-mode))

(setq-hook! 'typescript-tsx-mode-hook +format-with-lsp nil)
(setq-hook! 'typescript-mode-hook +format-with-lsp nil)

(load (expand-file-name "rails-settings.el" doom-private-dir))
