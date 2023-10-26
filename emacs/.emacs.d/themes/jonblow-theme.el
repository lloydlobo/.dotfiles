;;; jonblow-theme.el --- Theme

;; This file is not part of Emacs.

;;; Commentary:
;;; jonblow-theme.el is based on Jonathan Blow's emacs theme.
;;;
;;; This file borrows scheme from naysayer theme which replicates Blow's theme..
;;; ;; Dark green blue color scheme with tan colors. Inspired by Jonathan Blow's compiler livestreams.

;;; Code:

(deftheme jonblow)
(let ((class '((class color) (min-colors 89)))
      (fg1 "#d3eaf4")
      (fg2 "#cadae2")
      (fg3 "#748895")
      (fg4 "#4f545a")
      (fg6 "#c4c4c4")
      (bg1 "#062329")
      (bg2 "#24343e")
      (bg3 "#0c191d")
      (bg4 "#0d6f9f")
      (builtin "#41b2ea")
      (keyword "#ffffff")
      (const   "#96defa")
      (comment "#7a95a0")
      (func    "#a094fb")
      (str     "#89e14b")
      (type    "#68cee8")
      (var     "#ff6ba9")
      (bufid     "#ffffff")
      (selection "#e81050")
      (warning   "#e81050")
      (warning2  "#e86310")
      (todo  "#c897ff")
      (done  "#d6ff97")
      (unspec   (when (>= emacs-major-version 29) 'unspecified)))
  (custom-theme-set-faces
   'jonblow
   `(default ((,class (:background ,bg1 :foreground ,fg1))))
   `(dashboard-footer ((,class (:foreground ,var :italic t))))
   `(dashboard-heading ((,class (:foreground ,const :weight bold))))
   `(dashboard-text-banner ((,class (:foreground ,fg1 :weight bold))))
   `(dashboard-banner-logo-title ((,class (:foreground ,str :weight bold))))
   `(font-lock-builtin-face ((,class (:foreground ,builtin))))
   `(font-lock-comment-face ((,class (:italic t :foreground ,comment))))
   `(font-lock-negation-char-face ((,class (:foreground ,const))))
   `(font-lock-reference-face ((,class (:foreground ,const))))
   `(font-lock-constant-face ((,class (:foreground ,const))))
   `(font-lock-doc-face ((,class (:foreground ,comment))))
   `(font-lock-function-name-face ((,class (:foreground ,func ))))
   `(font-lock-keyword-face ((,class (:bold ,class :foreground ,keyword))))
   `(font-lock-string-face ((,class (:foreground ,str))))
   `(font-lock-type-face ((,class (:foreground ,type ))))
   `(font-lock-variable-name-face ((,class (:foreground ,var))))
   `(font-lock-warning-face ((,class (:foreground ,warning :background ,bg2))))
   `(term-color-black ((,class (:foreground ,fg2 :background ,unspec))))
   ;; `(region ((,class (:background ,fg1 :foreground ,bg1))))
   `(region ((,class (:background ,selection))))
   `(highlight ((,class (:foreground ,fg3 :background ,bg3))))
   `(hl-line ((,class (:background  ,bg2))))
   `(fringe ((,class (:background ,bg1 :foreground ,fg4))))
   `(cursor ((,class (:background ,fg4))))
   `(isearch ((,class (:bold t :foreground ,warning :background ,bg3))))
   `(mode-line ((,class (:box (:line-width 4 :color ,bg2) :bold t :foreground ,fg3 :background ,bg2))))
   `(mode-line-inactive ((,class (:box (:line-width 4 :color ,bg3) :foreground ,fg3 :background ,bg3 :weight bold))))
   `(mode-line-buffer-id ((,class (:box nil :bold t :foreground ,bufid :background ,unspec))))
   `(mode-line-highlight ((,class (:box nil :foreground ,selection :weight bold))))
   `(mode-line-emphasis ((,class (:foreground ,fg1))))
   `(vertical-border ((,class (:foreground ,fg3))))
   `(minibuffer-prompt ((,class (:bold t :foreground ,builtin))))
   `(default-italic ((,class (:italic t))))
   `(link ((,class (:foreground ,const :underline t))))
   `(org-code ((,class (:foreground ,fg2))))
   `(org-hide ((,class (:foreground ,fg4))))
   `(org-level-1 ((,class (:bold t :foreground ,builtin :height 1.7))))
   `(org-level-2 ((,class (:bold t :foreground ,str :height 1.6))))
   `(org-level-3 ((,class (:bold t :foreground ,var :height 1.5))))
   `(org-level-4 ((,class (:bold t :foreground ,func :height 1.4))))
   `(org-level-5 ((,class (:bold t :foreground ,const :height 1.3))))
   `(org-level-6 ((,class (:bold t :foreground ,keyword :height 1.2))))
   `(org-level-7 ((,class (:bold t :foreground ,builtin :height 1.1))))
   `(org-level-8 ((,class (:bold t :foreground ,str :height 1.0))))
   `(org-date ((,class (:underline t :foreground ,var) )))
   `(org-footnote  ((,class (:underline t :foreground ,fg4))))
   `(org-link ((,class (:underline t :foreground ,type ))))
   `(org-special-keyword ((,class (:foreground ,func))))
   `(org-block ((,class (:foreground ,fg2))))
   `(org-quote ((,class (:inherit org-block :slant italic))))
   `(org-verse ((,class (:inherit org-block :slant italic))))
   `(org-todo ((,class (:foreground ,todo :bold t :italic t))))
   `(org-done ((,class (:foreground ,done :bold t :italic t))))
   `(org-warning ((,class (:underline t :foreground ,warning))))
   `(org-agenda-structure ((,class (:weight bold :foreground ,fg3 :box (:color ,fg4) :background ,bg3))))
   `(org-agenda-date ((,class (:foreground ,var :height 1.1 ))))
   `(org-agenda-date-weekend ((,class (:weight normal :foreground ,fg4))))
   `(org-agenda-date-today ((,class (:weight bold :foreground ,keyword :height 1.4))))
   `(org-agenda-done ((,class (:foreground ,bg4))))
   `(org-scheduled ((,class (:foreground ,type))))
   `(org-scheduled-today ((,class (:foreground ,func :weight bold :height 1.2))))
   `(org-ellipsis ((,class (:foreground ,builtin))))
   `(org-verbatim ((,class (:foreground ,str))))
   `(org-document-info-keyword ((,class (:foreground ,func))))
   `(font-latex-bold-face ((,class (:foreground ,type))))
   `(font-latex-italic-face ((,class (:foreground ,var :italic t))))
   `(font-latex-string-face ((,class (:foreground ,str))))
   `(font-latex-match-reference-keywords ((,class (:foreground ,const))))
   `(font-latex-match-variable-keywords ((,class (:foreground ,var))))
   `(ido-only-match ((,class (:foreground ,warning))))
   `(org-sexp-date ((,class (:foreground ,fg4))))
   `(ido-first-match ((,class (:foreground ,keyword :bold t))))
   `(ivy-current-match ((,class (:foreground ,fg3 :inherit highlight :underline t))))
   `(gnus-header-content ((,class (:foreground ,keyword))))
   `(gnus-header-from ((,class (:foreground ,var))))
   `(gnus-header-name ((,class (:foreground ,type))))
   `(gnus-header-subject ((,class (:foreground ,func :bold t))))
   `(mu4e-view-url-number-face ((,class (:foreground ,type))))
   `(mu4e-cited-1-face ((,class (:foreground ,fg2))))
   `(mu4e-cited-7-face ((,class (:foreground ,fg3))))
   `(mu4e-header-marks-face ((,class (:foreground ,type))))
   `(ffap ((,class (:foreground ,fg4))))
   `(js2-private-function-call ((,class (:foreground ,const))))
   `(js2-jsdoc-html-tag-delimiter ((,class (:foreground ,str))))
   `(js2-jsdoc-html-tag-name ((,class (:foreground ,var))))
   `(js2-external-variable ((,class (:foreground ,type  ))))
   `(js2-function-param ((,class (:foreground ,const))))
   `(js2-jsdoc-value ((,class (:foreground ,str))))
   `(js2-private-member ((,class (:foreground ,fg3))))
   `(js3-warning-face ((,class (:underline ,keyword))))
   `(js3-error-face ((,class (:underline ,warning))))
   `(js3-external-variable-face ((,class (:foreground ,var))))
   `(js3-function-param-face ((,class (:foreground ,fg2))))
   `(js3-jsdoc-tag-face ((,class (:foreground ,keyword))))
   `(js3-instance-member-face ((,class (:foreground ,const))))
   `(warning ((,class (:foreground ,warning))))
   `(ac-completion-face ((,class (:underline t :foreground ,keyword))))
   `(info-quoted-name ((,class (:foreground ,builtin))))
   `(info-string ((,class (:foreground ,str))))
   `(icompletep-determined ((,class :foreground ,builtin)))
   `(undo-tree-visualizer-current-face ((,class :foreground ,builtin)))
   `(undo-tree-visualizer-default-face ((,class :foreground ,fg2)))
   `(undo-tree-visualizer-unmodified-face ((,class :foreground ,var)))
   `(undo-tree-visualizer-register-face ((,class :foreground ,type)))
   `(slime-repl-inputed-output-face ((,class (:foreground ,type))))
   `(trailing-whitespace ((,class :foreground ,unspec :background ,warning)))
   `(rainbow-delimiters-depth-1-face ((,class :foreground ,fg1)))
   `(rainbow-delimiters-depth-2-face ((,class :foreground ,type)))
   `(rainbow-delimiters-depth-3-face ((,class :foreground ,var)))
   `(rainbow-delimiters-depth-4-face ((,class :foreground ,const)))
   `(rainbow-delimiters-depth-5-face ((,class :foreground ,keyword)))
   `(rainbow-delimiters-depth-6-face ((,class :foreground ,fg1)))
   `(rainbow-delimiters-depth-7-face ((,class :foreground ,type)))
   `(rainbow-delimiters-depth-8-face ((,class :foreground ,var)))
   `(magit-item-highlight ((,class :background ,bg3)))
   `(magit-section-heading        ((,class (:foreground ,keyword :weight bold))))
   `(magit-hunk-heading           ((,class (:background ,bg3))))
   `(magit-section-highlight      ((,class (:background ,bg2))))
   `(magit-hunk-heading-highlight ((,class (:background ,bg3))))
   `(magit-diff-context-highlight ((,class (:background ,bg3 :foreground ,fg3))))
   `(magit-diffstat-added   ((,class (:foreground ,type))))
   `(magit-diffstat-removed ((,class (:foreground ,var))))
   `(magit-process-ok ((,class (:foreground ,func :weight bold))))
   `(magit-process-ng ((,class (:foreground ,warning :weight bold))))
   `(magit-branch ((,class (:foreground ,const :weight bold))))
   `(magit-log-author ((,class (:foreground ,fg3))))
   `(magit-hash ((,class (:foreground ,fg2))))
   `(magit-diff-file-header ((,class (:foreground ,fg2 :background ,bg3))))
   `(lazy-highlight ((,class (:foreground ,fg2 :background ,bg3))))
   `(term ((,class (:foreground ,fg1 :background ,bg1))))
   `(term-color-black ((,class (:foreground ,bg3 :background ,bg3))))
   `(term-color-blue ((,class (:foreground ,func :background ,func))))
   `(term-color-red ((,class (:foreground ,keyword :background ,bg3))))
   `(term-color-green ((,class (:foreground ,type :background ,bg3))))
   `(term-color-yellow ((,class (:foreground ,var :background ,var))))
   `(term-color-magenta ((,class (:foreground ,builtin :background ,builtin))))
   `(term-color-cyan ((,class (:foreground ,str :background ,str))))
   `(term-color-white ((,class (:foreground ,fg2 :background ,fg2))))
   `(rainbow-delimiters-unmatched-face ((,class :foreground ,warning)))
   `(helm-header ((,class (:foreground ,fg2 :background ,bg1 :underline nil :box nil))))
   `(helm-source-header ((,class (:foreground ,keyword :background ,bg1 :underline nil :weight bold))))
   `(helm-selection ((,class (:background ,bg2 :underline nil))))
   `(helm-selection-line ((,class (:background ,bg2))))
   `(helm-visible-mark ((,class (:foreground ,bg1 :background ,bg3))))
   `(helm-candidate-number ((,class (:foreground ,bg1 :background ,fg1))))
   `(helm-separator ((,class (:foreground ,type :background ,bg1))))
   `(helm-time-zone-current ((,class (:foreground ,builtin :background ,bg1))))
   `(helm-time-zone-home ((,class (:foreground ,type :background ,bg1))))
   `(helm-buffer-not-saved ((,class (:foreground ,type :background ,bg1))))
   `(helm-buffer-process ((,class (:foreground ,builtin :background ,bg1))))
   `(helm-buffer-saved-out ((,class (:foreground ,fg1 :background ,bg1))))
   `(helm-buffer-size ((,class (:foreground ,fg1 :background ,bg1))))
   `(helm-ff-directory ((,class (:foreground ,func :background ,bg1 :weight bold))))
   `(helm-ff-file ((,class (:foreground ,fg1 :background ,bg1 :weight normal))))
   `(helm-ff-executable ((,class (:foreground ,var :background ,bg1 :weight normal))))
   `(helm-ff-invalid-symlink ((,class (:foreground ,warning2 :background ,bg1 :weight bold))))
   `(helm-ff-symlink ((,class (:foreground ,keyword :background ,bg1 :weight bold))))
   `(helm-ff-prefix ((,class (:foreground ,bg1 :background ,keyword :weight normal))))
   `(helm-grep-cmd-line ((,class (:foreground ,fg1 :background ,bg1))))
   `(helm-grep-file ((,class (:foreground ,fg1 :background ,bg1))))
   `(helm-grep-finish ((,class (:foreground ,fg2 :background ,bg1))))
   `(helm-grep-lineno ((,class (:foreground ,fg1 :background ,bg1))))
   `(helm-grep-match ((,class (:foreground ,unspec :background ,unspec :inherit helm-match))))
   `(helm-grep-running ((,class (:foreground ,func :background ,bg1))))
   `(helm-moccur-buffer ((,class (:foreground ,func :background ,bg1))))
   `(helm-source-go-package-godoc-description ((,class (:foreground ,str))))
   `(helm-bookmark-w3m ((,class (:foreground ,type))))
   `(company-echo-common ((,class (:foreground ,bg1 :background ,fg1))))
   `(company-preview ((,class (:background ,bg1 :foreground ,var))))
   `(company-preview-common ((,class (:foreground ,bg2 :foreground ,fg3))))
   `(company-preview-search ((,class (:foreground ,type :background ,bg1))))
   `(company-scrollbar-bg ((,class (:background ,bg3))))
   `(company-scrollbar-fg ((,class (:foreground ,keyword))))
   `(company-tooltip ((,class (:foreground ,fg2 :background ,bg2 :bold t))))
   `(company-tooltop-annotation ((,class (:foreground ,const))))
   `(company-tooltip-common ((,class ( :foreground ,fg3))))
   `(company-tooltip-common-selection ((,class (:foreground ,str))))
   `(company-tooltip-mouse ((,class (:inherit highlight))))
   `(company-tooltip-selection ((,class (:background ,bg3 :foreground ,fg3))))
   `(company-template-field ((,class (:inherit region))))
   `(web-mode-builtin-face ((,class (:inherit ,font-lock-builtin-face))))
   `(web-mode-comment-face ((,class (:inherit ,font-lock-comment-face))))
   `(web-mode-constant-face ((,class (:inherit ,font-lock-constant-face))))
   `(web-mode-keyword-face ((,class (:foreground ,keyword))))
   `(web-mode-doctype-face ((,class (:inherit ,font-lock-comment-face))))
   `(web-mode-function-name-face ((,class (:inherit ,font-lock-function-name-face))))
   `(web-mode-string-face ((,class (:foreground ,str))))
   `(web-mode-type-face ((,class (:inherit ,font-lock-type-face))))
   `(web-mode-html-attr-name-face ((,class (:foreground ,func))))
   `(web-mode-html-attr-value-face ((,class (:foreground ,keyword))))
   `(web-mode-warning-face ((,class (:inherit ,font-lock-warning-face))))
   `(web-mode-html-tag-face ((,class (:foreground ,builtin))))
   `(jde-java-font-lock-package-face ((t (:foreground ,var))))
   `(jde-java-font-lock-public-face ((t (:foreground ,keyword))))
   `(jde-java-font-lock-private-face ((t (:foreground ,keyword))))
   `(jde-java-font-lock-constant-face ((t (:foreground ,const))))
   `(jde-java-font-lock-modifier-face ((t (:foreground ,fg2))))
   `(jde-jave-font-lock-protected-face ((t (:foreground ,keyword))))
   `(jde-java-font-lock-number-face ((t (:foreground ,var))))
   `(yas-field-highlight-face ((t (:background ,selection)))))
   ;; Legacy
   (if (< emacs-major-version 22)
       (custom-theme-set-faces
        'jonblow
        `(show-paren-match-face ((,class (:background ,warning))))) ;; obsoleted in 22.1, removed 2016
     (custom-theme-set-faces
      'jonblow
      `(show-paren-match ((,class (:foreground ,bg1 :background ,str))))
      `(show-paren-mismatch ((,class (:foreground ,bg1 :background ,warning))))))
   ;; emacs >= 26.1
   (when (>= emacs-major-version 26)
     (custom-theme-set-faces
      'jonblow
      `(line-number ((t (:inherit fringe))))
      `(line-number-current-line ((t (:inherit fringe :foreground ,fg6 :weight bold))))))

  ;; emacs >= 27.1
  (when (>= emacs-major-version 27)
    (custom-theme-set-faces
     'jonblow
     `(tab-line              ((,class (:background ,bg2 :foreground ,fg4))))
     `(tab-line-tab          ((,class (:inherit tab-line))))
     `(tab-line-tab-inactive ((,class (:background ,bg2 :foreground ,fg4))))
     `(tab-line-tab-current  ((,class (:background ,bg1 :foreground ,fg1))))
     `(tab-line-highlight    ((,class (:background ,bg1 :foreground ,fg2))))))
 (when (>= emacs-major-version 28)
    (custom-theme-set-faces
     'jonblow
     `(line-number ((t (:inherit fringe))))
     `(line-number-current-line ((t (:inherit fringe :foreground ,fg6 :weight bold))))))
;; emacs >= 27.1
(when (>= emacs-major-version 27)
  (custom-theme-set-faces
   'jonblow
   `(tab-line              ((,class (:background ,bg2 :foreground ,fg4))))
   `(tab-line-tab          ((,class (:inherit tab-line))))
   `(tab-line-tab-inactive ((,class (:background ,bg2 :foreground ,fg4))))
   `(tab-line-tab-current  ((,class (:background ,bg1 :foreground ,fg1))))
   `(tab-line-highlight    ((,class (:background ,bg1 :foreground ,fg2))))))
 (when (>= emacs-major-version 28)
    (custom-theme-set-faces
     'jonblow
     `(tab-line-tab-modified ((,class (:foreground ,warning2 :weight bold))))))
  (when (boundp 'font-lock-regexp-face)
    (custom-theme-set-faces
    'jonblow
    `(font-lock-regexp-face ((,class (:inherit font-lock-string-face :underline t)))))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'jonblow)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; jonblow-theme.el ends here

;;;
;;; ;;; (custom-set-faces
;;; ;;;   ;; custom-set-faces was added by Custom.
;;; ;;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;; ;;;   ;; Your init file should contain only one such instance.
;;; ;;;   ;; If there is more than one, they won't work right.
;;; ;;;  '(default ((t (:foreground "#d3b58d" :background "#041818"))))
;;; ;;;  '(custom-group-tag-face ((t (:underline t :foreground "lightblue"))) t)
;;; ;;;  '(custom-variable-tag-face ((t (:underline t :foreground "lightblue"))) t)
;;; ;;;  '(font-lock-builtin-face ((t nil)))
;;; ;;;  ; '(font-lock-comment-face ((t (:foreground "yellow"))))
;;; ;;;  '(font-lock-comment-face ((t (:foreground "#3fdflf"))))
;;; ;;;  '(font-lock-function-name-face ((((class color) (background dark)) (:foreground "white"))))
;;; ;;;  '(font-lock-keyword-face ((t (:foreground "white" ))))
;;; ;;;  ; '(font-lock-string-face ((t (:foreground "gray160" :background "gray16"))))
;;; ;;;  '(font-lock-string-face ((t (:foreground "#0fdfaf"))))
;;; ;;;  '(font-lock-variable-name-face ((((class color) (background dark)) (:foreground "#c8d4ec"))))
;;; ;;; ; '(font-lock-warning-face ((t (:foreground "#695a46"))))
;;; ;;;  '(font-lock-warning-face ((t (:foreground "#504038"))))
;;; ;;;  '(highlight ((t (:foreground "navyblue" :background "darkseagreen2"))))
;;; ;;;  '(mode-line ((t (:inverse-video t))))
;;; ;;;  '(region ((t (:background "blue"))))
;;; ;;;  '(widget-field-face ((t (:foreground "white"))) t)
;;; ;;;  '(widget-single-line-field-face ((t (:background "darkgray"))) t))
;;; ;;;
;;; ;;; (global-font-lock-mode 1)
;;; ;;; (set-cursor-color "lightgreen")
;;; ;;; (set-background-color "#072626")
;;; ;;; (global-set-key [C-return] 'save-buffer)
;;; ;;;
;;; ;;; ;(set-face-attribute 'default nil :font "Anonymous Pro-14")
;;; ;;; (set-face-attribute 'default nil :font "Consolas-174")
;;; ;;;
;;; ;;; (set-face-foreground 'font-lock-builtin-face         "lightgreen")
