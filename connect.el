(defvar connect-targets
  '(("hexaconta" . "/ssh:hexaconta:/home/arteen")
    ("lug" . "/ssh:root@lug:/var/www/html")))

(defun connect (target)
  (interactive
   (list (completing-read
	  "Connect to: "
	  connect-targets
	  nil
	  t)))
  (dired (cdr (assoc target connect-targets))))

(provide 'connect)


