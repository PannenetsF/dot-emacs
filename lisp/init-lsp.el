(add-to-list 'load-path (system/get-package-under-emacs-config "lsp-bridge/"))

(use-package yasnippet
  :diminish yas-minor-mode
  :hook (after-init . yas-global-mode))


(use-package markdown-mode
  :ensure t)

(use-package python)

(require 'yasnippet)
(require 'markdown-mode)

(yas-global-mode 1)

(require 'lsp-bridge)
(global-lsp-bridge-mode)

(setq lsp-bridge-python-lsp-server 'pylsp)
(setq lsp-bridge-python-command "python")

(general-evil-define-key 'normal lsp-bridge-mode-map
			 "ga" 'xref-find-apropos
			 "gd" 'lsp-bridge-find-def
			 "gD" 'lsp-bridge-find-def-other-window
			 "K"  'lsp-bridge-lookup-documentation
			 "gj" 'lsp-bridge-diagnostic-jump-next
			 "gk" 'lsp-bridge-diagnostic-jump-prev
			 "gl" 'lsp-bridge-diagnostic-list
			 "gi" 'lsp-bridge-find-impl
			 "gI" 'lsp-bridge-find-impl-other-window
			 "gr" 'lsp-bridge-find-references
			 "gR" 'lsp-bridge-rename

			 )

(provide 'init-lsp)
