;; j.el - allows jumps to directories catalogued by j.sh
;;
;; Written by Shane Celis <shane (at) gnufoo (dot) org> 2009-02-19
;;
;; This code allows one to jump to diretories that are catalogued by
;; j.sh.
;; 
;; Install
;; =======
;;
;; To install add the following lines to your .emacs file.
;;
;;    (load-library "~/j/j.el") ;  or whatever your path is to j.el
;;    (global-set-key (kbd "C-c j") 'j)
;;
;; 

(defcustom j-file "~/.j" "Path to .j file where j.sh keeps the most recently used directories.")
(defvar    j-dirs nil    "List of all the paths j.sh keeps.")

(defun j-getdirs ()
  "Reads in j-file and updates the j-dirs list of directories."
  (let ((filename (expand-file-name j-file)))
    (when (file-readable-p filename)
      (save-excursion
        (flet ((message (&rest args)))  ; Squelch messages.
          (with-temp-buffer
            ;;(switch-to-buffer "j-debug")
            ;;(progn
            (insert-file-contents filename)
            ;; Use re-builder for all regexes!  It's awesome.
            (replace-regexp "^\\(.*\\)|.*$" "\"\\1\" " nil (point-min) (point-max))
            (goto-char (point-min))
            (insert "(setq j-dirs '(")
            (goto-char (point-max))
            (insert "))")
            (eval-buffer)))))))

(defun j-filter (condp lst)
  "A filter function in elisp."
    (delq nil (mapcar (lambda (x) (and (funcall condp x) x)) lst)))

(defun j-complete (string pred flag)
  "Provides regex substring completion at prompt."
  (let* ((regex (concat ".*" string ".*"))
         (dirs (j-filter (lambda (dir) (string-match regex dir)) j-dirs)))
    ;(message "flag %s" (pp-to-string flag))
    (cond 
      ((null flag) ;; try-completion
       ;(message "try")
       (if (= 1 (length dirs))
           (if (string-equal string (car dirs))
               t
               (car dirs))
           (if (= 0 (length dirs))
               nil
               (try-completion "" dirs))))
      ((eq flag t) ;; all-completions
       ;(message "all")
       dirs)
      ((eq flag 'lambda) ;; lambda
       ;(message "lambda")
       (if (= 1 (length dirs))
           (string-equal (car dirs) string)
           nil)))))

(defun j ()
  "Jump to one of your recently used directories.  Uses
ido-completing-read if it is available."
  (interactive)
  (j-getdirs)
  (let ((dir (if (fboundp 'ido-completing-read)
                 (ido-completing-read "Directory: " j-dirs)
                 (completing-read "Directory: " 'j-complete)
                 )))
    (find-file dir)))
