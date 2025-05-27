;; entry of Emacs configuration

;; For accelerated startup, we set the garbage collection threshold to a high value
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook #'(lambda ()
                               (setq gc-cons-threshold
				     4000000)))


;; Set the config directory
(defun private/emacs-config-dir ()
  (concat (file-name-directory load-file-name)))
(add-to-list 'load-path (concat (private/emacs-config-dir) "lisp/"))

;; Set the cache directory
(setq private/cache-directory
      (expand-file-name ".cache/" (private/emacs-config-dir)))

;; Check the system type
(setq private/system-is-mac (eq system-type 'darwin))
(setq private/system-is-linux (eq system-type 'gnu/linux))
(setq private/system-is-linux (eq system-type 'windows-nt))

(require 'init-package)

;; Load the custom file if it exists, also write to it
(setq custom-file (expand-file-name "custom.el" (private/emacs-config-dir)))
(when (file-exists-p custom-file)
  (load custom-file))