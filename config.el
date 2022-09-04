(setq user-full-name "Corentin Roy"
      user-mail-address "corentin.roy02@laposte.net")

;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "JetBrainsMono NF" :size 12 :weight 'medium))
;; (setq doom-font (font-spec :family "Hack Nerd Font" :size 12 :weight 'medium))

;; enable bold and italic
(after! doom-themes
      (setq doom-themes-enable-bold t)
      (setq doom-themes-enable-italic t))

;; keyword in Italic for example "for"
(custom-set-faces!
  '(font-lock-keyword-face :slant italic))

(setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-solarized-dark)

(set-frame-parameter (selected-frame) 'alpha '(97 97))
(add-to-list 'default-frame-alist '(alpha 97 97))

(setq display-line-numbers-type t)

;; (setq fancy-splash-image "~/Pictures/Fox.png")
(setq fancy-splash-image "~/Pictures/Doom_Logo.png")

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

;; disabled move backward between different mode
(setq evil-move-beyond-eol t)
(setq evil-move-cursor-back nil)

;; Previous and next buffer
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
  (variable-pitch-mode 1)
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
  (setq org-ellipsis " ▾")
  (efs/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(setq org-image-actual-width nil)

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

(require 'lsp-python-ms)
(setq lsp-python-ms-auto-install-server t)
(add-hook 'python-mode-hook #'lsp)

(use-package! python-black
  :demand t
  :after python
  :config
  (add-hook! 'python-mode-hook #'python-black-on-save-mode)
  (map! :leader :desc "Blacken Buffer" "m b b" #'python-black-buffer)
  (map! :leader :desc "Blacken Region" "m b r" #'python-black-region)
  (map! :leader :desc "Blacken Statement" "m b s" #'python-black-statement)
)

(use-package prettier
  :after js2-mode
  :init
  (add-hook 'js2-mode-hook 'prettier-mode)
  (add-hook 'web-mode-hook 'prettier-mode))

(add-to-list 'auto-mode-alist '("/some/react/path/.*\\.js[x]?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/some/react/path/.*\\.ts[x]?\\'" . web-mode))

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

(setq-hook! 'typescript-tsx-mode-hook +format-with-lsp nil)
(setq-hook! 'typescript-mode-hook +format-with-lsp nil)

(load (expand-file-name "rails-settings.el" doom-private-dir))
