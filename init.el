;; entry of Emacs configuration

;; For accelerated startup, we set the garbage collection threshold to a high value
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook #'(lambda ()
                               (setq gc-cons-threshold
				     4000000)))


;; Set the config directory
(defun system/emacs-config-dir ()
  (concat (file-name-directory load-file-name)))
(add-to-list 'load-path (expand-file-name "lisp/"))

;; Set the cache directory
(setq system/cache-directory
      (expand-file-name ".cache/"))

;; Check the system type
(setq system/is-mac (eq system-type 'darwin))
(setq system/is-linux (eq system-type 'gnu/linux))
(setq system/is-win (eq system-type 'windows-nt))

(require 'init-package)
(require 'init-ui)
(require 'init-evil)
(require 'init-edition)
(require 'post-config)

;; Load the custom file if it exists, also write to it
(setq custom-file (expand-file-name "custom.el" (system/emacs-config-dir)))
(when (file-exists-p custom-file)
  (load custom-file))