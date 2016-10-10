;;package
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;===============
; jedi (under package.el)
;===============
(require 'epc)
(require 'auto-complete-config)
(require 'python)

;;;;; PYTHONPATH auto-complete ;;;;;
(setenv "PYTHONPATH" "/usr/local/lib/python2.7/site-packages")
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;;Thema
(load-theme 'misterioso t)

;; ------------
;;###general###
;; ------------


;;Don't make backupfile
;;*.~
(setq make-backup-files nil)
;;.#*
(setq auto-save-default nil)

;;language
(set-language-environment 'Japanese)
;;font
(prefer-coding-system 'utf-8)
;;window (general translate[%])
(set-frame-parameter (selected-frame) 'alpha'(80 80))
;;window
(if window-system (progn
  (setq initial-frame-alist '((width . 100) (height . 60) (top . 50)))
  (set-background-color "Black")
  (set-foreground-color "White")
  (set-cursor-color "Gray")
))
;;culum number
(global-linum-mode t)
;;menu bar/ tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)
;;parem
(show-paren-mode 1)
;;row
(setq-default show-trailing-whitespace t)
;;position
(column-number-mode t)
;(line-number-mode t)
;;Tab
;;auto indent
(add-hook 'python-mode-hook' (lambda ()
			       (define-key python-mode-map "\C-m" newline-and-indent)))
;;tab wide
(add-hook 'python-mode-hook
    '(lambda ()
        (setq python-indent 4)
        (setq indent-tabs-mod nil)
        (define-key (current-local-map) "\C-h" 'python-backspace)
    ))(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;;1row 80words
(add-hook 'python-mode-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))))

;;shift
1(setq pc-select-selection-keys-only t)
(pc-selection-mode 1)
;;font
(if (eq window-system 'mac) (require 'carbon-font))
(fixed-width-set-fontset "hirakaku_w3" 10)
(setq fixed-width-rescale nil)

;;Thema
(M-x customize-themes)
(set-face-background 'default "#303030")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)

;;----------------------------

;;YaTeX
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/yatex")
