(add-to-list 'custom-theme-load-path "/home/andrewdo/.emacs.d/themes")
;;require 'blackboard-theme)

(add-to-list 'load-path "/home/andrewdo/.emacs.d/addons")
(require 'centered-window-mode)
(centered-window-mode t)

(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")))))
(package-initialize)
