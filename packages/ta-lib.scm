(define-module (packages ta-lib)
    #:use-module (gnu packages guile)
    #:use-module (gnu packages pkg-config)
    #:use-module ((guix licenses) #:prefix license:)
    #:use-module (guix download)
    #:use-module (guix packages)
    #:use-module (guix build-system cmake)
    #:use-module (guix build-system gnu)
    #:use-module (guix utils))

(define-public ta-lib
    (package
        (name "ta-lib")
        (version "0.4.19")
        (source (origin
            (method url-fetch)
             (uri (string-append "http://prdownloads.sourceforge.net/ta-lib/" name "-" version "-src.tar.gz"))
            (sha256
                (base32 "0lf69nna0aahwpgd9m9yjzbv2fbfn081djfznssa84f0n7y1xx4z"))))
        (build-system gnu-build-system)
      (arguments
        `(#:tests? #f 
          #:configure-flags (list (string-append "--prefix="
                                              %output))
       #:phases
       (modify-phases %standard-phases
         (add-after 'configure 'patch-Makefile
           (lambda _
            (substitute* "src/tools/gen_code/Makefile"
               (("mv -f") "cp "))
            #t)))))
        (native-inputs `(
            ("pkg-config", pkg-config)))
        (home-page "https://mrjbq7.github.io/ta-lib/")
        (synopsis "This is a Python wrapper for TA-LIB based on Cython instead of SWIG. From the homepage:")
        (description "This is a Python wrapper for TA-LIB based on Cython instead of SWIG. From the homepage:")
        (license license:expat)))
