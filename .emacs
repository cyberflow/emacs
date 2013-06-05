

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

;; trasparent
(set-frame-parameter (selected-frame) 'alpha '(85 50))
 (add-to-list 'default-frame-alist '(alpha 85 50))
;; Set transparency of emacs

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

ispell-russian-dictionary "ru"
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
