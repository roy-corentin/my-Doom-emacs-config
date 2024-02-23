;;; my-icons.el -*- lexical-binding: t; -*-


(defvar my-icons '((Unknown .
                    #("" 0 1
                      (face
                       (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-warning-face)
                       font-lock-face
                       (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-warning-face)
                       display
                       ((raise 0.0)
                        (height 0.95))
                       rear-nonsticky t)))
                   (Text .
                         #("" 0 1
                           (face
                            (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-doc-face)
                            font-lock-face
                            (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-doc-face)
                            display
                            (raise 0.0)
                            rear-nonsticky t)))
                   (Method .
                           #("󰏉" 0 1
                             (face
                              (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-function-name-face)
                              font-lock-face
                              (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-function-name-face)
                              display
                              (raise 0.0)
                              rear-nonsticky t)))
                   (Function .
                             #("󰊕" 0 1
                               (face
                                (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-function-name-face)
                                font-lock-face
                                (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-function-name-face)
                                display
                                (raise 0.0)
                                rear-nonsticky t)))
                   (Constructor .
                                #("" 0 1
                                  (face
                                   (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-function-name-face)
                                   font-lock-face
                                   (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-function-name-face)
                                   display
                                   (raise 0.0)
                                   rear-nonsticky t)))
                   (Field .
                          #("󰂡" 0 1
                            (face
                             (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                             font-lock-face
                             (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                             display
                             (raise 0.0)
                             rear-nonsticky t)))
                   (Variable .
                             #("󱃠" 0 1
                               (face
                                (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                                font-lock-face
                                (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                                display
                                (raise 0.0)
                                rear-nonsticky t)))
                   (Class .
                          #("󱃮" 0 1
                            (face
                             (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-type-face)
                             font-lock-face
                             (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-type-face)
                             display
                             (raise 0.0)
                             rear-nonsticky t)))
                   (Interface .
                              #("" 0 1
                                (face
                                 (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-type-face)
                                 font-lock-face
                                 (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-type-face)
                                 display
                                 (raise 0.0)
                                 rear-nonsticky t)))
                   (Module .
                           #("" 0 1
                             (face
                              (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-preprocessor-face)
                              font-lock-face
                              (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-preprocessor-face)
                              display
                              (raise 0.0)
                              rear-nonsticky t)))
                   (Property .
                             #("" 0 1
                               (face
                                (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                                font-lock-face
                                (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                                display
                                (raise 0.0)
                                rear-nonsticky t)))
                   (Unit .
                         #("" 0 1
                           (face
                            (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-constant-face)
                            font-lock-face
                            (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-constant-face)
                            display
                            (raise 0.0)
                            rear-nonsticky t)))
                   (Value .
                          #("󰇂" 0 1
                            (face
                             (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-builtin-face)
                             font-lock-face
                             (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-builtin-face)
                             display
                             (raise 0.0)
                             rear-nonsticky t)))
                   (Enum .
                         #("" 0 1
                           (face
                            (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-builtin-face)
                            font-lock-face
                            (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-builtin-face)
                            display
                            (raise 0.0)
                            rear-nonsticky t)))
                   (Keyword .
                            #("" 0 1
                              (face
                               (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-keyword-face)
                               font-lock-face
                               (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-keyword-face)
                               display
                               (raise 0.0)
                               rear-nonsticky t)))
                   (Snippet .
                            #("" 0 1
                              (face
                               (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-string-face)
                               font-lock-face
                               (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-string-face)
                               display
                               (raise 0.0)
                               rear-nonsticky t)))
                   (Color .
                          #("" 0 1
                            (face
                             (:family "Symbols Nerd Font Mono" :height 1.0 :inherit success)
                             font-lock-face
                             (:family "Symbols Nerd Font Mono" :height 1.0 :inherit success)
                             display
                             (raise 0.0)
                             rear-nonsticky t)))
                   (File .
                         #("" 0 1
                           (face
                            (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-string-face)
                            font-lock-face
                            (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-string-face)
                            display
                            (raise 0.0)
                            rear-nonsticky t)))
                   (Reference .
                              #("" 0 1
                                (face
                                 (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                                 font-lock-face
                                 (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                                 display
                                 (raise 0.0)
                                 rear-nonsticky t)))
                   (Folder .
                           #("" 0 1
                             (face
                              (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                              font-lock-face
                              (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                              display
                              (raise 0.0)
                              rear-nonsticky t)))
                   (EnumMember .
                               #("" 0 1
                                 (face
                                  (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-builtin-face)
                                  font-lock-face
                                  (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-builtin-face)
                                  display
                                  (raise 0.0)
                                  rear-nonsticky t)))
                   (Constant .
                             #("" 0 1
                               (face
                                (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-constant-face)
                                font-lock-face
                                (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-constant-face)
                                display
                                (raise 0.0)
                                rear-nonsticky t)))
                   (Struct .
                           #("" 0 1
                             (face
                              (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                              font-lock-face
                              (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                              display
                              (raise 0.0)
                              rear-nonsticky t)))
                   (Event .
                          #("" 0 1
                            (face
                             (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-warning-face)
                             font-lock-face
                             (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-warning-face)
                             display
                             (raise 0.0)
                             rear-nonsticky t)))
                   (Operator .
                             #("" 0 1
                               (face
                                (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-comment-delimiter-face)
                                font-lock-face
                                (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-comment-delimiter-face)
                                display
                                (raise 0.0)
                                rear-nonsticky t)))
                   (TypeParameter .
                                  #("" 0 1
                                    (face
                                     (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-type-face)
                                     font-lock-face
                                     (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-type-face)
                                     display
                                     (raise 0.0)
                                     rear-nonsticky t)))
                   (Template .
                             #("" 0 1
                               (face
                                (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-string-face)
                                font-lock-face
                                (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-string-face)
                                display
                                (raise 0.0)
                                rear-nonsticky t)))
                   (ElispFunction .
                                  #("󰊕" 0 1
                                    (face
                                     (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-function-name-face)
                                     font-lock-face
                                     (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-function-name-face)
                                     display
                                     (raise 0.0)
                                     rear-nonsticky t)))
                   (ElispVariable .
                                  #("󱃠" 0 1
                                    (face
                                     (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                                     font-lock-face
                                     (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-variable-name-face)
                                     display
                                     (raise 0.0)
                                     rear-nonsticky t)))
                   (ElispFeature .
                                 #("" 0 1
                                   (face
                                    (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-builtin-face)
                                    font-lock-face
                                    (:family "Symbols Nerd Font Mono" :height 1.0 :inherit font-lock-builtin-face)
                                    display
                                    (raise 0.0)
                                    rear-nonsticky t)))
                   (ElispFace .
                              #("" 0 1
                                (face
                                 (:family "Symbols Nerd Font Mono" :height 1.0 :inherit success)
                                 font-lock-face
                                 (:family "Symbols Nerd Font Mono" :height 1.0 :inherit success)
                                 display
                                 (raise 0.0)
                                 rear-nonsticky t)))))

;; Provide the feature for external use
(provide 'my-icons)
