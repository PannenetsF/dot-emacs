;; (use-package consult
;;   ;;   :bind (;; C-c bindings in `mode-specific-map'
;;   ;;          ("C-c M-x" . consult-mode-command)
;;   ;;          ("C-c h"   . consult-history)
;;   ;;          ("C-c k"   . consult-kmacro)
;;   ;;          ("C-c m"   . consult-man)
;;   ;;          ("C-c i"   . consult-info)
;;   ;;          ("C-c r"   . consult-ripgrep)
;;   ;;          ("C-c T"   . consult-theme)
;;   ;;          ("C-."     . consult-imenu)

;;   ;;          ("C-c c e" . consult-colors-emacs)
;;   ;;          ("C-c c w" . consult-colors-web)
;;   ;;          ("C-c c f" . describe-face)
;;   ;;          ("C-c c l" . find-library)
;;   ;;          ("C-c c t" . consult-theme)

;;   ;;          ([remap Info-search]        . consult-info)
;;   ;;          ([remap isearch-forward]    . consult-line)
;;   ;;          ([remap recentf-open-files] . consult-recent-file)

;;   ;;          ;; C-x bindings in `ctl-x-map'
;;   ;;          ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
;;   ;;          ("C-x b"   . consult-buffer)              ;; orig. switch-to-buffer
;;   ;;          ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
;;   ;;          ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
;;   ;;          ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
;;   ;;          ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
;;   ;;          ;; Custom M-# bindings for fast register access
;;   ;;          ("M-#"     . consult-register-load)
;;   ;;          ("M-'"     . consult-register-store)        ;; orig. abbrev-prefix-mark (unrelated)
;;   ;;          ("C-M-#"   . consult-register)
;;   ;;          ;; Other custom bindings
;;   ;;          ("M-y"     . consult-yank-pop)                ;; orig. yank-pop
;;   ;;          ;; M-g bindings in `goto-map'
;;   ;;          ("M-g e"   . consult-compile-error)
;;   ;;          ("M-g f"   . consult-flymake)               ;; Alternative: consult-flycheck
;;   ;;          ("M-g g"   . consult-goto-line)             ;; orig. goto-line
;;   ;;          ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
;;   ;;          ("M-g o"   . consult-outline)               ;; Alternative: consult-org-heading
;;   ;;          ("M-g m"   . consult-mark)
;;   ;;          ("M-g k"   . consult-global-mark)
;;   ;;          ("M-g i"   . consult-imenu)
;;   ;;          ("M-g I"   . consult-imenu-multi)
;;   ;;          ;; M-s bindings in `search-map'
;;   ;;          ("M-s d"   . consult-find)
;;   ;;          ("M-s D"   . consult-locate)
;;   ;;          ("M-s g"   . consult-grep)
;;   ;;          ("M-s G"   . consult-git-grep)
;;   ;;          ("M-s r"   . consult-ripgrep)
;;   ;;          ("M-s l"   . consult-line)
;;   ;;          ("M-s L"   . consult-line-multi)
;;   ;;          ("M-s k"   . consult-keep-lines)
;;   ;;          ("M-s u"   . consult-focus-lines)
;;   ;;          ;; Isearch integration
;;   ;;          ("M-s e"   . consult-isearch-history)
;;   ;;          :map isearch-mode-map
;;   ;;          ("M-e"     . consult-isearch-history)       ;; orig. isearch-edit-string
;;   ;;          ("M-s e"   . consult-isearch-history)       ;; orig. isearch-edit-string
;;   ;;          ("M-s l"   . consult-line)                  ;; needed by consult-line to detect isearch
;;   ;;          ("M-s L"   . consult-line-multi)            ;; needed by consult-line to detect isearch

;;   ;;          ;; Minibuffer history
;;   ;;          :map minibuffer-local-map
;;   ;;          ("M-s" . consult-history)                 ;; orig. next-matching-history-element
;;   ;;          ("M-r" . consult-history))                ;; orig. previous-matching-history-element

;;   :hook (completion-list-mode . consult-preview-at-point-mode)
;;   :init
;;   (setq register-preview-delay 0.5
;;         register-preview-function #'consult-register-format)

;;   (advice-add #'register-preview :override #'consult-register-window)

;;   (with-eval-after-load 'xref
;;     (setq xref-show-xrefs-function #'consult-xref
;;           xref-show-definitions-function #'consult-xref))

;;   (defvar consult-colors-history nil
;;     "History for `consult-colors-emacs' and `consult-colors-web'.")

;;   (autoload 'list-colors-duplicates "facemenu")
;;   (autoload 'consult--read "consult")

;;   (defun consult-colors-emacs (color)
;;     "Show a list of all supported colors for a particular frame.

;; You can insert the name (default), or insert or kill the hexadecimal or RGB
;; value of the selected COLOR."
;;     (interactive
;;      (list (consult--read (list-colors-duplicates (defined-colors))
;;                           :prompt "Emacs color: "
;;                           :require-match t
;;                           :category 'color
;;                           :history '(:input consult-colors-history))))
;;     (insert color))
;;   (defun consult-colors--web-list nil
;;     "Return list of CSS colors for `counsult-colors-web'."
;;     (require 'shr-color)
;;     (sort (mapcar #'downcase (mapcar #'car shr-color-html-colors-alist)) #'string-lessp))

;;   (defun consult-colors-web (color)
;;     "Show a list of all CSS colors.\

;; You can insert the name (default), or insert or kill the hexadecimal or RGB
;; value of the selected COLOR."
;;     (interactive
;;      (list (consult--read (consult-colors--web-list)
;;                           :prompt "Color: "
;;                           :require-match t
;;                           :category 'color
;;                           :history '(:input consult-colors-history))))
;;     (insert color))
;;   :config
;;   (setq consult-preview-key nil)
;;   (consult-customize
;;    consult-line consult-line-multi :preview-key 'any
;;    consult-buffer consult-recent-file consult-theme :preview-key '(:debounce 1.0 any)
;;    consult-goto-line :preview-key '(:debounce 0.5 any)
;;    consult-ripgrep consult-git-grep consult-grep
;;    :initial (selected-region-or-symbol-at-point)
;;    :preview-key '(:debounce 0.5 any))
;;   (setq consult-narrow-key "<") ;; "C-+"
;;   (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help))

;; (use-package consult-flyspell
;;   :bind ("M-g s" . consult-flyspell))

;; (use-package consult-yasnippet
;;   :bind ("M-g y" . consult-yasnippet))


;; ;; Auto completion
;; (use-package corfu
;;   :custom
;;   (corfu-auto t)
;;   (corfu-auto-prefix 2)
;;   (corfu-preview-current nil)
;;   (corfu-auto-delay 0.2)
;;   (corfu-popupinfo-delay '(0.4 . 0.2))
;;   :custom-face
;;   (corfu-border ((t (:inherit region :background unspecified))))
;;   :bind ("M-/" . completion-at-point)
;;   :hook ((after-init . global-corfu-mode)
;;          (global-corfu-mode . corfu-popupinfo-mode)))

(add-to-list 'load-path (expand-file-name "lsp-bridge/"))

(use-package yasnippet
  :diminish yas-minor-mode
  :hook (after-init . yas-global-mode))


(use-package markdown-mode
  :ensure t)

(use-package python)
(require 'yasnippet)
(require 'markdown-mode)
(yas-global-mode 1)
(require 'lsp-bridge)
(global-lsp-bridge-mode)
(setq lsp-bridge-python-lsp-server 'pylsp)
(setq lsp-bridge-python-command "python")


(provide 'init-edition)
