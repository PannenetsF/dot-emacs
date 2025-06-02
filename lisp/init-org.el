(use-package org
  :ensure org-plus-contrib
  :defer t
  :config
  (general-mmap
   :keymaps 'org-mode-map
   "RET" 'org-open-at-point)
  (system/set-leader-keys-for-mode
   :keymaps 'org-mode-map
   "cc" 'org-clock-cancel
   "ci" 'org-clock-in
   "co" 'org-clock-out
   "cr" 'org-resolve-clocks
   "dd" 'org-deadline
   "ds" 'org-schedule
   "dt" 'org-time-stamp
   "dT" 'org-time-stamp-inactive

   "e" 'org-export-dispatch

   "a" 'org-agenda

   "t" 'org-todo

   ;; More cycling options (timestamps, headlines, items, properties)
   "L" 'org-shiftright
   "H" 'org-shiftleft
   "J" 'org-shiftdown
   "K" 'org-shiftup

   ;; Change between TODO sets
   "C-S-l" 'org-shiftcontrolright
   "C-S-h" 'org-shiftcontrolleft
   "C-S-j" 'org-shiftcontroldown
   "C-S-k" 'org-shiftcontrolup

   ;; Subtree editing
   "sa" 'org-archive-subtree
   "sb" (lambda () (interactive) (org-tree-to-indirect-buffer 4))
   "sh" 'org-promote-subtree
   "sj" 'org-move-subtree-down
   "sk" 'org-move-subtree-up
   "sl" 'org-demote-subtree
   "sn" 'org-narrow-to-subtree
   "sN" 'widen
   "sr" 'org-refile
   "ss" 'org-sparse-tree
   "sS" 'org-sort

   ;; Multi-purpose keys
   "'" 'org-ctrl-c-ctrl-c
   "*" 'org-ctrl-c-star
   "RET" 'org-ctrl-c-ret
   "-" 'org-ctrl-c-minus
   "#" 'org-update-statistics-cookies
   ;; attachments
   "A" 'org-attach
   ;; insertion
   "id" 'org-insert-drawer
   "ie" 'org-set-effort
   "if" 'org-footnote-new
   "ih" 'org-insert-heading
   "iH" 'org-insert-heading-after-current
   "iK" 'spacemacs/insert-keybinding-org
   "il" 'org-insert-link
   "ip" 'org-set-property
   "is" 'org-insert-subheading
   "it" 'org-set-tags)
  (system/global-leader-define
   "aa" 'org-agenda-list
   "oa" 'org-agenda
   "ol" 'org-store-link
   "oL" 'org-insert-link-global
   "ob" 'org-iswitchb
   "os" 'org-save-all-org-buffers
   "og" 'org-clock-goto
   "oo" 'org-clock-out
   "oc" 'org-capture
   "oC" 'org-capture-goto-last-stored
   "oj" '(lambda () (interactive) (org-refile '(4)))
   "oJ" 'org-refile-goto-last-stored))

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
  )

(require 'org-zotxt-noter)

(provide 'init-org)
