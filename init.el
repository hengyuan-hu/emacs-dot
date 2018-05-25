(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))


;; load solarized color theme
(add-to-list 'load-path "~/.emacs.d/emacs-color-theme-solarized-master/")
(require 'color-theme)
(require 'color-theme-solarized)
(color-theme-initialize)
(setq frame-background-mode 'dark)
(load-theme 'solarized t)

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (let ((mode (if (display-graphic-p frame) 'light 'dark)))
              (set-frame-parameter frame 'background-mode mode)
              (set-terminal-parameter frame 'background-mode mode))
            (enable-theme 'solarized)))


(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
;; (require 'mouse)
;; (xterm-mouse-mode t)
;; (defun track-mouse (e))
;; (require 'mwheel)
;; (mouse-wheel-mode t)
;; (global-linum-mode t)
;; (setq-default indent-tabs-mode nil)

;; google cc model
(add-to-list 'load-path "~/.emacs.d/google-code-style/")
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)

(add-to-list 'load-path "~/.emacs.d/lua-mode/")
(require 'lua-mode)


(setq default-tab-width 4)
(setq backup-inhibited t)
(setq column-number-mode t)


(global-set-key (kbd "C-n") (lambda () (interactive) (forward-line 5)))
(global-set-key (kbd "C-p")	(lambda () (interactive) (forward-line -5)))


(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))
(add-hook 'before-save-hook 'whitespace-cleanup)


(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  )

(setq-default indent-tabs-mode nil)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (lua-mode google-c-style solarized-theme sml-mode s haskell-mode color-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq lua-indent-level 2)
