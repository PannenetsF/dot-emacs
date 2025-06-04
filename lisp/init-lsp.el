(add-to-list 'load-path (system/get-package-under-emacs-config "lsp-bridge/"))

(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.0)
  (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (setq company-selection-wrap-around t)
  (setq company-transformers '(company-sort-by-occurrence))) ;

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :hook (after-init . yas-global-mode)
  :config
  (yas-reload-all)
  ;; add company-yasnippet to company-backends
  (defun company-mode/backend-with-yas (backend)
    (if (and (listp backend) (member 'company-yasnippet backend))
	backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  ;; unbind <TAB> completion
  (define-key yas-minor-mode-map [(tab)]        nil)
  (define-key yas-minor-mode-map (kbd "TAB")    nil)
  (define-key yas-minor-mode-map (kbd "<tab>")  nil)
  :bind
  (:map yas-minor-mode-map ("S-<tab>" . yas-expand)))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)


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
