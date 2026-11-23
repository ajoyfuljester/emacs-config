;;; init.el --- Personal Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:

;; This is a more organized version of my config.


;;; Code:


;;; Basic settings

(setq inhibit-startup-screen t)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;;; Editing

(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(setq tab-always-indent nil)

(delete-selection-mode 1)
(show-paren-mode 1)
(column-number-mode 1)

;;; Interface

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(require 'display-line-numbers)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(global-hl-line-mode t)
(global-visual-line-mode t)

(setq scroll-margin 12)
(setq scroll-conservatively 144)

;;;; Appearance

(add-to-list 'default-frame-alist `(font . "Deja Vu Sans Mono-12"))

;;;;; Colors

(defvar my/color0  "#1c1c1c") ; black
(defvar my/color1  "#dc1e2e") ; red
(defvar my/color2  "#91e833") ; green
(defvar my/color3  "#f6f740") ; yellow
(defvar my/color4  "#4f84ff") ; blue
(defvar my/color5  "#bc64f7") ; magenta
(defvar my/color6  "#00b594") ; cyan
(defvar my/color7  "#dedede") ; white

(defvar my/color8  "#282828") ; bright black
(defvar my/color9  "#eb8258") ; bright red
(defvar my/color10 "#61e786") ; bright green
(defvar my/color11 "#fff07c") ; bright yellow
(defvar my/color12 "#a2d2ff") ; bright blue
(defvar my/color13 "#e086d3") ; bright magenta
(defvar my/color14 "#00f5d4") ; bright cyan
(defvar my/color15 "#fafafa") ; bright white

(defvar my/selection "#505050") ; selection
(defvar my/hl-line "#404040") ; selection


;;;;; Faces

(custom-set-faces
 `(default ((t (:background ,my/color0
                            :foreground ,my/color15
                            :font "monospace"))))

 `(cursor ((t (:background ,my/color3))))

 `(flycheck-fringe-error ((t (:foreground ,my/color1))))
 `(flycheck-fringe-info ((t (:foreground ,my/color4))))
 `(flycheck-fringe-warning ((t (:foreground ,my/color3))))
 `(flycheck-warning ((t (:underline (:style wave
                                            :color ,my/color11)))))

 `(font-lock-builtin-face ((t (:foreground ,my/color4))))
 `(font-lock-comment-face ((t (:foreground ,my/color6
                                           :slant italic))))
 `(font-lock-keyword-face ((t (:foreground ,my/color3
                                           :weight bold))))
 `(font-lock-string-face ((t (:foreground ,my/color2))))
 `(font-lock-type-face ((t (:foreground ,my/color10))))
 `(font-lock-variable-name-face ((t (:foreground ,my/color12
                                                 :weight normal))))

 `(fringe ((t (:background ,my/color8))))

 `(line-number ((t (:background ,my/color8
                                :foreground ,my/color6))))
 `(line-number-current-line ((t (:background ,my/color3
                                             :foreground ,my/color0
											 :weight bold))))

 `(mode-line ((t (:inherit line-number-current-line
                           :background unspecified
                           :box unspecified
                           :foreground unspecified))))
 `(mode-line-highlight ((t (:background ,my/color4))))
 `(mode-line-inactive ((t (:box unspecified
                                 :background ,my/color8
                                 :foreground ,my/color14))))

 `(escape-glyph ((t (:foreground ,my/color5))))
 `(region ((t (:background ,my/selection))))
 `(hl-line ((t (:background ,my/hl-line))))
 )


;;; Backups

(setq backup-directory-alist `(("." . "~/.cache/emacs/backup")))
(setq backup-by-copying t)


;;; Keyboard

(defvar my/leader-map
  (make-sparse-keymap "My leader keymap"))
(global-set-key (kbd "M-SPC") my/leader-map)


;;;; Keybindings

(define-key my/leader-map (kbd "w") #'whitespace-mode)
(define-key my/leader-map (kbd "o") #'org-agenda)


;;; Packages

;;;; Init

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")))


(package-initialize t)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)




;;;; Package configurations

;;;;; magit

(package-activate 'magit)
(use-package magit
  :config
  (define-key my/leader-map (kbd "g") #'magit-status))


;;;;; which-key

(use-package which-key
  :init (setq which-key-idle-delay 0.75)
  :config (which-key-mode))


;;;;; compile


(use-package compile
  :config
  (define-key compilation-mode-map (kbd "C-c C-c") #'compile)
  (define-key compilation-mode-map (kbd "C-c C-r") #'recompile)
  (define-key my/leader-map (kbd "c") #'compile)
  (define-key my/leader-map (kbd "r") #'recompile)
  )


;;;;; flycheck

(package-activate 'flycheck)
(use-package flycheck
  :config
  (global-flycheck-mode 1))


;;;;; lsp-mode

(package-activate 'lsp-mode)
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "M-SPC l"))


;;; init.el ends here

