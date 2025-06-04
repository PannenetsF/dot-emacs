(use-package counsel
  :ensure t)

(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (counsel-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq search-default-mode #'char-fold-to-regexp)
  (setq ivy-count-format "(%d/%d) ")
  )


(use-package nerd-icons)

(use-package neotree
  :config
  (if (display-graphic-p)
      (progn
	;; if graphic
	(setq neo-theme 'nerd-icons))
    ;; else (optional)
    (setq neo-theme 'icons))
  )


(use-package vterm
  :ensure t
  )

(provide 'init-navigation)
