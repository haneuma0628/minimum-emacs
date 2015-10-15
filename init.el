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

(add-to-load-path "themes" "elpa")


;;; パッケージ管理
(require 'package)

; Add package-archives
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) ; ついでにmarmaladeも追加

; Initialize
(package-initialize)


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
(set-frame-parameter (selected-frame) 'alpha '(90 90))


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


;;; タブエディタっぽくできる tabbar
(require 'tabbar)
(tabbar-mode 1)

;; グループ化しない
(setq tabbar-buffer-groups-function nil)

;; 左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

;; タブ同士の間隔
(setq tabbar-separator '(1.5))

;; 外観変更
(set-face-attribute
 'tabbar-default nil
 :family (face-attribute 'default :family)
 :background (face-attribute 'mode-line-inactive :background)
 :height 0.9)
(set-face-attribute
 'tabbar-unselected nil
 :background (face-attribute 'mode-line-inactive :background)
 :foreground (face-attribute 'mode-line-inactive :foreground)
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background (face-attribute 'mode-line :background)
 :foreground (face-attribute 'mode-line :foreground)
 :box nil)
(defun get-color-helper (face attribute n diff)
  (format "%x" (max 0 (min (car (color-values "white"))
                           (+ diff (nth n (color-values (face-attribute face attribute))))))))
(defun create-color-helper (face attribute r g b)
  (concat "#"
          (get-color-helper face attribute 0 r)
          (get-color-helper face attribute 1 g)
          (get-color-helper face attribute 2 b)))
;; usage
(create-color-helper 'mode-line :foreground 10 -20 30)

;; キーに割り当てる
(global-set-key [C-tab] 'tabbar-forward-tab)
(global-set-key [C-S-tab] 'tabbar-backward-tab)
