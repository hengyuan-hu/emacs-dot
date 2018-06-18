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


;; Grateful thanks are given to Brian Marick (@marick) for helping me
;; write these. I got the original idea while reading through
;; http://xahlee.org/emacs/elisp_idioms.html, but couldn't work out
;; the elisp regexes. Brian Marick (@marick) stepped in and helped. He
;; took my tortured and broken camelcase-region and turned it into
;; something that actually worked. I then created
;; camelcase-word-or-region. I then wrote the snakecase versions but I
;; see now that all I did was copy the camelcase defuns over and,
;; meaning to go back and finish them Real Soon Now, forgot all about
;; them. I've had a quick look (2011-02-27) but elisp regexes are
;; still pretty slippery to me, so I have decided to err on the side
;; of "Showing This To Jim Weirich" (beacuse he expressed interest in
;; the camelcase defun) and have just marked the offending code and
;; left it unfixed.
;;
;; Help me, Obi-Wan Weirichobi, you're my only hope!
;; ----------------------------------------------------------------------
;; camelcase-region Given a region of text in snake_case format,
;; changes it to camelCase.
(defun camelcase-region (start end)
  "Changes region from snake_case to camelCase"
  (interactive "r")
  (save-restriction (narrow-to-region start end)
                    (goto-char (point-min))
                    (while (re-search-forward "_\\(.\\)" nil t)
                      (replace-match (upcase (match-string 1))))))

;; ----------------------------------------------------------------------
;; cadged largely from http://xahlee.org/emacs/elisp_idioms.html:
;;
(defun camelcase-word-or-region ()
  "Changes word or region from snake_case to camelCase"
  (interactive)
  (let (pos1 pos2 bds)
    (if (and transient-mark-mode mark-active)
        (setq pos1 (region-beginning) pos2 (region-end))
      (progn
        (setq bds (bounds-of-thing-at-point 'symbol))
        (setq pos1 (car bds) pos2 (cdr bds))))
    (camelcase-region pos1 pos2)))

;; ----------------------------------------------------------------------
;; snakecase-region
;; Given a region of text in camelCase format, changes it to snake_case.
;;
;; BUG: This is actually just a repeat of camelcase-region!
(defun snakecase-region (start end)
  "Changes region from camelCase to snake_case"
  (interactive "r")
  (save-restriction (narrow-to-region start end)
                    (goto-char (point-min))
                    (while (re-search-forward "_\\(.\\)" nil t)
                      (replace-match (upcase (match-string 1))))))

;; ----------------------------------------------------------------------
;; Given a region of text in camelCase format, changes it to snake_case.
(defun snakecase-word-or-region ()
  "Changes word or region from camelCase to snake_case"
  (interactive)
  (let (pos1 pos2 bds)
    (if (and transient-mark-mode mark-active)
        (setq pos1 (region-beginning) pos2 (region-end))
      (progn
        (setq bds (bounds-of-thing-at-point 'symbol))
        (setq pos1 (car bds) pos2 (cdr bds))))
    (snakecase-region pos1 pos2)))

;; (global-set-key (kbd "C-c C--") 'camelcase-word-or-region)
;; (global-set-key (kbd "C-c C-_") 'snakecase-word-or-region)
