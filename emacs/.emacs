(custom-set-variables
					; custom-set-variables was added by Custom.
					; If you edit it by hand, you could mess it up, so be careful.
					; Your init file should contain only one such instance.
					; If there is more than one, they won't work right.
 '(package-selected-packages '(which-key solarized-theme undo-tree evil))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(custom-set-faces
					; custom-set-faces was added by Custom.
					; If you edit it by hand, you could mess it up, so be careful.
					; Your init file should contain only one such instance.
					; If there is more than one, they won't work right.
 '(default ((t (:family "iMWritingDuo Nerd Font" :foundry "UKWN" :slant normal :weight normal :height 83 :width normal))))
 '(custom-group-tag-face ((t (:underline t :foreground "lightblue"))) t)
 '(custom-variable-tag-face ((t (:underline t :foreground "lightblue"))) t)
 '(font-lock-builtin-face ((t nil)))
 '(font-lock-comment-face ((t (:italic t :foreground "#3aba1a"))) t)
					;'(font-lock-comment-face ((t (:foreground "#3fdflf"))))
					;'(font-lock-comment-face ((,class (:italic t :foreground ,comment))))
 '(font-lock-function-name-face ((((class color) (background dark)) (:foreground "white"))))
 '(font-lock-keyword-face ((t (:foreground "white"))))
 '(font-lock-string-face ((t (:foreground "#0fdfaf"))))
 '(font-lock-variable-name-face ((((class color) (background dark)) (:foreground "#c8d4ec"))))
 '(font-lock-warning-face ((t (:foreground "#504038"))))
 '(highlight ((t (:foreground "navyblue" :background "darkseagreen2"))))
 '(mode-line ((t (:inverse-video t))))
 '(region ((t (:background "blue"))))
 '(widget-field-face ((t (:foreground "white"))) t)
 '(widget-single-line-field-face ((t (:background "darkgray"))) t))

(global-font-lock-mode 1)
(set-cursor-color "lightgreen")
(set-background-color "#072626")
(global-set-key [C-return] 'save-buffer)
					;(set-face-attribute 'default nil :font "Anonymous Pro-14")
					;(set-face-attribute 'default nil :font "Consolas-174")
(set-face-foreground 'font-lock-builtin-face         "lightgreen")

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

					;
					; THEME
					;
					; M-x load-theme will list all of the themes available.

					; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

					;(require 'undo-tree)
