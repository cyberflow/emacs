

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

;;---------------------------------------------------------------------------
;; Them
;;(add-to-list 'load-path "/Users/Eespeto/.emacs.d/")
;;(require 'color-theme)
;;(require 'color-theme-tomorrow) 
(load "~/.emacs.d/color-theme-tomorrow.el")
;;(eval-after-load "color-theme"
;;  '(progn
     (color-theme-tomorrow-night)
;;(eval-after-load "color-theme"
;;  '(progn
; ;    (color-theme-initialize))
;)

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
(add-hook 'dired-mode-hook
 (lambda ()
  (define-key dired-mode-map (kbd "^")
    (lambda () (interactive) (find-alternate-file "..")))
  ; was dired-up-directory
 ))
;; we want dired not not make always a new buffer if visiting a directory
;; but using only one dired buffer for all directories.
(defadvice dired-advertised-find-file (around dired-subst-directory activate)
"Replace current buffer if file is a directory."
          (interactive)
          (let ((orig (current-buffer))
                (filename (dired-get-filename)))
            ad-do-it
            (when (and (file-directory-p filename)
                       (not (eq (current-buffer) orig)))
              (kill-buffer orig))))