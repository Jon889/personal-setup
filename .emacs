(global-set-key [f5] 'compile) 


;;use existing compile frame
(add-to-list
 'display-buffer-alist
 '("\\*compilation\\*" display-buffer-reuse-window
                         (reusable-frames . t)))


;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0)
(setq company-begin-commands '(self-insert-command))
(setq company-minimum-prefix-length 1)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(global-set-key (kbd "C-`") 'ff-find-other-file)

(global-set-key "\M-z" 'fastnav-zap-up-to-char-forward)
(global-set-key "\M-Z" 'fastnav-zap-up-to-char-backward)
(global-set-key "\M-s" 'fastnav-jump-to-char-forward)
(global-set-key "\M-S" 'fastnav-jump-to-char-backward)
(global-set-key "\M-r" 'fastnav-replace-char-forward)
(global-set-key "\M-R" 'fastnav-replace-char-backward)
(global-set-key "\M-i" 'fastnav-insert-at-char-forward)
(global-set-key "\M-I" 'fastnav-insert-at-char-backward)
(global-set-key "\M-j" 'fastnav-execute-at-char-forward)
(global-set-key "\M-J" 'fastnav-execute-at-char-backward)
(global-set-key "\M-k" 'fastnav-delete-char-forward)
(global-set-key "\M-K" 'fastnav-delete-char-backward)
(global-set-key "\M-m" 'fastnav-mark-to-char-forward)
(global-set-key "\M-M" 'fastnav-mark-to-char-backward)

(defun ensure-space () 
  (unless (or (= (preceding-char) ? )
	      (= (following-char) ? ))
    (unless (and (= (preceding-char) ?\()
		 (= (following-char) ?\)))
		 (insert-char ? )
    )
  )
)

(defun asi ()
  (backward-char)
  (when (= (following-char) ?{)
    (ensure-space)
  )
  (when (= (following-char) ?\))
    (ensure-space)
  )
  (when (= (preceding-char) ?\()
    (ensure-space)
  )

  (when (and (= (following-char) ?\))
	     (= (preceding-char) ? ))
    (backward-char)
    (if (= (preceding-char) ?\()
	(delete-char 1)
      (forward-char)
    )
  )

  (forward-char)
  (when (= (preceding-char) ?\()
    (ensure-space)
  )
  (when (= (following-char) ?\))
    (ensure-space)
    (backward-char)
  )
)

(add-hook 'c-mode-common-hook
  (lambda ()
    (add-hook 'post-self-insert-hook 'asi nil 'make-it-local)
    (set (make-local-variable 'compile-command) "scons -j4")))
