;; This .emacs file illustrates the minimul setup
;; required to run the JDE.

;; Set the debug option to enable a backtrace when a
;; problem occurs.
;; (setq debug-on-error t)

;; set up AspectJ path variables
;; (setenv "PATH" (concat (getenv "PATH") ":/Users/Shared/aspectj1.6/bin"))
;; (setq exec-path (append exec-path '(":/Users/Shared/aspectj1.6/bin")))

;; (setenv "CLASSPATH" (concat (getenv "CLASSPATH") ":/Users/Shared/aspectj1.6/lib/aspectjrt.jar"))
;; (setq exec-path (append exec-path '(":/Users/Shared/aspectj1.6/lib/aspectjrt.jar")))

;; Set up full screen toggler
(defun toggle-fullscreen () 
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil
                                           'fullscreen) nil
                                           'fullboth)))
(global-set-key [(meta return)] 'toggle-fullscreen)

;;(setq load-path (cons "/Users/Shared/AspectJForEmacs-1.1b2/aspectj-mode" load-path))
;;(require 'aspectj-mode)

;; set up colour themes
(add-to-list 'load-path "/Users/Shared/emacs/color-theme-6.6.0/color-theme.el")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))

;; turn on visual bell
(setq visible-bell t) 

;; get rid of the toolbar on top of the window
(tool-bar-mode 0)
;; Show column number at bottom of screen
(column-number-mode 1)

(add-to-list 'load-path "/Users/Shared/emacs/linum/linum.el")
;;(require 'linum)
;;(require 'linum)


;; turn on paren matching
    (show-paren-mode t)
    (setq show-paren-style 'mixed)

;; Use "y or n" answers instead of full words "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Dont show the GNU splash screen
(setq inhibit-startup-message t)

;;will make the last line end in a carriage return.
(setq require-final-newline t)

;; Display the time in the mode line
;(setq display-time-24hr-format t)
(display-time)

;; REDO (a better way to handle undo and redo)
;; http://www.wonderworks.com/
;;(require 'redo)
;;(global-set-key [(control +)] 'redo)

;; show ascii table
;; optained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun ascii-table ()
  "Print the ascii table. Based on a defun by Alex Schroeder <asc@bsiag.com>"
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))
  (let ((i 0))
    (while (< i 254)
      (setq i (+ i 1))
      (insert (format "%4d %c\n" i i))))
  (beginning-of-buffer))

;; insert date into buffer at point
;; optained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun insert-date ()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "%a %Y-%m-%d - %l:%M %p")))

;; Update the Emacs load-path to include the path to
;; the JDE and its require packages. This code assumes
;; that you have installed the packages in the emacs/site
;; subdirectory of your home directory.

(add-to-list 'load-path (expand-file-name "/Users/Shared/emacs/jdee-2.4.0.1/lisp"))
(add-to-list 'load-path (expand-file-name "/Users/Shared/emacs/site/cedet/common"))
(add-to-list 'load-path (expand-file-name "/Users/Shared/emacs/elib-1.0"))
(add-to-list 'load-path (expand-file-name "/Users/Shared/emacs/ecb"))
;; Initialize CEDET.
(load-file (expand-file-name "/Users/Shared/emacs/cedet-1.0/common/cedet.el"))

(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
;;(semantic-load-enable-minimum-features)      
(global-srecode-minor-mode 1)            ; Enable template insertion menu

(require 'semantic-ia)
(require 'semantic-gcc)
;;(require 'ecb)

;; If you want Emacs to defer loading the JDE until you open a 
;; Java file, edit the following line
;;(setq defer-loading-jde nil)
;; to read:
;;
  (setq defer-loading-jde t)
;;

(if defer-loading-jde
    (progn
      (autoload 'jde-mode "jde" "JDE mode." t)
      (setq auto-mode-alist
	    (append
	     '(("\\.java\\'" . jde-mode))
	     auto-mode-alist)))
  (require 'jde))


;; Sets the basic indentation for Java source files
;; to two spaces.
(defun my-jde-mode-hook ()
  (setq c-basic-offset 2))

(add-hook 'jde-mode-hook 'my-jde-mode-hook)

;; Include the following only if you want to run
;; bash as your shell.

;; Setup Emacs to run bash as its primary shell.
(setq shell-file-name "bash")
(setq shell-command-switch "-c")
(setq explicit-shell-file-name shell-file-name)
(setenv "SHELL" shell-file-name)
(setq explicit-sh-args '("-login" "-i"))
(if (boundp 'w32-quote-process-args)
  (setq w32-quote-process-args ?\")) ;; Include only for MS Windows.
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(canlock-password "ba1f430463088e746d85297b7bf7ca81c5c6b0ab")
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote ("~/Projects/sandpit")))
 '(jde-enable-abbrev-mode t)
 '(jde-java-environment-variables (quote ("JAVA_VERSION" "JDE_JAVA_HOME"))))
;(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
;n )

;; load the complete ecb
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
