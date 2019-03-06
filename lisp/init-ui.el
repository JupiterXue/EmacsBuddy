;; turn off tool-bar
(tool-bar-mode -1)

;; turn off scroll-bar
(scroll-bar-mode -1)

;; turn off splash screen
(setq inhibit-splash-screen t)

;;打开上次的文件记录
;; save your config
(load "desktop") 
(desktop-load-default)
(desktop-read)

;;当emacs退出时保存文件打开状态
(add-hook 'kill-emacs-hook
          '(lambda()(desktop-save "~/")))



;; config cursor to bar,setq set current buffer, setq-defalut set global configuation.
(setq-default cursor-type 'bar)

;; open with full screen
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; highlight show current row
(global-hl-line-mode t)

;; show right indent,default is 1
(electric-indent-mode 1)

(provide 'init-ui)
