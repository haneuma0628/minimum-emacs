;;; 各ディレクトリにパスを通す
;; load-pathを追加する関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "themes")

;;; 機能いろいろ
(setq make-backup-file nil)
(setq auto-save-default nil)
(setq-default show-trailing-whitespace t) ; 文末の空白を表示
(setq scroll-step 1) ; 1行ずつスクロール
(show-paren-mode 1) ; 対応する括弧を光らせる
(setq show-paren-style 'mixed) ; ウィンドウ内に収まらないときだけ括弧内も光らせる

;;; Emacsの見た目
(setq custom-theme-directory "~/.emacs.d/themes/")
;; (load-theme 'hoge t) ; カスタムテーマ
(load-theme 'adwaita t)
(menu-bar-mode -1) ; メニューバーを消す
(tool-bar-mode -1) ; ツールバーを消す
(set-frame-parameter (selected-frame) 'alpha '(80 90))

;;; 英語フォント設定
(set-face-attribute
 'default nil
 :family "Menlo"
 :height 120
)

;; 行番号の表示
(require 'linum)
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#35395c"
                    :height 0.9)
(setq linum-format "%3d ")

;; キーバインド
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-cr" 'query-replace)
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)

(setq backup-inhibited t)

;;; python-mode
(add-hook 'python-mode-hook
          (lambda ()
            ;; use tab-indent
            (setq indent-tabs-mode t)
            (setq python-indent-offset 8)))
(put 'set-goal-column 'disabled nil)