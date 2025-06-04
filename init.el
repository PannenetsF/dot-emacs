;; entry of Emacs configuration

;; For accelerated startup, we set the garbage collection threshold to a high value
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook #'(lambda ()
                               (setq gc-cons-threshold
				     4000000)))


;; Set the config directory
(setq system/emacs-config-dir user-emacs-directory)
(add-to-list 'load-path (expand-file-name (concat system/emacs-config-dir "lisp/")))
(add-to-list 'load-path (expand-file-name (concat system/emacs-config-dir "lisp/user")))

(defun system/get-path-under-emacs-config (path)
  "Get the absolute path under the Emacs configuration directory."
  (expand-file-name (concat system/emacs-config-dir path)))

(defun system/get-package-under-emacs-config (path)
  "Get the absolute path under the Emacs configuration directory."
  (expand-file-name (concat system/emacs-config-dir (concat "packages/" path))))

;; Set the cache directory
(defconst system/cache-directory
  (system/get-path-under-emacs-config ".cache/")
  "The directory where Emacs cache files are stored.")

;; Check the system type
(defconst system/is-mac (eq system-type 'darwin)
  "Check if the system is macOS.")
(defconst system/is-linux (eq system-type 'gnu/linux)
  "Check if the system is Linux.")
(defconst system/is-win (eq system-type 'windows-nt)
  "Check if the system is Windows.")

;; exit if windows is detected
(when system/is-win
  (message "This configuration is not supported on Windows. Exiting...")
  (kill-emacs))

;; Set the user const
(defconst system/const-org-location
  (cond (system/is-mac "~/Documents/org")
	(system/is-linux "~/org")
	(t "~/org"))
  "The location of the org files.")

(defconst system/global-leader-prefix "SPC"
  "Global leader key prefix.")

(defconst system/local-leader-prefix ","
  "Local leader key prefix.")

(require 'init-package)
(require 'init-ui)
(require 'init-key)
(require 'init-evil)
(require 'init-navigation)
(require 'init-lsp)
(require 'init-org)
(require 'post-config)

;; Load the custom file if it exists, also write to it
(setq custom-file (system/get-path-under-emacs-config "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
