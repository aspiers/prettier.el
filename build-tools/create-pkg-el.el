;;; create-pkg.el --- Generate prettier.pkg.el  -*- lexical-binding: t; -*-

;;; Commentary:

(require 'package)
(require 'lisp-mnt)

;;; Code:

(defun prettier--create-pkg-el (output-filename)
  "Write `prettier-pkg.el' to OUTPUT-FILENAME."
  (with-temp-buffer
    (insert-file-contents "prettier.el")
    (let ((pkg-desc (package-buffer-info)))
      (let ((version-suffix (getenv "VERSION_SUFFIX")))
        (when version-suffix
          (setf (package-desc-version pkg-desc)
                (append (package-desc-version pkg-desc)
                        (list (string-to-number
                               version-suffix))))))
      (push (cons :keywords
                  (split-string (lm-header "keywords") "[ ,]+"))
            (package-desc-extras pkg-desc))
      (package-generate-description-file
       pkg-desc
       output-filename))))

;;; create-pkg-el.el ends here
