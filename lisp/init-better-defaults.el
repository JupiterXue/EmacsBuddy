;; turn off ring bell
(setq ring-bell-function 'ignore)

;; auto revert file
(global-auto-revert-mode t)


;; show line num
(global-linum-mode t)

;; show short shortcut
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ;; signature, print xfavor and press <space>
					    ("8zl" "xfavor")
					    ;; emacs regex
					    ("8ms" "Microsoft")
					    ))

(setq make-backup-files nil)
(setq auto-save-default nil)

;; config recentf,press <C-x C-r> to open recentf
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; [H] pair highlight when curosr in pair
;; (define-advice show-paren-function (:around (fn) fix-show-paren-function)
;; "Highlight enclosing parens."
;; (cond ((looking-at-p "\\s(") (funcall fn))
;; (t (save-excursion
;; (ignore-errors (backward-up-list))
;; (funcall fn)))))

(defadvice show-paren-function (around fix-show-paren-function activate)
  (cond ((looking-at-p "\\s(") ad-dolist)
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     ad-do-it)))
  )

;; highlight show match parents
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; delete selected word
(delete-selection-mode t)

(defun indent-buffer ()
  "Indent the current visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

;; cursor back origin palce after working in another window
(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indented selected region."))
      (progn
	(indent-buffer)
	(message "Indented buffer.")))))

(setq hippie-expand-try-functions-list '(try-expand-dabbrev
					 try-expand-dabbrev-all-buffers
					 try-expand-dabbrev-from-kill
					 try-complete-file-name-partially
					 try-complete-file-name
					 try-expand-all-abbrevs
					 try-expand-list
					 try-expand-line
					 try-complete-lisp-symbol-partially
					 try-complete-lisp-symbol))

(fset 'yes-or-no-p 'y-or-n-p)

(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

(put 'dired-find-alternate-file 'disabled nil)

;; <C-x C-j> open current dir
(require 'dired-x)

(setq dired-dwim-target t)

(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; occur, scratch curosr selected variable
;; imporve occur-mode
;; dwin = do what i mean
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))

(global-set-key (kbd "M-s o") 'occur-dwim)

;; imenu, show all function name in current file
;; improve imenu
(defun js2-imenu-make-index ()
  (interactive)
  (save-excursion
    ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
    (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
			       ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
			       ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
			       ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
			       ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
			       ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
	  (lambda ()
	    (setq imenu-create-index-function 'js2-imenu-make-index)))

(global-set-key (kbd "M-s i") 'counsel-imenu)

(set-language-environment "UTF-8")

(provide 'init-better-defaults)
