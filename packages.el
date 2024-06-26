;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
;; (package! project :pin "125a1a8d15f998cd495ef6a6b981b1a0e201bd2f") ; Feb 23

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

(package! org-bullets)
(package! org-roam)
(package! csv-mode)
(package! dired-open)
(package! peep-dired)
(package! treesit-auto)
(package! spell-fu)
(package! xeft)
(package! magit-stats)
(package! org-inline-anim)

;; OrgRoam GCalendar
;; (package! org-gcal)

;; Org-AI
(package! org-ai)

;; Org-roam-ui
(package! org-roam-ui)

;; Xeft search
(package! xeft)

;; Olivetti to center buffer
(package! olivetti)

;; Package to fix some popup rules
;; (package! shackle)

;; Copilot
(package! copilot :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el" "dist")) :pin "581cadd6f4229223fd5c57984f9595aeb86c84f7"   )

;; Ewal
(package! ewal)
(package! ewal-doom-themes)

;; Devdoc
(package! devdocs)

;; Elixir-ts
(package! heex-ts :recipe (:host github :repo "wkirschbaum/heex-ts-mode" :files ("*.el")))
(package! elixir-ts :recipe (:host github :repo "wkirschbaum/elixir-ts-mode" :files ("*.el")))

;; Org-Note
(package! orgnote :recipe (:host github :repo "artawower/orgnote.el"))

;; SVG-Tag-Mode
(package! svg-tag-mode)

;; Blamer
(package! blamer :recipe (:host github :repo "artawower/blamer.el"))

;; Arduiono
(package! arduino-mode :recipe (:host github :repo "bookest/arduino-mode"))
(package! arduino-cli-mode :recipe (:host github :repo "motform/arduino-cli-mode"))

;; Elixir-ts
(package! heex-ts :recipe (:host github :repo "wkirschbaum/heex-ts-mode" :files ("*.el")))
(package! elixir-ts :recipe (:host github :repo "wkirschbaum/elixir-ts-mode" :files ("*.el")))

;; Org-Note
(package! orgnote :recipe (:host github :repo "artawower/orgnote.el"))

;; Chrome Emacs
(package! atomic-chrome :recipe (:host github :repo "KarimAziev/atomic-chrome"))

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
                                        ;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
                                        ;(package! another-package
                                        ;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
                                        ;(package! this-package
                                        ;  :recipe (:host github :repo "username/repo"
                                        ;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
                                        ;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
                                        ;(package! builtin-package :recipe (:nonrecursive t))
                                        ;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
                                        ;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
                                        ;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
                                        ;(unpin! pinned-package)
;; ...or multiple packages
                                        ;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
                                        ;(unpin! t)
