;; UI configuration for Emacs

(blink-cursor-mode -1) ;; Disable blinking cursor
(scroll-bar-mode -1) ;; Disable scroll bar
(tool-bar-mode -1) ;; Disable tool bar
(tooltip-mode -1) ;; Disable tooltips

(setq mouse-highlight nil)
(setq scroll-conservatively 0)
(setq column-number-mode t)
(setq-default cursor-in-non-selected-windows nil)
(setq x-underline-at-descent-line t)
(setq x-stretch-cursor t)
(setq inhibit-startup-screen t)

;; disable beep
(setq ring-bell-function 'ignore)

(add-to-list 'default-frame-alist '(undecorated-round . t))

(use-package catppuccin-theme
  :ensure t)
(setq catppuccin-flavor 'mocha)
(load-theme 'catppuccin :no-confirm)

(provide 'init-ui)
