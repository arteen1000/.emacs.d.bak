(setopt inhibit-startup-screen t)
(setopt custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror 'nomessage)
(column-number-mode)
(setopt make-backup-files nil
				create-lockfiles nil)
(let ((auto-save-dir (expand-file-name "auto-save/" user-emacs-directory)))
	(make-directory auto-save-dir t)
	(add-to-list
	 'auto-save-file-name-transforms
	 `(".*" ,auto-save-dir t)))
(setopt use-short-answers t)
(setopt scroll-error-top-bottom t)
(winner-mode)
(windmove-default-keybindings 'control)
(windmove-delete-default-keybindings 'none 'meta)
(windmove-swap-states-default-keybindings '(shift control))
(add-to-list 'load-path "~/.emacs.d/lisp")
(setopt dired-omit-files "\\`\\.[^.].*\\|\\`\\.\\..+")
(with-eval-after-load 'dired
  (keymap-set dired-mode-map "b" #'dired-create-empty-file)
  (keymap-set dired-mode-map "e" #'dired-omit-mode))
(setopt display-buffer-alist
      '(("\\*Help\\*" display-buffer-same-window)))
(defun terminal ()
  (interactive)
  (call-process "open" nil 0 nil "-a" "Terminal.app"
								(expand-file-name default-directory)))
(setq-default tab-width 2)
(require 'package)
(setopt package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setopt use-package-always-ensure t)
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
(setopt which-key-allow-multiple-replacements t)
(push '((".*A-.*" . nil) . t) which-key-replacement-alist)
(push '((".*f[0-9]?[0-9].*" . nil) . t) which-key-replacement-alist)
(use-package magit)
(setopt scroll-preserve-screen-position t)
(recentf-mode)
(savehist-mode)
(use-package eglot
	:hook ((c++-mode . eglot-ensure)
				 (go-mode . eglot-ensure)))
(use-package multiple-cursors
  :bind (("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-c C-<"     . mc/mark-all-like-this)))
(add-hook 'go-mode-hook #'subword-mode)
(use-package corfu
	:init
	;; some extra stuff exists around pop-up docs, check michael's
	(global-corfu-mode)
	:bind
	(:map corfu-map
				("SPC" . corfu-insert-separator)
				("TAB" . corfu-next)
        ("S-TAB" . corfu-previous))
	:custom
	(tab-always-indent 'complete))
(setopt read-extended-command-predicate #'command-completion-default-include-p)
(use-package orderless
  :custom
  (completion-styles '(orderless basic partial-completion))
  (completion-category-overrides '((file (styles partial-completion))
																	 ;; avoid override of default
																	 (calendar-month (display-sort-function . identity))))
	(completion-category-defaults nil))
(use-package vertico
	:init
	(vertico-mode)
	(vertico-multiform-mode)
	:config
	(add-to-list 'vertico-multiform-categories
							 '(buffer (vertico-sort-function . nil))))
(use-package marginalia
	;; can add to completions if i find i need it
	:init (marginalia-mode))
(use-package consult
  :bind (("C-x b"   . consult-buffer)
         ("M-y"     . consult-yank-pop)
         ("M-g i"   . consult-imenu)
         ("M-g m"   . consult-imenu-multi)
         ("M-g g"   . consult-goto-line)
         ("M-g f"   . consult-flymake)
				 ("M-s f" . consult-fd)
				 ("M-s l" . consult-line) 
				 ("M-s r" . consult-ripgrep))
  :custom
  (xref-show-xrefs-function #'consult-xref)
  (xref-show-definitions-function #'consult-xref))
(use-package vundo)
(use-package lsp-mode)
