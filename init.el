;; entry of Emacs configuration

;; For accelerated startup, we set the garbage collection threshold to a high value
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook #'(lambda ()
                               (setq gc-cons-threshold
				     4000000)))


;; Set the config directory
(setq system/emacs-config-dir user-emacs-directory)
(add-to-list 'load-path (expand-file-name (concat system/emacs-config-dir "lisp/")))

(defun system/get-path-under-emacs-config (path)
  "Get the absolute path under the Emacs configuration directory."
  (expand-file-name (concat system/emacs-config-dir path)))

;; Set the cache directory
(setq system/cache-directory
      (system/get-path-under-emacs-config ".cache/"))

;; Check the system type
(setq system/is-mac (eq system-type 'darwin))
(setq system/is-linux (eq system-type 'gnu/linux))
(setq system/is-win (eq system-type 'windows-nt))

;; exit if windows is detected
(when system/is-win
  (message "This configuration is not supported on Windows. Exiting...")
  (kill-emacs))

;; Set the user const
(setq user/const-org-location
      (cond (system/is-mac "~/Documents/org")
	    (system/is-linux "~/org")
	    (t "~/org")))

(require 'init-package)
(require 'init-ui)
(require 'init-evil)
(require 'init-navigation)
(require 'init-lsp)
(require 'init-org)
(require 'post-config)

;; Load the custom file if it exists, also write to it
(setq custom-file (system/get-path-under-emacs-config "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
