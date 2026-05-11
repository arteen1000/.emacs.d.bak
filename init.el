(setq inhibit-startup-screen t)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror 'nomessage)
(setq column-number-mode t)
(setq auto-save-default nil
      make-backup-files nil
      create-lockfiles nil)
(setq use-short-answers t)
(setq scroll-error-top-bottom t)
(winner-mode)
(windmove-default-keybindings 'control)
(windmove-delete-default-keybindings 'none 'meta)
(windmove-swap-states-default-keybindings '(shift control))
(add-to-list 'load-path "~/.emacs.d/lisp")
(setq dired-omit-files "\\`\\.[^.].*\\|\\`\\.\\..+")
(with-eval-after-load 'dired
  (keymap-set dired-mode-map "b" #'dired-create-empty-file)
  (keymap-set dired-mode-map "e" #'dired-omit-mode))
(setq display-buffer-alist
      '(("\\*Help\\*" display-buffer-same-window)))
(defun terminal ()
  (interactive)
  (call-process "open" nil 0 nil "-a" "Terminal.app"
								(expand-file-name default-directory)))
(setq-default tab-width 2)
(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
;; (use-package websocket)
(use-package typst-preview
  :custom
  (typst-preview-partial-rendering t)
  :config
  (define-key typst-preview-mode-map (kbd "C-c C-j") #'typst-preview-send-position))
(use-package doom-themes
  :init
  (load-theme 'doom-vibrant t)  
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (doom-themes-visual-bell-config))
;; (use-package tuareg)
(use-package proof-general
	:custom
	(proof-three-window-mode-policy 'hybrid)
	(coq-run-completely-silent nil)
	(proof-three-window-enable nil))
(use-package markdown-mode
  :custom (markdown-command "pandoc"))
(global-set-key (kbd "C-c c") #'compile)
(use-package
	go-mode)
(which-key-mode)
(setq which-key-allow-multiple-replacements t)
(push '((".*A-.*" . nil) . t) which-key-replacement-alist)
(push '((".*f[0-9]?[0-9].*" . nil) . t) which-key-replacement-alist)
(use-package magit)
(setq scroll-preserve-screen-position t)
(recentf-mode 1)
(use-package eglot
	:ensure nil
	:hook ((c++-mode . eglot-ensure)
				 (go-mode . eglot-ensure)))
(use-package olivetti
	:custom (olivetti-body-width 80))
(use-package multiple-cursors
  :bind (("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-c C-<"     . mc/mark-all-like-this)))
(add-hook 'go-mode-hook #'subword-mode)
(put 'dired-find-alternate-file 'disabled nil)
(use-package corfu)
