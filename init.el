
(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)


(load-theme 'tango-dark)

(setq scroll-margin 12)
(setq scroll-conservatively 144)


(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


(global-display-line-numbers-mode t)
(global-visual-line-mode t)
(global-hl-line-mode t)
(set-face-attribute 'hl-line nil
		    :inherit nil
		    :foreground 'unspecified
		    :background "#404040"
		    )

(setq display-line-numbers-type 'relative)


(define-key global-map (kbd "C-y") nil)
(define-key ctl-x-map (kbd "SPC") nil)





    




(setq tab-always-indent nil)

(setq backup-directory-alist `(("." . "~/.cache/emacs/backup")))
(setq backup-by-copying t)



(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))






(require 'use-package)
(setq use-package-always-ensure t)


(use-package ivy
  :config
  (ivy-mode))
(use-package counsel
  :after ivy
  :config
  (counsel-mode))

(use-package which-key
  :init
  (setq which-key-idle-delay 0.2)
  :config
  (which-key-mode))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-search-module 'evil-search)
  (evil-mode)

  :config
  (dolist (state-map (list evil-normal-state-map
			   evil-visual-state-map))
    (define-key state-map (kbd "SPC") ctl-x-map))

  (define-key evil-insert-state-map (kbd "M-SPC") ctl-x-map)

  (define-key evil-insert-state-map (kbd "C-y") nil)

  (define-key evil-normal-state-map (kbd "-") #'dired-jump)


  (add-hook 'dired-mode-hook #'evil-emacs-state)

  )

(use-package general
  :config
  (general-evil-setup)
  (general-create-definer my/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")

  (my/leader-keys
    "SPC o" '(org-agenda :which-key "org-agenda")
    "SPC c" '(compile :which-key "compile")
    "SPC r" '(recompile :which-key "recompile")
   )
  )


(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))

(use-package evil-tutor)


(use-package magit)

(use-package lsp-mode
  :commands lsp
  :init
  ;; keymap prefix for lsp-mode commands
  (setq lsp-keymap-prefix "C-c l"))

(use-package flycheck
  :init
  (global-flycheck-mode))

(use-package company
  :init
  (global-company-mode)


  :config
  (setq company-minimum-prefix-length 1
	company-idle-delay 0.4
	company-selection-wrap-around t)

  (defun my/company-complete-or-begin ()
    (interactive)
    (if (company--active-p)
	(company-complete-selection)
      (company-manual-begin)))

  (add-hook 'evil-insert-state-exit-hook #'company-abort)

  (define-key company-mode-map (kbd "C-y") #'my/company-complete-or-begin)


  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "<tab>") nil)
  (define-key company-active-map (kbd "TAB") nil)
  (define-key company-active-map (kbd "<backtab>") nil)
  (define-key company-active-map (kbd "DEL") nil)

  (define-key company-active-map (kbd "C-h") nil)
  (define-key company-active-map (kbd "C-s") #'company-show-doc-buffer)
  
  )

(use-package flx)

(use-package company-fuzzy
  :hook (company-mode . company-fuzzy-mode)
  :init
  (setq company-fuzzy-sorting-backend 'flx
	company-fuzzy-reset-selection t
        company-fuzzy-prefix-on-top nil
        company-fuzzy-trigger-symbols '("." "->" "<" "\"" "'" "@")))
 



(use-package lsp-scheme
  :config
  (add-hook 'scheme-mode-hook #'lsp-scheme-guile))


(setq org-agenda-files '("~/Org/agenda.org"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company-fuzzy counsel evil-collection evil-tutor flx flycheck
		   general lsp-scheme magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
