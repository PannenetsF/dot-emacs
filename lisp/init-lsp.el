(add-to-list 'load-path (expand-file-name "lsp-bridge/"))

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


(provide 'init-lsp)
