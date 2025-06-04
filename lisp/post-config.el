;; used as tmux prefix key
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "M-y") 'yank-pop)
(global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
(global-set-key [mouse-5] (lambda () (interactive) (scroll-up   1)))

;; Use ESC as universal get me out of here command
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

(when system/is-mac
  (setq ns-command-modifier       'super
        ns-option-modifier        'meta)
  (global-set-key [(super a)] 'mark-whole-buffer)
  (global-set-key [(super v)] 'yank)
  (global-set-key [(super c)] 'kill-ring-save)
  (global-set-key [(super s)] 'save-buffer)
  (global-set-key [(super z)] 'undo))

;; Fonts
(defun font-installed-p (font-name)
  "Check if font with FONT-NAME is available."
  (find-font (font-spec :name font-name)))


(defun centaur-setup-fonts ()
  "Setup fonts."
  (when (display-graphic-p)
    ;; Set default font
    (cl-loop for font in '("JetBrainsMono Nerd Font Mono" "Fira Code" "Jetbrains Mono"
                           "SF Mono" "Hack" "Source Code Pro" "Menlo"
                           "Monaco" "DejaVu Sans Mono" "Consolas")
             when (font-installed-p font)
             return (set-face-attribute 'default nil
                                        :family font
                                        :height (cond (system/is-mac 180)
                                                      (system/is-win 180)
                                                      (t 100))))

    ;; Set mode-line font
    ;; (cl-loop for font in '("Menlo" "SF Pro Display" "Helvetica")
    ;;          when (font-installed-p font)
    ;;          return (progn
    ;;                   (set-face-attribute 'mode-line nil :family font :height 120)
    ;;                   (when (facep 'mode-line-active)
    ;;                     (set-face-attribute 'mode-line-active nil :family font :height 120))
    ;;                   (set-face-attribute 'mode-line-inactive nil :family font :height 120)))

    ;; Specify font for all unicode characters
    (cl-loop for font in '("Apple Symbols" "Segoe UI Symbol" "Symbola" "Symbol")
             when (font-installed-p font)
             return (set-fontset-font t 'symbol (font-spec :family font) nil 'prepend))

    ;; Emoji
    (cl-loop for font in '("Noto Color Emoji" "Apple Color Emoji" "Segoe UI Emoji")
             when (font-installed-p font)
             return (set-fontset-font t
                                      (if (< emacs-major-version 28)'symbol 'emoji)
                                      (font-spec :family font) nil 'prepend))

    ;; Specify font for Chinese characters
    (cl-loop for font in '("LXGW WenKai Mono" "PingFang SC" "Microsoft Yahei UI" "Simhei")
             when (font-installed-p font)
             return (progn
                      (setq face-font-rescale-alist `((,font . 1.3)))
                      (set-fontset-font t 'han (font-spec :family font))))))

(centaur-setup-fonts)
(add-hook 'window-setup-hook #'centaur-setup-fonts)
(add-hook 'server-after-make-frame-hook #'centaur-setup-fonts)

(require 'init-org-noter)


(
 system/global-leader-define
 "" nil

 "SPC" 'execute-extended-command

 "u" 'universal-argument

 ;; File
 "ff" 'find-file
 "fr" (lambda () (interactive) (recentf-open-files))
 "fel" 'find-library
 "fS" 'evil-write-all
 "fs" 'save-buffer
 "fvd" 'add-dir-local-variable
 "fvf" 'add-file-local-variable
 "fvp" 'add-file-local-variable-prop-line

 ;; Buffer
 "bb" 'switch-to-buffer
 "bn" 'next-buffer
 "bp" 'previous-buffer
 "bd" 'kill-this-buffer
 "bw" 'read-only-mode
 ;; split
 "bs" 'split-window-below
 "bv" 'split-window-right
 ;; close to left
 ;; close to write

 "TAB" (lambda () (interactive) (switch-to-buffer (other-buffer (current-buffer) t)))

 ;; Jumping
 "sj" 'imenu

 ;; Help
 "h" (general-simulate-keys "<f1>")

 ;; Themes
 "Ts"  'load-theme

 ;; Window Management
 "wd" 'delete-window
 "wm" 'delete-other-windows
 "wf" 'make-frame
 "wH" 'evil-window-move-far-left
 "wh" 'evil-window-left
 "wJ" 'evil-window-move-very-bottom
 "wj" 'evil-window-down
 "wK" 'evil-window-move-very-top
 "wk" 'evil-window-up
 "wL" 'evil-window-move-far-right
 "wl" 'evil-window-right
 "wo" 'other-frame
 "ws" 'split-window-below
 "wS" 'split-window-below-and-focus
 "wv" 'split-window-right
 "wV" 'split-window-right-and-focus
 "ww" 'other-window
 "w=" 'balance-windows

 "qf" 'delete-frame
 "qq" 'kill-emacs)

(provide 'post-config)
