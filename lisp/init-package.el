(package-initialize)

(setq package-enable-at-startup nil)
(setq package-archives '(("gnu"       . "https://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

(use-package exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(use-package general
  :config
  (general-create-definer system/global-leader-define
			  :states '(normal visual motion evilified)
			  :keymaps 'override
			  :prefix system/global-leader-prefix)
  (general-create-definer system/local-leader-define
			  :states '(normal visual motion evilified)
			  :keymaps 'override
			  :prefix system/local-leader-prefix)

  (general-create-definer system/set-leader-keys-for-mode
			  :prefix system/local-leader-prefix
			  :non-normal-prefix "M-m m"
			  :states '(motion insert emacs)))

(provide 'init-package)
