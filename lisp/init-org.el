(use-package org
  :defer t
  :init
  (setq
   org-list-allow-alphabetical t
   org-use-property-inheritance t
   org-fold-catch-invisible-edits 'smart
   org-log-done 'time            )
  (custom-theme-set-faces
   'user
   `(org-level-4 ((t (:height 0.9))))
   `(org-level-3 ((t (:height 1.15 :inherit nano-popout))))
   `(org-level-2 ((t (:height 1.3 :inherit nano-popout))))
   `(org-level-1 ((t (:height 1.45 :inherit nano-salient))))
   `(org-document-title ((t (:height 1.7 :underline t :inherit nano-salient)))))
  )

(use-package org-modern)
(with-eval-after-load 'org (global-org-modern-mode))

(setq org-modern-fold-stars '(("▶" . "▼") ("▷" . "▽") ("⏵" . "⏷") ("▹" . "▿") ("▸" . "▾")))


(setq
 org-auto-align-tags nil
 org-tags-column 0
 org-fold-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t

 ;; Agenda styling
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (800 1000 1200 1400 1600 1800 2000)
   " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string
 "⭠ now ─────────────────────────────────────────────────")



(global-org-modern-mode)



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
