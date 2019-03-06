(require 'cl)

;; add whatever packages you want here
;;(defvar xfavor/packages '(
;;			  company
;;			  monokai-theme
;;			  hungry-delete
;;			  swiper  ;; better than smex, both show tips
;;			  counsel ;; complete swiper
;;			  smartparens
;;			  js2-mode
;;			  nodejs-repl
;;			  popwin
;;			  web-mode
;;			  js2-refactor
;;			  expand-region
;;			  iedit
;;			  org-pomodoro
;;			  helm-ag
;;			  auto-yasnippet
;;			  evil
;;			  evil-leader
;;			  window-numbering
;;			  evil-surround
;;			  evil-nerd-commenter
;;			  which-key
;;			  pallet
;;			  ) "Default packages")
;;
;;(setq package-selected-packages xfavor/packages)
;;
;;(defun xfavor/packages-installed-p ()
;;  (loop for pkg in xfavor/packages
;;	when (not (package-installed-p pkg)) do (return nil)
;;	finally (return t)))
;;
;;(unless (xfavor/packages-installed-p)
;;  (message "%s" "Refreshing package database...")
;;  (package-refresh-contents)
;;  (dolist (pkg xfavor/packages)
;;    (when (not (package-installed-p pkg))
;;      (package-install pkg))))


;; global completion
(global-company-mode t)

;; load monokai theme
(load-theme 'monokai t)


;; hungry delete
(require 'hungry-delete)
(global-hungry-delete-mode)


;; config for swiper, show tips in a list
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)


(require 'smartparens-config)
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

;; config js2-mode for js files
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode)
	 ("\\.html\\'" . web-mode))
       auto-mode-alist))

;; config for web mode
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )

(add-hook 'web-mode-hook 'my-web-mode-indent-setup)

(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
	(setq js-indent-level (if (= js-indent-level 2) 4 2))
	(setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
	     (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
	     (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))



;; config for js2-refactor
(add-hook 'js2-mode #'js2-refactor-mode)



;; easily close extral window
(require 'popwin)
(popwin-mode t)

(require 'org-pomodoro)

;;(global-flycheck-mode t)
(add-hook 'js2-mode-hook 'flycheck-mode)

(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

(require 'evil)
(evil-mode 1)
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)

;;(require 'evil-leader)
(global-evil-leader-mode)

(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "0" 'select-window-0
  "1" 'select-window-1
  "2" 'select-window-2
  "3" 'select-window-3
  "w/" 'split-window-right
  "w-" 'split-window-below
  ":" 'counsel-M-x
  "wm" 'delete-other-windows)

(window-numbering-mode 1)

(require 'evil-leader)
(global-evil-surround-mode 1)

(define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(evilnc-default-hotkeys)

(dolist (mode '(ag-mode
		flycheck-error-list-mode
		git-rebase-mode))
  (add-to-list 'evil-emacs-state-modes mode))

(add-hook 'occur-mode-hook
	  (lambda ()
	    (evil-add-hjkl-bindings occur-mode-map 'emacs
	      (kbd "/")       'evil-search-forward
	      (kbd "n")       'evil-search-next
	      (kbd "N")       'evil-search-previous
	      (kbd "C-d")     'evil-scroll-down
	      (kbd "C-u")     'evil-scroll-up
	      )))

(which-key-mode 1)
(setq which-key-side-window-location 'right)

(add-hook 'python-mode-hook
	  (lambda()
	    (set (make-local-variable 'company-backends  '((company-anaconda company-dabbrev-code) company-dabbrev)))))


(provide 'init-packages)
