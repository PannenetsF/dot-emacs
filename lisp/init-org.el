(use-package org
  :defer t
  :init
  (general-mmap
   :keymaps 'org-mode-map
   "RET" 'org-open-at-point)
  )

(use-package evil-org
  :commands
  (evil-org-define-eol-command
   evil-org-define-bol-command)
  :ensure t
  :init
  (progn
    (setq evil-org-special-o/O nil)
    (add-hook 'org-mode-hook 'evil-org-mode)
    (add-hook 'evil-org-mode-hook
              (lambda ()
                (evil-org-set-key-theme))))
  :general
  (general-mmap
   :keymaps 'org-mode-map
   "C-<return>" (evil-org-define-eol-command org-insert-heading-respect-content)
   "C-S-<return>" (evil-org-define-eol-command org-insert-todo-heading-respect-content)
   "M-<return>" (evil-org-define-eol-command org-meta-return)
   "M-S-<return>" (evil-org-define-eol-command org-insert-todo-heading)))


(use-package org-noter
  :ensure t)


(use-package zotxt
  :ensure t
  :init (progn
	  (add-hook 'org-mode-hook 'org-zotxt-mode)
	  )
  )

(require 'org-zotxt-noter)

(provide 'init-org)
