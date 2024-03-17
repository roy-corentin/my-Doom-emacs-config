(after! rotate-text
  (add-to-list 'rotate-text-words '("valid" "invalid"))
  (add-to-list 'rotate-text-words '("context" "describe"))
  (add-to-list 'rotate-text-symbols '("be_valid" "be_invalid"))
  (add-to-list 'rotate-text-symbols '("valid?" "invalid?"))
  (add-to-list 'rotate-text-symbols '("present?" "blank?" "nil?"))
  (add-to-list 'rotate-text-symbols '("belongs_to" "has_many" "has_one"))
  (add-to-list 'rotate-text-symbols '("if" "unless"))
  (add-to-list 'rotate-text-symbols '("greater_than" "greater_than_or_equal_to" "equal_to" "less_than" "less_than_or_equal_to" "other_than" "odd" "even"))
  (add-to-list 'rotate-text-symbols '("to" "not_to")))

(after! web-mode
  (setq erb-common-words '("if" "else" "unless" "link_to" "root_path" "paginate" "form_with" "label" "text_field" "submit"
                           "check_box" "label" "radio_button" "text_area" "hidden_field" "password_field" "number_field" "range_field"
                           "date_field" "time_field" "datetime_local_field" "month_field" "week_field" "search_field" "email_field"
                           "telephone_field" "url_field" "color_field" "render" "json" "plain" "formats" "variants" "stylesheet_link_tag"
                           "javascript_include_tag" "image_tag" "video_tag" "audio_tag" "partial: " "input" "simple_form_for" "label_html: "
                           "hint_html: " "maxlength: " "value" "wrapper_html: " "required: " "as: " "hint" "error" "collection: " "as: :select"
                           "as: :radio_buttons" "as: :check_boxes" "priority" "boolean" "string" "citext" "email" "url" "tel" "password" "search" "uuid" "color" "text" "hstore" "json" "jsonb" "file" "hidden" "integer" "float" "decimal" "range" "datetime" "date" "time" "select" "radio_buttons" "check_boxes" "country" "time_zone" "current_user" "can?" "input_html: " "html: " "render partial: "))

  (defun company-web-mode-backend (command &optional arg &rest ignored)
    (interactive (list 'interactive))

    (cl-case command
      (interactive (company-begin-backend 'company-ruby-backend))
      (prefix (or (eq major-mode 'web-mode))
              (company-grab-symbol))

      (candidates
       (all-completions arg erb-common-words)))))

(after! web-mode
  (define-key web-mode-map (kbd "C-c o") #'rails-routes-insert)
  (define-key web-mode-map (kbd "C-c C-o") #'rails-routes-insert-no-cache))

(after! ruby-mode
  (map! :mode ruby-mode "C-c o" #'rails-routes-insert)
  (map! :mode ruby-mode "C-c C-o" #'rails-routes-insert-no-cache))

(after! evil
  (define-key evil-normal-state-map (kbd "g a") #'rails-routes-jump)
  (define-key evil-visual-state-map (kbd "g a") #'rails-routes-jump))

(after! ruby-mode
  (define-key ruby-mode-map (kbd "C-c s") #'rails-http-statues-insert-symbol)
  (define-key ruby-mode-map (kbd "C-c S") #'rails-http-statues-insert-code))


;; Toggle if singleline and multiline
(after! ruby-mode
  (defun otavio/-current-line-empty-p ()
    (save-excursion
      (beginning-of-line)
      (looking-at-p "[[:space:]]*$")))

  (defun otavio/-swap-search-forward-swap-to-singleline (SEARCH)
    (if (search-backward SEARCH (line-beginning-position) t)
        (progn
          (kill-visual-line)
          (forward-line 1)
          (end-of-line)
          (insert " ")
          (yank)
          (indent-according-to-mode)
          (forward-line 1)
          (kill-line)
          (kill-line)
          (forward-line -2)
          (kill-line)
          (forward-to-indentation 0)
          t)))

  (defun otavio/-swap-search-forward-swap-to-multiline (SEARCH)
    (if (search-forward SEARCH (line-end-position) t)
        (progn
          (backward-word)
          (backward-char)
          (kill-visual-line)
          (forward-line -1)
          (if (not (otavio/-current-line-empty-p))
              (progn
                (end-of-line)))
          (newline)
          (yank)
          (indent-according-to-mode)
          (forward-line 1)
          (indent-according-to-mode)
          (end-of-line)
          (newline)
          (insert "end")
          (indent-according-to-mode)
          t)))

  (defun otavio/swap-if-unless-ruby ()
    (interactive)
    (beginning-of-line)
    (forward-word)
    (setq CHANGED nil)
    (if (not CHANGED)
        (setq CHANGED (otavio/-swap-search-forward-swap-to-multiline " if ")))
    (if (not CHANGED)
        (setq CHANGED (otavio/-swap-search-forward-swap-to-multiline " unless ")))
    (if (not CHANGED)
        (setq CHANGED (otavio/-swap-search-forward-swap-to-singleline "if")))
    (if (not CHANGED)
        (setq CHANGED (otavio/-swap-search-forward-swap-to-singleline "unless")))
    (if (not CHANGED)
        (progn
          (forward-line -1)
          (beginning-of-line)
          (forward-word)))
    (if (not CHANGED)
        (setq CHANGED (otavio/-swap-search-forward-swap-to-singleline "if")))
    (if (not CHANGED)
        (setq CHANGED (otavio/-swap-search-forward-swap-to-singleline "unless")))
    (if (not CHANGED)
        (progn
          (forward-line -1)
          (beginning-of-line)
          (forward-word)))
    (if (not CHANGED)
        (setq CHANGED (otavio/-swap-search-forward-swap-to-singleline "if")))
    (if (not CHANGED)
        (setq CHANGED (otavio/-swap-search-forward-swap-to-singleline "unless"))))

  (map! :map ruby-mode-map :desc "split or join if/unless" :localleader "i" #'otavio/swap-if-unless-ruby))

;; Add parameters
(after! ruby-mode
  (defun ruby-add-parameter--with-existing-parameters (args)
    (interactive)
    (forward-char -1)
    (insert ", " args))

  (defun ruby-add-parameter--without-existing-parameters (args)
    (interactive)
    (call-interactively 'end-of-line)
    (insert "(" args ")"))

  (defun ruby-add-parameter ()
    (interactive)
    (let (
          (args (read-string "Please enter the parameters that you want to add (separated by commma): "))
          )
      (when (not (string= args ""))
        (save-excursion
          (+evil/previous-beginning-of-method 1)
          (if (search-forward ")" (pos-eol) t)
              (ruby-add-parameter--with-existing-parameters args)
            (ruby-add-parameter--without-existing-parameters args))))))

  (map! :mode ruby-mode :localleader :desc "Add parameter to def" "a" #'ruby-add-parameter))

;; Method Refactor
(after! ruby-mode
  (defun ruby-extract-function ()
    (interactive)
    (let* ((function-name (read-string "Method name? "))
           (has-private (ruby-new-method-from-symbol-at-point-verify-private))
           (args (read-string "Arguments without paranthesis (leave blank for no parameters): ")))

      (when (not (string= function-name ""))
        (call-interactively 'evil-change)
        (call-interactively 'evil-normal-state)
        (ruby-extract-function--create-function function-name args has-private)
        (ruby-extract-function--insert-function function-name args))))

  (defun ruby-extract-function--insert-function (function-name args)
    (when (not (eq (point) (pos-eol)))
      (evil-forward-char))
    (insert function-name)
    (when (not (string= args ""))
      (insert "(" args ")"))
    (evil-indent (pos-bol) (pos-eol)))

  (defun ruby-extract-function--create-function (function-name args has-private)
    (save-excursion
      (if (and has-private (yes-or-no-p "private found, create method after private?"))
          (progn
            (search-forward "private\n" (point-max) t)
            (+evil/insert-newline-below 1)
            (forward-line 1))
        (progn
          (+evil/next-end-of-method)
          (when (not (string= (string (following-char)) "\n"))
            (+evil/insert-newline-above 1))
          (+evil/insert-newline-below 1)
          (forward-line 1)))
      (insert "def " function-name)
      (when (not (string= args ""))
        (insert "(" args ")"))
      (evil-indent (pos-bol) (pos-eol)) (+evil/insert-newline-below 1) (forward-line 1)
      (insert "end") (evil-indent (pos-bol) (pos-eol))
      (+evil/insert-newline-above 1) (+evil/insert-newline-below 1)
      (forward-line -1)
      (evil-paste-after 1)
      (forward-line -1)
      (when (string= (string (following-char)) "\n") (delete-char 1))
      (+evil/reselect-paste)
      (call-interactively 'evil-indent)))

  (map! :mode ruby-mode :localleader :desc "Extract Function" "m" #'ruby-extract-function))

;; Create method at point
(after! ruby-mode
  (defun ruby-new-method-from-symbol-at-point ()
    (interactive)
    (better-jumper-set-jump)
    (when (looking-at-p "\\sw\\|\\s_")
      (forward-sexp 1))
    (forward-sexp -1)
    (let* ((variable-start-point (point))
           (variable-end-point nil)
           (variable-name (save-excursion (forward-sexp 1) (setq variable-end-point (point)) (buffer-substring-no-properties variable-start-point (point))))
           (has-arguments (save-excursion (goto-char variable-end-point) (looking-at-p "(")))
           (has-private (ruby-new-method-from-symbol-at-point-verify-private))
           (arguments (ruby-new-method-from-symbol-at-point--get-arguments has-arguments variable-end-point)))
      (ruby-new-method-from-symbol-at-point--create-method variable-name (string-join (remove nil arguments) ", ") has-private)))

  (defun ruby-new-method-from-symbol-at-point-verify-private ()
    (save-excursion
      (search-forward "private\n" (point-max) t)))

  (defun ruby-new-method-from-symbol-at-point--create-method (function-name args has-private)
    (if (and has-private (yes-or-no-p "private found, create method after private?"))
        (progn
          (goto-char (point-min))
          (search-forward "private\n" (point-max))
          (+evil/insert-newline-below 1)
          (forward-line 1))
      (progn
        (+evil/next-end-of-method)
        (when (not (string= (string (following-char)) "\n"))
          (+evil/insert-newline-above 1))
        (+evil/insert-newline-below 1)
        (forward-line 1)))
    (insert "def " function-name)
    (when (not (string= args ""))
      (insert "(" args ")"))
    (evil-indent (pos-bol) (pos-eol)) (+evil/insert-newline-below 1) (forward-line 1)
    (insert "end") (evil-indent (pos-bol) (pos-eol))
    (+evil/insert-newline-below 1)
    (forward-line -1) (goto-char (pos-eol)) (newline-and-indent)
    (when (featurep 'evil)
      (evil-insert 1))
    (message "Method created!  Pro Tip:  Use C-o (normal mode) to jump back to the method usage."))

  (defun ruby-new-method-from-symbol-at-point--get-arguments (has-arguments variable-end-point)
    (when has-arguments
      (let* ((start-args-point nil)
             (end-args-point nil)
             (args-raw nil)
             )
        (save-excursion (goto-char variable-end-point) (evil-forward-word-begin) (setq start-args-point (point)) (evil-backward-word-end)
                        (evil-jump-item)
                        (setq end-args-point (point)))
        (setq args-raw (buffer-substring-no-properties start-args-point end-args-point))
        (mapcar
         (lambda (argument)
           (if (string-match-p "(...)" argument)
               (read-string (concat "name for " argument " argument:  "))
             (ruby-new-method-from-symbol-at-point--verify-exist argument))
           ) (mapcar 'string-trim (split-string (replace-regexp-in-string "(.*)" "(...)" args-raw) ","))))))

  (defun ruby-new-method-from-symbol-at-point--verify-exist (argument)
    (save-excursion
      (if (or (search-backward-regexp (concat "def " argument "\\(\(\\|$\\)") (point-min) t)
              (search-forward-regexp (concat "def " argument "\\(\(\\|$\\)") (point-max) t))
          nil
        (if (eq 0 (length (let ((case-fold-search nil))
                            (remove "" (split-string argument "[a-z]+\\(_[a-z]+\\)*")))))
            (if (or (string= argument "false")
                    (string= argument "true"))
                (read-string (concat "name for " argument " boolean:  ")) argument)
          (read-string (concat "name for " argument " expression:  "))))))

  (map! :mode ruby-mode :localleader :desc "New method from text at point" "n" #'ruby-new-method-from-symbol-at-point))
