;; guile test.scm /var/guix/profiles/per-user/hamzeh/guix-profile

(define-module (check-profile)
  #:use-module ((guix build syscalls)
                #:select (free-disk-space terminal-columns terminal-rows
                          with-file-lock/no-wait))
  #:use-module (srfi srfi-26)
  #:use-module (guix ui))

; /var/guix/profiles/per-user/<USERNAME>/guix-profile

(define profile-lock-file
  (cut string-append <> ".lock"))

(define (profile-lock-handler profile errno . _)
  "Handle failure to acquire PROFILE's lock."
  (if (= errno ENOLCK)
      (warning (G_ "cannot lock profile ~a: ~a~%")
               profile (strerror errno))
      (leave (G_ "profile ~a is locked by another process~%")
             profile)))

(define profile (cadr (command-line)))
(display (string-append "\n [+] Checking the profile lock: " profile "\n"))
(with-file-lock/no-wait (profile-lock-file profile) 
                          (cut profile-lock-handler profile <...>) (display "     Profile is free.\n"))
