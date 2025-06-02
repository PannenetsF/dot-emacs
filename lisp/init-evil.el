(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  ;; if general is installed , use     (general-evil-setup)
  (when (require 'general nil t)
    (general-evil-setup))
  :config
  (evil-mode 1)
  )

(require 'evil)

(provide 'init-evil)
