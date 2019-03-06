(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-varibale)

;; config two pair
;;(electric-pair-mode t)

;; define a function, press F1 quickly open your config file
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/lisp/init-packages.el"))
(global-set-key (kbd "<f1>") 'open-my-init-file)

;; press F2 quickly access to org_learn.org
(defun open-org-learn-file()
  (interactive)
  (find-file "~/Project/EmacsProject_Linux/base/org_learn.org"))
(global-set-key (kbd "<f2>") 'open-org-learn-file)

(global-set-key "\C-x\ \C-r" 'recentf-open-files)
;; <M-x> eval-buffer ,eval whole file

(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;; (global-set-key (kbd "C-c p f") 'counsel-git)

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

(global-set-key (kbd "M-/") 'hippie-expand)

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; ---------------------------org---------------------------------------
(global-set-key (kbd "C-c a") 'org-agenda)

;; r aka remeber
(global-set-key (kbd "C-c r") 'org-capture)

;; ---------------------------------------------------------------------

(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)

(js2r-add-keybindings-with-prefix "C-c C-m")

(global-set-key (kbd "M-s i") 'counsel-imenu)

;; config expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

;; config iedit
;; you can edit more same word at once
(global-set-key (kbd "M-s e") 'iedit-mode)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; (global-set-key (kbd "C-c p s") 'helm-do-ag-project-root)

(global-set-key (kbd "C-w") 'backward-kill-word)



(provide 'init-keybindings)
