;; ;; Added by Package.el.  This must come before configurations of;
;; installed packages.  Don't delete this line.  If you don't want it,; ;; just

;; ;; You may delete these explanatory comments.

;; ;; ===============================================================
;; ;; Package Setting
;; ;; ===============================================================

(require 'package)
(add-to-list  'package-archives  '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)
(require 'python)

;; ;; ===============================================================
;; ;; Global Setting
;; ;; ===============================================================

;; elispをPATHに設定
(add-to-list 'load-path "~/.emacs.d/elisp/")

(setq default-directory "~/")
(toggle-truncate-lines 1)

;; [Mac専用] 右コマンドをhyperキーに変更する
(when (eq system-type 'darwin)
  (setq mac-right-command-modifier 'hyper))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; Warningがうるさいので出さない
(setq warning-minimum-level :error)

;; 分割したwindowで行の折り返しを
(setq truncate-partial-width-windows nil)

;; ビープ音がうるさい
(setq ring-bell-function 'ignore)

;; Theme の設定
(load-theme 'dracula t)

;; タイトルバーの色を変更
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;; カーソルの点滅を止める
(blink-cursor-mode 0)

;;メニューバーを消す
(menu-bar-mode 0)

;;ツールバーを消す
(tool-bar-mode 0)

;; 選択範囲を上書き
(delete-selection-mode t)

;;スクロールバーを消す
(scroll-bar-mode 0)

;;起動時のメッセージを消す
(setq ihibit-startup-message t)

;;yes,noをy,nで回答可能にする
(defalias 'yes-or-no-p 'y-or-n-p)

;; 終了時に終了してよいか質問
(setq confirm-kill-emacs 'y-or-n-p)

;;起動時のメッセージを非表示にする
(setq inhibit-startup-message t)

;; スクリーンの大きさ調整 画面の半分くらいに変更
(setq frame-resize-pixelwise t)
(set-frame-position (selected-frame) 0 0)
(set-frame-size (selected-frame) 942 1024 t)

;;TABの表示幅 初期値は8
(setq-default tab-width 4)

;; tab はスペースに置き換える
(setq-default indent-tabs-mode nil)

;; tab 幅はデフォルトは 2 スペース分
(setq-default tab-width 2)

;;対応する括弧を強調して表示する
(show-paren-mode 1)
(setq show-paren-delay 0) ;表示までの秒数
(setq show-paren-style 'mixed)

;;バックアップファイルとオートセーブファイルを~/.emacs.d/backupsへ集める
(setq backup-directory-alist
      (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
			backup-directory-alist))
(setq auto-save-file-name-transforms
      `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;; ファイルをゴミ箱に移動させる
(setq trash-directory "~/.Trash")
(setq delete-by-moving-to-trash t)

;; 自動ファイルリストとロックファイルは生成しない
(setq auto-save-list-file-prefix nil)
(setq create-lockfiles nil)

;; scratchバッファーについては削除させない
(with-current-buffer "*scratch*"
  (emacs-lock-mode 'kill))

;;スクリプトファイルに実行権限を与えて保存
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; ===============================================================
;; Shell Setting
;; ===============================================================

;; fishをデフォルトシェルに
(defun skt:shell ()
  (or (executable-find "fish")
      (executable-find "bash")
      (error "can't find 'shell' command in PATH!!")))
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

(use-package multi-term)

(use-package pyenv-mode
  :after (pythonic))

(use-package pythonic
  :after(python))

(defun set-powerline-font-to-major-mode ()
  (setq buffer-face-mode-face '(:family "Meslo LG S for Powerline" :height 100))
  (buffer-face-mode))

(use-package shell-pop
  :init
  (setq shell-pop-shell-type (quote ("ansi-term" "*shell-pop*" (lambda nil (ansi-term shell-pop-term-shell)))))
  (setq shell-pop-term-shell "/usr/local/bin/fish")
  (setq shell-pop-window-height 30)
  (setq shell-pop-window-position "bottom")
  :config
  (define-key term-raw-map (kbd "M-x") 'nil)
  (add-hook 'term-mode-hook 'set-powerline-font-to-major-mode)
  :bind
  (:map term-mode-map
		("C-h" . term-send-backspace)))

;; shellの文字化けを回避
(add-hook 'shell-mode-hook
          (lambda ()
            (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)))

;; ===============================================================
;; Language Setting
;; ===============================================================
(set-language-environment "Japanese")
(setenv "LANG" "ja_JP.UTF-8")
(prefer-coding-system 'utf-8)

(require 'ucs-normalize)
(set-file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)

(when (eq system-type 'gnu/linux) ; Linux OS
  (set-frame-parameter nil 'fullscreen 'maximized)
  (add-to-list 'default-frame-alist '(font . "ricty-13.5")))
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "源ノ角ゴシック Code JP"))

(setq default-cursor-in-non-selected-windows nil)

(set-keyboard-coding-system 'cp932)
(prefer-coding-system 'utf-8-unix)
(set-file-name-coding-system 'cp932)
(setq default-process-coding-system '(cp932 . cp932))

;; ;; ===============================================================
;; ;; Various Package Setting
;; ;; ===============================================================

(use-package logview
  :mode
  ("\\.log$" . logview-mode))

(use-package highlight-numbers
  :config
  (add-hook 'prog-mode-hook 'highlight-numbers-mode))

(use-package subword
  :diminish subword-mode
  :config
  (add-hook 'prog-mode-hook (lambda () (subword-mode 1))))

;; smartparen
(use-package smartparens
  :config
  (sp-pair "「" "」")
  (sp-pair "【" "】")
  (sp-pair "'" "'")
  (progn
    (require 'smartparens-config)
    (sp-local-pair 'org-mode "$" "$")
    (eval-after-load 'org-mode     '(require 'smartparens-org))
    (show-smartparens-global-mode)
    (smartparens-global-mode)))

;; neotree
(use-package neotree
  :commands (projectile)
  :init
  (setq neo-show-hidden-files t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-smart-open t)
  :config
  (projectile-global-mode)
  :bind
  ("C-x C-x" . 'neotree-toggle)
  (:map neotree-mode-map
		("a" . 'neotree-hidden-file-toggle)
		("f" . 'neotree-change-root)
		("b" . 'neotree-select-up-node)))

;; hide-mode-line
(use-package hide-mode-line
  :hook
  ((neotree-mode imenu-list-minor-mode minimap-mode) . hide-mode-line-mode))

(setq ispell-program-name "aspell")

(use-package vue-mode
  :config
  (setq mmm-js-mode-enter-hook (lambda () (setq syntax-ppss-table nil)))
  (setq mmm-typescript-mode-enter-hook (lambda () (setq syntax-ppss-table nil))))

;; avy
(use-package avy
  :init
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?w ?e ?r ?t ?u ?i ?o ?v ?c ?n ?m))
  (setq avy-style 'at-full)
  (setq avy-background t)
  (setq avy-all-windows nil)
  (setq avy-timeout-seconds 0.4)
  :bind
  ("C-S-o" . 'avy-goto-char-timer)
  ("C-S-l" . 'avy-goto-line))

(use-package ox-qmd
  :init
  (setq ox-qmd-unfill-paragraph nil))

;; undo-tree
(use-package undo-tree
  :bind
  ("C-/" . nil)
  ("s-z" . nil)
  ("C-z" . undo-tree-undo)
  ("s-z" . undo-tree-undo)
  ("C-/" . undo-tree-redo)
  ("s-Z" . undo-tree-redo)
  :config
  (global-undo-tree-mode))

;; company
(use-package company
  :init
  (setq company-idle-delay 0) ; デフォルトは0.5
  (setq company-minimum-prefix-length 1) ; デフォルトは4
  (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
  (setq company-dabbrev-downcase nil)	;string内で大文字と小文字の区別を行う
  (defun edit-category-table-for-company-dabbrev (&optional table)
  (define-category ?s "word constituents for company-dabbrev" table)
  (let ((i 0))
    (while (< i 128)
      (if (equal ?w (char-syntax i))
      (modify-category-entry i ?s table)
    (modify-category-entry i ?s table t))
      (setq i (1+ i)))))
  :config
  ;; (add-hook 'prog-mode-hook 'company-mode)
  (global-company-mode)
  (edit-category-table-for-company-dabbrev)
  (setq company-dabbrev-char-regexp "\\cs")
  (setq company-backends (delete 'company-semantic company-backends))
  :bind
  (:map company-active-map
		("M-n" . nil)
		("M-p" . nil)
		("C-h" . nil)
		("C-n" . company-select-next)
		("C-p" . company-select-previous )
		("<tab>" . company-complete-common-or-cycle )))

(use-package company-box
  :hook (company-mode . company-box-mode))

;; doom-modeline
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-bar-width 3)
  (setq doom-modeline-height 20)
  (setq doom-modeline-icon t)
  (setq doom-modeline-minor-modes nil))

;; company-c-headers
(use-package company-c-headers
  :config
  (add-to-list 'company-backends 'company-c-headers)
                                        ;TODO: 以下環境依存な部分もあるため、環境毎に対応させる必要
  (add-to-list 'company-c-headers-path-system "/usr/local/Cellar/gcc/8.2.0/include/c++/8.2.0")
  (add-to-list 'company-c-headers-path-system "/usr/local/Cellar/gcc/8.2.0/include/c++/8.2.0/x86_64-apple-darwin17.7.0")
  (add-to-list 'company-c-headers-path-system "/usr/local/Cellar/gcc/8.2.0/include/c++/8.2.0/x86_64-apple-darwin17.7.0")
  (add-to-list 'company-c-headers-path-system "/usr/local/Cellar/gcc/8.2.0/lib/gcc/8/gcc/x86_64-apple-darwin17.7.0/8.2.0/include")
  (add-to-list 'company-c-headers-path-system "/usr/local/Cellar/gcc/8.2.0/include")
  (add-to-list 'company-c-headers-path-system "/usr/local/Cellar/gcc/8.2.0/lib/gcc/8/gcc/x86_64-apple-darwin17.7.0/8.2.0/include-fixed")
  (add-to-list 'company-c-headers-path-system "/System/Library/Frameworks")
  (add-to-list 'company-c-headers-path-system "/Library/Frameworks"))

;; recentfの設定
(use-package recentf
  :init
  (setq recentf-auto-cleanup 60)
  (setq recentf-exclude '(".recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" ".emacs.d/games/*-scores" "output-html/*"))
  (setq recentf-auto-save-timer
		(run-with-idle-timer 60 t 'recentf-save-list))
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
  (setq recentf-max-saved-items 2000)

  ;; recentf の メッセージをエコーエリア(ミニバッファ)に表示しない
  ;; (*Messages* バッファには出力される)
  (defun recentf-save-list-inhibit-message:around (orig-func &rest args)
	(setq inhibit-message t)
	(apply orig-func args)
	(setq inhibit-message nil)
	'around)
  :config
  (recentf-mode 1)

  (advice-add 'recentf-cleanup   :around 'recentf-save-list-inhibit-message:around)
  (advice-add 'recentf-save-list :around 'recentf-save-list-inhibit-message:around))

(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (setq indent-tabs-mode nil)     ; インデントは空白文字で行う（TABコードを空白に変換）
             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
             (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
             ))

;;; これがないとemacs -Qでエラーになる。おそらくバグ。
;; (require 'compile)

;; dump-jum
(use-package dumb-jump
  :init
  (setq dumb-jump-default-project "")
  (setq dumb-jump-force-searcher 'ag))

;; auctexの設定
(use-package auctex
  :after (tex reftex)
  :ensure t
  :config
  (setq TeX-default-mode 'japanese-latex-mode)
  (setq japanese-LaTeX-default-style "jarticle")
  (setq TeX-engine-alist '((ptex "pTeX" "eptex" "platex" "eptex")
						   (jtex "jTeX" "jtex" "jlatex" nil)
						   (uptex "upTeX" "euptex" "uplatex" "euptex")))
  (setq TeX-engine 'uptex)
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq reftex-plug-into-AUCTeX t)
  (setq-default TeX-master nil)
  (add-hook 'japanese-latex-mode-hook (lambda () (flycheck-mode nil)))
  :bind
  ("C-c r" . reftex-reference)
  ("C-c l" . reftex-label)
  ("C-c c" . reftex-citation))

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ;auctexの中に入れたいけど何故か機能しない

;; multiple-cursorsの設定
(use-package multiple-cursors
  :bind
  ("C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this-symbol)
  ("C-<" . mc/mark-previous-like-this-symbol)
  ("C-c C-<" . mc/mark-all-like-this))

;; popwinの設定
(use-package popwin
  :config
  (popwin-mode 1)
  (setq popwin:special-display-config
		'(("*complitation*" :noselect t)))
  (push '("*Agenda Commands*" :regexp t) popwin:special-display-config)
  (push '("^\*Org Agenda*" :regexp t :height 0.4) popwin:special-display-config))

;; autoinsertの設定
(use-package autoinsert
  :init
  (setq auto-insert-directory "~/.emacs.d/template/")
  (setq auto-insert-query nil)
  :config
  (auto-insert-mode 1)
  (setq auto-insert-alist
        (nconc '(
                 ("\\.cpp$" . ["template.cpp" my-template])
                 ("\\.py$"   . ["template.py" my-template])
                 ("\\.org$"   . ["template.org" my-template])
                 ("\\.tex$"   . ["template.tex" my-template])
                 ("\\.js$"   . ["template.js" my-template])
                 ) auto-insert-alist)))

;; autoinsert で利用する変数展開
(defvar template-replacements-alists
  '(("%file%"             . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%time%" . (lambda () (format-time-string "%Y-%m-%d")))
    ("%mtg-timeformat%" . (lambda () (format-time-string "%m%d")))
    ("%include-guard%"    . (lambda () (format "__SCHEME_%s__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))

;; 実際に変数展開を行う設定
(defun my-template ()
  (time-stamp)
  (mapc #'(lambda(c)
			(progn
			  (goto-char (point-min))
			  (replace-string (car c) (funcall (cdr c)) nil)))
		template-replacements-alists)
  (goto-char (point-max))
  (message "done."))

;; smart-newlineの設定
(use-package smart-newline)

;;undohistの設定
(use-package undohist
  :config
  (undohist-initialize))

;; whitespace の設定
(use-package whitespace
  :init
  (setq whitespace-style
        '(
          face ; faceで可視化
          trailing ; 行末
          ;; tabs ; タブ
          spaces ; スペース
          space-mark ; 表示のマッピング
          ;; tab-mark
          ))
  (setq whitespace-display-mappings
        '(
          (space-mark ?\u3000 [?\u2423])
          (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])
          ))
  (setq whitespace-trailing-regexp  "\\([ \u00A0]+\\)$")
  (setq whitespace-space-regexp "\\(\u3000+\\)")
  (setq whitespace-action '(auto-cleanup))
  :config
  (global-whitespace-mode)
  (add-hook 'markdown-mode-hook
          '(lambda ()
             (set (make-local-variable 'whitespace-action) nil)))
  (set-face-attribute 'whitespace-trailing nil
                      :foreground "RoyalBlue4"
                      :background "RoyalBlue4"
                      :underline nil)
  (set-face-attribute 'whitespace-tab nil
                      :foreground "yellow4"
                      :background "yellow4"
                      :underline nil)
  (set-face-attribute 'whitespace-space nil
                      :foreground "gray40"
                      :background "gray20"
                      :underline nil))

;; yaml-mode の設定
(use-package yaml-mode
  :init
  (setq indent-tabs-mode nil))

;; rust-mode の設定
(use-package rust-mode
  :config
  (add-hook 'rust-mode-hook
			(lambda ()
			  (setq tab-width 2)
			  (setq indent-tabs-mode nil)
			  )))

;; emmet の設定
(use-package emmet-mode
  :init
  (setq emmet-indentation 2)
  :bind
  (:map emmet-mode-keymap
        ("C-j" . nil)
        ("<tab>" . indent-for-tab-command)
        ("C-i" . emmet-expand-line))
  :hook
  (sgml-mode web-mode css-mode-hook))

;;web-modeの設定
(use-package web-mode
  :bind
  (:map web-mode-map
		("C-;" . web-mode-fold-or-unfold))
  :config
  (setq web-mode-html-offset   2)
  (setq web-mode-style-padding 2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2)
  (setq web-mode-tag-auto-close-style 2)
  :mode
  (("\\.html?$" . web-mode)
   ("\\.php?$" . web-mode)))

;;flycheckの設定
(use-package flycheck
  :config
  ;;TODO: globalにflycheckを有効化して、使わないメジャーモードについてdisableにする設定を行いたいけどうまくいかない
  ;; (global-flycheck-mode)
  (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
  (add-hook 'js-mode-hook #'flycheck-mode)
  (add-hook 'c++-mode-hook #'flycheck-mode)
  (custom-set-variables
   '(flycheck-disabled-checkers '(javascript-jshint javascript-jscs)))
  (flycheck-define-checker c/c++11
	"original C++ checker"
	:command ("g++-8" "-Wall" "-Wextra" "-std=c++11" source)
	:error-patterns  ((error line-start
							 (file-name) ":" line ":" column ":" " Error: " (message)
							 line-end)
                      (error line-start
                             (file-name) ":" line ":" column ":" " Fatal Error: " (message)
							 line-end)
                      (warning line-start
                               (file-name) ":" line ":" column ":" " Warning: " (message)
                               line-end))
	:modes (c-mode c++-mode))
  (add-hook 'c++-mode-hook				;originalのチェッカーをデフォルトに変更。競プロ用なのでdir-localでもいいかも
			'(lambda()
               (flycheck-select-checker 'c/c++11))))

;; ivyの設定
(use-package ivy
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-virtual-abbreviate 'abbreviate)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 20)
  (setq ivy-format-function #'ivy-format-function-default)

  :config
  (ivy-mode 1)
  (minibuffer-depth-indicate-mode 1))

(use-package counsel
  :after (ivy)
  :bind
  ("M-x" .  counsel-M-x)
  ("C-M-z" .  counsel-fzf)
  ("C-x C-r" .  ivy-switch-buffer)
  ("C-M-f" .  counsel-ag)
  ("M-y" .  counsel-yank-pop)
  (:map ivy-switch-buffer-map
		("C-k" . ivy-switch-buffer-kill))
  :config
  (counsel-mode 1)
  (setq ivy-initial-inputs-alist
		'(;; (org-refile . "^")
          (org-agenda-refile . "^")
          (org-capture-refile . "^")
          (counsel-describe-function . "^")
          (counsel-describe-variable . "^")
          ;; (counsel-org-capture . "^")
          (Man-completion-table . "^")
          (woman . "^"))))

(use-package ivy-rich
  :defines
  (all-the-icons-icon-alist
   all-the-icons-dir-icon-alist
   bookmark-alist)

  :functions
  (all-the-icons-icon-for-file
   all-the-icons-icon-for-mode
   all-the-icons-icon-family
   all-the-icons-match-to-alist
   all-the-icons-faicon
   all-the-icons-octicon
   all-the-icons-dir-is-submodule)

  :preface
  (defun ivy-rich-bookmark-name (candidate)
    (car (assoc candidate bookmark-alist)))

  (defun ivy-rich-buffer-icon (candidate)
    "Display buffer icons in `ivy-rich'."
    (when (display-graphic-p)
      (let* ((buffer (get-buffer candidate))
             (buffer-file-name (buffer-file-name buffer))
             (major-mode (buffer-local-value 'major-mode buffer))
             (icon (if (and buffer-file-name
                            (all-the-icons-auto-mode-match?))
                       (all-the-icons-icon-for-file (file-name-nondirectory buffer-file-name) :v-adjust -0.05)
                     (all-the-icons-icon-for-mode major-mode :v-adjust -0.05))))
        (if (symbolp icon)
            (all-the-icons-faicon "file-o" :face 'all-the-icons-dsilver :height 0.8 :v-adjust 0.0)
          icon))))

  (defun ivy-rich-file-icon (candidate)
    "Display file icons in `ivy-rich'."
    (when (display-graphic-p)
      (let* ((path (file-local-name (concat ivy--directory candidate)))
             (file (file-name-nondirectory path))
             (icon (cond
                    ((file-directory-p path)
                     (cond
                      ((and (fboundp 'tramp-tramp-file-p)
                            (tramp-tramp-file-p default-directory))
                       (all-the-icons-octicon "file-directory" :height 1.0 :v-adjust 0.01))
                      ((file-symlink-p path)
                       (all-the-icons-octicon "file-symlink-directory" :height 1.0 :v-adjust 0.01))
                      ((all-the-icons-dir-is-submodule path)
                       (all-the-icons-octicon "file-submodule" :height 1.0 :v-adjust 0.01))
                      ((file-exists-p (format "%s/.git" path))
                       (all-the-icons-octicon "repo" :height 1.1 :v-adjust 0.01))
                      (t (let ((matcher (all-the-icons-match-to-alist path all-the-icons-dir-icon-alist)))
                           (apply (car matcher) (list (cadr matcher) :v-adjust 0.01))))))
                    ((string-match "^/.*:$" path)
                     (all-the-icons-material "settings_remote" :height 1.0 :v-adjust -0.2))
                    ((not (string-empty-p file))
                     (all-the-icons-icon-for-file file :v-adjust -0.05)))))
        (if (symbolp icon)
            (all-the-icons-faicon "file-o" :face 'all-the-icons-dsilver :height 0.8 :v-adjust 0.0)
          icon))))

  (defun ivy-rich-dir-icon (candidate)
    "Display directory icons in `ivy-rich'."
    (when (display-graphic-p)
      (all-the-icons-octicon "file-directory" :height 1.0 :v-adjust 0.01)))

  (defun ivy-rich-function-icon (_candidate)
    "Display function icons in `ivy-rich'."
    (when (display-graphic-p)
      (all-the-icons-faicon "cube" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-purple)))

  (defun ivy-rich-variable-icon (_candidate)
    "Display variable icons in `ivy-rich'."
    (when (display-graphic-p)
      (all-the-icons-faicon "tag" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-lblue)))

  (defun ivy-rich-symbol-icon (_candidate)
    "Display symbol icons in `ivy-rich'."
    (when (display-graphic-p)
      (all-the-icons-octicon "gear" :height 0.9 :v-adjust -0.05)))

  (defun ivy-rich-theme-icon (_candidate)
    "Display theme icons in `ivy-rich'."
    (when (display-graphic-p)
      (all-the-icons-material "palette" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue)))

  (defun ivy-rich-keybinding-icon (_candidate)
    "Display keybindings icons in `ivy-rich'."
    (when (display-graphic-p)
      (all-the-icons-material "keyboard" :height 1.0 :v-adjust -0.2)))

  (defun ivy-rich-library-icon (_candidate)
    "Display library icons in `ivy-rich'."
    (when (display-graphic-p)
      (all-the-icons-material "view_module" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue)))

  (defun ivy-rich-package-icon (_candidate)
    "Display package icons in `ivy-rich'."
    (when (display-graphic-p)
      (all-the-icons-faicon "archive" :height 0.9 :v-adjust 0.0 :face 'all-the-icons-silver)))

  (when (display-graphic-p)
    (defun ivy-rich-bookmark-type-plus (candidate)
      (let ((filename (file-local-name (ivy-rich-bookmark-filename candidate))))
        (cond ((null filename)
               (all-the-icons-material "block" :v-adjust -0.2 :face 'warning))  ; fixed #38
              ((file-remote-p filename)
               (all-the-icons-material "wifi_tethering" :v-adjust -0.2 :face 'mode-line-buffer-id))
              ((not (file-exists-p filename))
               (all-the-icons-material "block" :v-adjust -0.2 :face 'error))
              ((file-directory-p filename)
               (all-the-icons-octicon "file-directory" :height 0.9 :v-adjust -0.05))
              (t (all-the-icons-icon-for-file (file-name-nondirectory filename) :height 0.9 :v-adjust -0.05)))))
    (advice-add #'ivy-rich-bookmark-type :override #'ivy-rich-bookmark-type-plus))

  :config
  (ivy-rich-mode)

  :init
  ;; For better performance
  (setq ivy-rich-parse-remote-buffer nil)

  ;; Setting tab size to 1, to insert tabs as delimiters
  (add-hook 'minibuffer-setup-hook
            (lambda ()
              (setq tab-width 1)))

  (setq ivy-rich-display-transformers-list
        '(ivy-switch-buffer
          (:columns
           ((ivy-rich-buffer-icon)
            (ivy-rich-candidate (:width 30))
            (ivy-rich-switch-buffer-size (:width 7))
            (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
            (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
            (ivy-rich-switch-buffer-project (:width 15 :face success))
            (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
           :predicate
           (lambda (cand) (get-buffer cand))
           :delimiter "\t")
          ivy-switch-buffer-other-window
          (:columns
           ((ivy-rich-buffer-icon)
            (ivy-rich-candidate (:width 30))
            (ivy-rich-switch-buffer-size (:width 7))
            (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
            (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
            (ivy-rich-switch-buffer-project (:width 15 :face success))
            (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
           :predicate
           (lambda (cand) (get-buffer cand))
           :delimiter "\t")
          counsel-switch-buffer
          (:columns
           ((ivy-rich-buffer-icon)
            (ivy-rich-candidate (:width 30))
            (ivy-rich-switch-buffer-size (:width 7))
            (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
            (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
            (ivy-rich-switch-buffer-project (:width 15 :face success))
            (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
           :predicate
           (lambda (cand) (get-buffer cand))
           :delimiter "\t")
          counsel-switch-buffer-other-window
          (:columns
           ((ivy-rich-buffer-icon)
            (ivy-rich-candidate (:width 30))
            (ivy-rich-switch-buffer-size (:width 7))
            (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
            (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
            (ivy-rich-switch-buffer-project (:width 15 :face success))
            (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
           :predicate
           (lambda (cand) (get-buffer cand))
           :delimiter "\t")
          persp-switch-to-buffer
          (:columns
           ((ivy-rich-buffer-icon)
            (ivy-rich-candidate (:width 30))
            (ivy-rich-switch-buffer-size (:width 7))
            (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
            (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
            (ivy-rich-switch-buffer-project (:width 15 :face success))
            (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
           :predicate
           (lambda (cand) (get-buffer cand))
           :delimiter "\t")
          counsel-M-x
          (:columns
           ((ivy-rich-function-icon)
            (counsel-M-x-transformer (:width 50))
            (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))
          counsel-describe-function
          (:columns
           ((ivy-rich-function-icon)
            (counsel-describe-function-transformer (:width 50))
            (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))
          counsel-describe-variable
          (:columns
           ((ivy-rich-variable-icon)
            (counsel-describe-variable-transformer (:width 50))
            (ivy-rich-counsel-variable-docstring (:face font-lock-doc-face))))
          counsel-apropos
          (:columns
           ((ivy-rich-symbol-icon)
            (ivy-rich-candidate))
           :delimiter "\t")
          counsel-info-lookup-symbol
          (:columns
           ((ivy-rich-symbol-icon)
            (ivy-rich-candidate))
           :delimiter "\t")
          counsel-descbinds
          (:columns
           ((ivy-rich-keybinding-icon)
            (ivy-rich-candidate))
           :delimiter "\t")
          counsel-find-file
          (:columns
           ((ivy-rich-file-icon)
            (ivy-read-file-transformer))
           :delimiter "\t")
          counsel-file-jump
          (:columns
           ((ivy-rich-file-icon)
            (ivy-rich-candidate))
           :delimiter "\t")
          counsel-dired
          (:columns
           ((ivy-rich-file-icon)
            (ivy-read-file-transformer))
           :delimiter "\t")
          counsel-dired-jump
          (:columns
           ((ivy-rich-file-icon)
            (ivy-rich-candidate))
           :delimiter "\t")
          counsel-fzf
          (:columns
           ((ivy-rich-file-icon)
            (ivy-rich-candidate))
           :delimiter "\t")
          counsel-git
          (:columns
           ((ivy-rich-file-icon)
            (ivy-rich-candidate))
           :delimiter "\t")
          counsel-recentf
          (:columns
           ((ivy-rich-file-icon)
            (ivy-rich-candidate (:width 0.8))
            (ivy-rich-file-last-modified-time (:face font-lock-comment-face)))
           :delimiter "\t")
          counsel-bookmark
          (:columns
           ((ivy-rich-bookmark-type)
            (ivy-rich-bookmark-name (:width 40))
            (ivy-rich-bookmark-info))
           :delimiter "\t")
          counsel-package
          (:columns
           ((ivy-rich-package-icon)
            (ivy-rich-candidate))
           :delimiter "\t")
          counsel-find-library
          (:columns
           ((ivy-rich-library-icon)
            (ivy-rich-candidate))
           :delimiter "\t")
          counsel-load-library
          (:columns
           ((ivy-rich-library-icon)
            (ivy-rich-candidate))
           :delimiter "\t")
          counsel-load-theme
          (:columns
           ((ivy-rich-theme-icon)
            (ivy-rich-candidate))
           :delimiter "\t")
          counsel-projectile-switch-project
          (:columns
           ((ivy-rich-file-icon)
            (ivy-rich-candidate))
           :delimiter "\t")
          counsel-projectile-find-file
          (:columns
           ((ivy-rich-file-icon)
            (counsel-projectile-find-file-transformer))
           :delimiter "\t")
          counsel-projectile-find-dir
          (:columns
           ((ivy-rich-dir-icon)
            (counsel-projectile-find-dir-transformer))
           :delimiter "\t")
          treemacs-projectile
          (:columns
           ((ivy-rich-file-icon)
            (ivy-rich-candidate))
           :delimiter "\t"))))

(use-package ivy-yasnippet
  :bind
  ("C-c y" . ivy-yasnippet))

(use-package swiper
  :bind
  ("M-s M-s" . swiper-thing-at-point))

;; hl-line+の設定
(use-package hl-line+
  :init
  (setq hl-line-idle-interval 2)
  :config
  (toggle-hl-line-when-idle)
  (set-face-background 'hl-line "firebrick"))

(use-package elmacro
  :config
  (elmacro-mode))

(use-package yasnippet
  :after ivy
  :bind
  ;; companyのtabと競合しているのでC-iと使い分ける
  (:map yas-keymap
        ("<tab>" . nil))
  :config
										;TODO: 今の設定だとdir-localでsnippetのdirが更新されても、自分でreloadしないといけない
  (yas-global-mode 1)
  (push '("emacs.+/snippets/" . snippet-mode) auto-mode-alist))

(defvar company-mode/enable-yas t)
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

;; hs-modeの設定
(use-package hs-minor-mode
  :hook
  (prog-mode))

(defun my-asm-mode-hook ()
  (local-unset-key (vector asm-comment-char))
  (electric-indent-local-mode)
  (setq indent-tabs-mode nil)
  (defun asm-calculate-indentation ()
	(or
	 (and (looking-at "[.@_[:word:]]+:") 0)
	 (and (looking-at "\\s<\\s<\\s<") 0)
	 (and (looking-at "%") 0)
	 (and (looking-at "c?global\\|section\\|default\\|align\\|INIT_..X") 0)
	 (or 4))))

(use-package asm-mode
  :config
  (setq tab-width 4)
  (add-hook 'asm-mode-hook #'my-asm-mode-hook)
  :mode
  ("\\.nas?$" . asm-mode))

;; ===============================================================
;; org-mode
;; ===============================================================

(use-package org
  :init
  (setq org-startup-truncated nil)
  (setq org-use-speed-commands t)
  (setq org-startup-with-inline-images t)
  (setq org-image-actual-width nil)
  ;; export style setting (https://orgmode.org/manual/Export-settings.html#Export-settings)
  (setq org-hide-emphasis-markers t)
  (setq org-export-with-timestamps nil)
  (setq org-export-with-sub-superscripts nil)
  (setq org-emphasis-alist
		'(("*" (bold :foreground "Orange" ))
		  ("/" italic)
		  ("_" underline)
		  ("=" (org-verbatim verbatim :background "maroon" :foreground "white"))
		  ("~" (org-code verbatim :background "deep sky blue" :foreground "MidnightBlue"))
		  ("+" (:strike-through t)))))

(use-package org-bullets
  :init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; ===============================================================
;; js-mode
;; ===============================================================
(use-package js2-mode
  :init
  (setq js2-idle-timer-delay 2))

;; ===============================================================
;; rjsx-mode
;; ===============================================================
(use-package rjsx-mode
  :init
  (setq js-indent-level 2)
  (setq js2-strict-missing-semi-warning nil))

;; ===============================================================
;; C/C++ setting
;; ===============================================================
(defun my-c-c++-mode-init ()
  (setq c-tab-always-indent t)
  (setq c-auto-newline t)
  (setq c-hungry-delete-key t)
  (setq indent-tabs-mode t)
  (c-toggle-auto-hungry-state -1)
  (setq c-basic-offset 4))
(add-hook 'c++-mode-hook 'my-c-c++-mode-init)
(add-hook 'c-mode-hook 'my-c-c++-mode-init)

;; ===============================================================
;; Original Function
;; ===============================================================

(defun my-put-file-name-on-clipboard ()
  "クリップボードにアクティブバッファのパスを格納"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

;; seq の設定
(defun count-string-matches (regexp string)
  (with-temp-buffer
    (insert string)
    (count-matches regexp (point-min) (point-max))))

(defun seq (format-string from to)
  "Insert sequences with FORMAT-STRING. FORMAT-STRING is like `format', but it can have multiple %-sequences."
  (interactive
   (list (read-string "Input sequence Format: ")
         (read-number "From: " 1)
         (read-number "To: ")))
  (save-excursion
    (loop for i from from to to do
          (insert (apply 'format format-string
                         (make-list (count-string-matches "%[^%]" format-string) i))
                  "\n")))
  (end-of-line))

(defun kill-word-at-point ()
  "単語上にカーソルがある時、実行されるとその単語を削除する関数"
  (interactive)
  (let ((char (char-to-string (char-after (point)))))
    (cond
     ((string= " " char) (delete-horizontal-space))
     ((string-match "[\t\n -@\[-`{-~]" char) (kill-word 1))
     (t (forward-char) (backward-word) (kill-word 1)))))

(defun window-resizer ()
  "ウィンドウのサイズをhjklで変更する関数"
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))

;; `ansi-term'内で`term-in-line-mode'と`term-in-char-mode'を入れ替える
(defun term-switch-line-char ()
  (interactive)
  (cond
   ((term-in-line-mode)
    (term-char-mode)
	(read-only-mode 0)
    (hl-line-mode -1))
   ((term-in-char-mode)
    (term-line-mode)
	(read-only-mode 1)
    (hl-line-mode 1))))

(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (called-interactively-p 'interactive) transient-mark-mode (not mark-active))
      (backward-kill-word 1) ad-do-it))

;; C-kのkill-line後に次の行のインデントを少なくする
(defadvice kill-line (before kill-line-and-fixup activate)
  (when (and (not (bolp)) (eolp))
    (forward-char)
    (fixup-whitespace)
    (backward-char)))

;; Hyperキー+任意キーでavyを起動させる
(defun one-prefix-avy (prefix c &optional mode)
  (define-key global-map
    (read-kbd-macro (concat prefix (string c)))
    `(lambda ()
       (interactive)
       (funcall (if (eq ',mode 'char)
                    #'avy-goto-word-1
                  #'avy-goto-char) ,c))))
(loop for c from ?! to ?~ do (one-prefix-avy "H-" c))

(defun finder-current-dir-open()
  "カレントバッファを finder で開く"
  (interactive)
  (shell-command "open ."))

(defun move-beginning-alt()
  " `C-a' でインデント加味して行頭に移動"
  (interactive)
  (if (bolp)
      (back-to-indentation)
    (beginning-of-line)))

;; `next-buffer' `before-buffer' について、閲覧する必要がないbufferをスキップする
(setq skippable-buffers '("*Messages*" "*Help*" "*Shell Command Output*" "shell-pop-?"))

(defun my-next-buffer ()
  "next-buffer that skips certain buffers"
  (interactive)
  (next-buffer)
  (while (member (buffer-name) skippable-buffers)
    (next-buffer)))

(defun my-previous-buffer ()
  "previous-buffer that skips certain buffers"
  (interactive)
  (previous-buffer)
  (while (member (buffer-name) skippable-buffers)
    (previous-buffer)))

(global-set-key [remap next-buffer] 'my-next-buffer)
(global-set-key [remap previous-buffer] 'my-previous-buffer)

;; `quit-window' でwindowsを消した時に、bufferを自動で消す
(defadvice quit-window (before quit-window-always-kill)
  (ad-set-arg 0 t))
(ad-activate 'quit-window)

;; macros
(defun org-to-md-for-case ()
  (interactive)
  (org-previous-visible-heading 1)
  (next-line 1 1)
  (set-mark-command nil)
  (org-next-visible-heading 1)
  (org-qmd-convert-region-to-md)
  (set-mark-command nil)
  (org-previous-visible-heading 1)
  (forward-char 3)
  (easy-kill 1)
  (undo-tree-undo nil))

;; ===============================================================
;; Key-bind (necessary bind-key.el)
;; ===============================================================
(require 'bind-key)

;; 一般的に使うプレフィックスなしキーバインド
(bind-key "M-[" 'replace-string)
(bind-key "M-d" 'kill-word-at-point)
(bind-key "M-g" 'goto-line)
(bind-key "M-w" 'easy-kill)
(bind-key "C-;" 'hs-toggle-hiding)
(bind-key "C-h" 'delete-backward-char)
(bind-key* "M-h" 'backward-kill-word)
(bind-key* "C-," 'goto-last-change)
(bind-key* "C-." 'goto-last-change-reverse)
(bind-key "C-M-l" 'hs-show-block)
(bind-key "C-M-h" 'hs-hide-block)
(bind-key "C-S-n" (lambda () (interactive) (scroll-up 3)))
(bind-key "C-S-p" (lambda () (interactive) (scroll-down 3)))
(bind-key "C-:" 'toggle-truncate-lines)
(bind-key "C-S-a" 'back-to-indentation)
(bind-key "C-S-b" 'backward-word)
(bind-key "C-S-f" 'forward-word)
(bind-key* "C-S-h" 'backward-kill-word)
(bind-key* "C-S-d" 'kill-word-at-point)
(bind-key "M-n" (kbd "M-5 C-n"))
(bind-key "M-p" (kbd "M-5 C-p"))
(bind-key "C-w" 'backward-kill-word minibuffer-local-completion-map)
(unbind-key "C-\\")				 ;Emacsのレイヤーで日本語の入力サポートされたくない
(bind-key "<f1>" 'read-only-mode)
(bind-key "<f9>" 'org-to-md-for-case)
(bind-key "C-a" 'move-beginning-alt)

;; Mac 依存のキーバインド
(bind-key "s-k" 'kill-this-buffer)
(bind-key "s-o" 'finder-current-dir-open)
(bind-key "s-." 'next-buffer)
(bind-key "s-," 'previous-buffer)
(bind-key "s-=" 'text-scale-adjust)
(bind-key "s--" 'text-scale-adjust)
(bind-key "s-t" 'find-file)
(bind-key "s-i" 'my-put-file-name-on-clipboard)
(bind-key "s-t" 'shell-pop)

;; window系とterminal系は共通のプレフィックス `C-t'
(unbind-key "C-t")
(unbind-key "C-t" term-raw-map)

(bind-keys :prefix-map window-prefix
           :prefix "C-t"
		   ("h" . windmove-left)
		   ("j" . windmove-down)
		   ("k" . windmove-up)
		   ("l" . windmove-right)
		   ("-" . split-window-below)
		   ("|" . split-window-right)
		   ("C-r" . window-resizer)
		   ("t" . shell-pop))

;; `bind-keys' 構文の中に複数の map が書けなさそうなので分けて書いてる
(bind-key "q" 'term-switch-line-char term-mode-map)
(bind-key "C-t [" 'term-switch-line-char term-raw-map)
(bind-key "C-t [" 'term-switch-line-char term-mode-map)

(unbind-key "C-q")
(bind-key "C-q C-q" 'quoted-insert)

;; ファイル系のプレフィックス `C-x'
(bind-key "C-x j" 'open-junk-file)

(put 'upcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-disabled-checkers '(javascript-jshint javascript-jscs))
 '(package-selected-packages
   '(yaml-mode web-mode use-package undohist tablist sudo-edit spaceline-all-the-icons smex smartparens smart-newline smart-mode-line shell-pop shackle rust-mode rjsx-mode request recentf-ext rainbow-mode rainbow-delimiters quickrun projectile powershell pos-tip popwin php-mode page-break-lines org-plus-contrib open-junk-file nhexl-mode neotree narrow-reindent multi-term mozc minibuffer-line migemo markdown-mode magit-popup magit logview latex-math-preview json-mode js2-refactor js-doc ivy-yasnippet ivy-rich ivy-hydra ivy-dired-history htmlize highlight-numbers highlight-indentation hide-mode-line hide-comnt graphql goto-chg go-mode ghub flycheck fish-mode exec-path-from-shell epc emmet-mode elmacro eldoc-eval easy-kill dumb-jump dracula-theme doom-modeline dockerfile-mode diminish csharp-mode company-c-headers company-box avy all-the-icons-ivy ace-jump-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
