(server-start)
;; --------------------------------
;; vision
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(load-library "time")
(setq display-time-24hr-format t
      display-time-mail-file t
      display-time-form-list (list 'time 'load)
      display-time-day-and-date t)
(display-time)

;; add linum-mode tour on
(global-linum-mode t)

;; ;; --------------------------------
;; ;; mail imap
;; (setq user-mail-address "dr@webzilla.com")
;; (setq user-full-name "Dmitry R.")
;; (require 'gnus)
;; (setq nnml-directory "~/.email")
;; (setq message-directory "~/.email")
;; (setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
;; (setq gnus-select-method
;;       '(nnimap "webzilla"
;; 	       (nnimap-address "mail.corporatemx.com")
;; 	       (nnimap-server-port 993)
;; 	       (nnimap-authinfo-file "~/.authinfo")
;; 	       (nnimap-inbox "INBOX")
;; 	       (nnimap-stream ssl))
;;       )
;; ;;(setq gnus-message-archive-group "nnimap:INBOX.Sent")
;; (setq gnus-permanently-visible-groups ".*INBOX")
;; (gnus-demon-add-handler 'gnus-group-get-new-news 5 nil)
;; ;; autocheck should not run between 8:30AM and 6PM during work days
;; ;; mail smtp
;; ;; (setq starttls-use-gnutls t)
;; ;;     (setq starttls-gnutls-program "gnutls-cli")
;; ;;     (setq starttls-extra-arguments nil)
;; ;; (require 'smtpmail)
;; ;;     (setq smtpmail-smtp-server "mail.corporatemx.com"
;; ;;           send-mail-function 'smtpmail-send-it
;; ;;           smtpmail-auth-credentials ;"~/.authinfo")
;; ;; 	  '(("mail.corporatemx.com" 25 "dr@webzilla.com" "n5IKezvlDZ7uop")))

;; take the short answer, y/n is yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; 
;;(setq emerge-diff-options "--ignore-all-space")

;; trasparent
(set-frame-parameter (selected-frame) 'alpha '(85 50))
 (add-to-list 'default-frame-alist '(alpha 85 50))
;; Set sudo
(require 'tramp)

;;---------------------------------------------------------------------------
;; Them
(setq inhibit-startup-message t)
(add-to-list 'load-path "~/.emacs.d/")
(require 'color-theme)
(require 'color-theme-tomorrow) 
(load "~/.emacs.d/color-theme-tomorrow.el")
(color-theme-tomorrow-night)

;; full-screen mode


;; ido-mode
(setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)
;; show-parent
(show-paren-mode 1)

;;=============================================================================
;;
;;Настройка проверки правописания Ispell
;;
(require 'flyspell)
(require 'ispell)

(setq
; i like aspel, and you?
 ispell-program-name "aspell"

; my dictionary-alist, using for redefinition russian dictionary
 ispell-dictionary-alist
'(("english"                       ; English
    "[a-zA-Z]"
 "[^a-zA-Z]"
 "[']"
 nil
 ("-d" "en")
 nil iso-8859-1)
("russian"                       ; Russian
    "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя]"
 "[^АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя]"
 "[-]"
 nil
 ("-C" "-d" "ru")
 nil utf-8)
(nil                             ; Default
    "[A-Za-z]"
 "[^A-Za-z]"
 "[']"
 nil
 ("-C")
 nil iso-8859-1))

ispell-russian-dictionary "russian"
ispell-english-dictionary "english"
flyspell-default-dictionary ispell-russian-dictionary
ispell-dictionary ispell-english-dictionary
ispell-local-dictionary ispell-russian-dictionary
ispell-extra-args '("--sug-mode=ultra"))

(defun flyspell-russian ()
(interactive)
(flyspell-mode t)
(ispell-change-dictionary ispell-russian-dictionary)
(flyspell-buffer)
(message "Russian dictionary - Spell Checking completed."))

; English
(defun flyspell-english ()
(interactive)
(flyspell-mode t)
(ispell-change-dictionary ispell-english-dictionary)
(flyspell-buffer)
(message "English dictionary - Spell Checking completed."))

(setq ispell-highlight-face (quote flyspell-incorrect))
(setq ispell-have-new-look t)
(setq ispell-enable-tex-parser t)
(add-hook 'text-mode-hook 'flyspell-mode)
(setq flyspell-delay 1)
(setq flyspell-always-use-popup t)

(global-set-key [f1] 'ispell-word)
(global-set-key (kbd "C-S-<f7>") 'ispell-buffer); проверить орфографию в текущем буфере
(global-set-key (kbd "C-S-<f8>") 'ispell-region)
(global-set-key [f9] 'auto-fill-mode); вкл/выкл автозаполнения
(global-set-key (kbd "C-S-<f10>") 'flyspell-english)
(global-set-key (kbd "C-S-<f11>") 'flyspell-russian)
(global-set-key (kbd "C-S-<f9>") 'flyspell-mode); вкл/выкл проверки орфографии "на ходу"
;;
;;============================================================================

;; dired open new buffer
(load "~/.emacs.d/dired-single.el")
(defun my-dired-init ()
        "Bunch of stuff to run for dired, either immediately or when it's
         loaded."
        ;; <add other stuff here>
        (define-key dired-mode-map [return] 'dired-single-buffer)
        (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
        (define-key dired-mode-map "^"
      	(function
      	 (lambda nil (interactive) (dired-single-buffer "..")))))

      ;; if dired's already loaded, then the keymap will be bound
      (if (boundp 'dired-mode-map)
      	;; we're good to go; just add our bindings
      	(my-dired-init)
        ;; it's not loaded yet, so add our bindings to the load-hook
        (add-hook 'dired-load-hook 'my-dired-init))

;; git-emacs
(add-to-list 'load-path "~/.emacs.d")
(require 'git-emacs)

;; markdown-mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Org-mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)
(setq org-agenda-files (list "~/.org/work.org"
                             "~/.org/movis.org"))

;; ECB
(add-to-list 'load-path "/usr/share/emacs/site-lisp/ecb")
(setq stack-trace-on-error t)
(add-hook 'ecb-before-activate-hook
                       (lambda () (semantic-mode 1)))
(global-ede-mode 1)
(setq ecb-layout-name "left14")
;;(require 'ecb-autoloads)

;; yasnippet
(add-to-list 'load-path "/home/cyberflow/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas-global-mode 1)

;;;; Табуляция по-умолчанию - 4 пробела
(setq tab-width 4)

;;; scroll stet
(setq scroll-step 1)

;;; novigation
(windmove-default-keybindings 'meta) 

;;; worckspace
(load-library "workspaces.el")
(global-set-key "\C-q" 'workspace-goto) 

;;; save session
(desktop-save-mode t) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; elpy
(package-initialize)
(elpy-enable)
