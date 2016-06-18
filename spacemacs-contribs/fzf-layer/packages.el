;;; packages.el --- making fzf.el play well with spacemacs
;;
;; Copyright (c) 2016 Steven Troxler
;;
;; Author: Steven Troxler <steven.troxler@gmail.com>
;;
;; This file is not part of GNU Emacs.
;;
;;; License: Unlicense

(setq fzf-layer-packages
  '(
    (fzf :location
      (recipe :fetcher github :repo "bling/fzf.el"))
    )
  )


(defun fzf-layer/init-fzf ()
  "Set sending a line or region to osl and osr"
  (use-package fzf
    :defer t
    :init
    (progn

      ;; the spacemacs mode line settings confuse fzf, which
      ;; leads to aliasing in completion. The solution I found is
      ;; to simply enlarge the window a bit. This is a generic
      ;; advice function to enlarge a window.
      (defun advice/enlarge-window (orig-fun &rest args)
        "Call a function then enlarge the active window"
        (let ((res (apply orig-fun args)))
           (enlarge-window 5)
           res))

      ;; and we need to actually add the advice
      (advice-add 'fzf/start :around #'advice/enlarge-window)

      ;; in addition to needing to enlarge the window, I find that
      ;; the fzf default of 15 lines feels too small if you're
      ;; used to spacemacs, so I make the window a little bigger
      (custom-set-variables
          '(fzf/window-height 30))

      ;; finally, let's set some leader keys
      ;;   fz = fuzzy finder in default directory, which will be
      ;;        the projectile root if it finds one
      ;;   fzd = fuzzy finder, choosing a root directory
      (spacemacs/set-leader-keys "fz" 'fzf)
      (spacemacs/set-leader-keys "fdz" 'fzf/directory)
      )))
