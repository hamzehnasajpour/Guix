(define-module (packages kvantum)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system qt)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages check)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages kde-frameworks)
  #:use-module (srfi srfi-1))

(define-public kvantum
(package
  (name "kvantum")
  (version "0.20.1")
  (source (origin
      (method url-fetch)
        (uri (string-append
          "https://github.com/tsujan/Kvantum/archive/refs/tags/V" version ".tar.gz"))
            (sha256
             (base32
              "0fcmk2qll0r1r1mwqh3ai8ifwavrgj3gm4n456sk8dv83x2kazch"))))
  (build-system qt-build-system)
  (arguments
    '(#:tests? #f
      #:phases
        (modify-phases %standard-phases
          (add-after 'unpack 'patch-cmakelists
            (lambda _
                (chdir "Kvantum")
                (substitute* '("style/CMakeLists.txt") 
                    (("\\$\\{_Qt5_PLUGIN_INSTALL_DIR\\}") 
                      (string-append %output "/lib/qt5/plugins"))) ;; not sure?
              #t)))))
  (inputs
   `(("qtbase" ,qtbase-5)
     ("extra-cmake-modules" ,extra-cmake-modules)
     ("qtdeclarative" ,qtdeclarative)
     ("kwindowsystem" ,kwindowsystem)
     ("qtsvg" ,qtsvg)
     ("pkg-config" ,pkg-config)
     ("qtx11extras" ,qtx11extras)))
  (synopsis " A Linux SVG-based theme engine for Qt and KDE.")
  (description " A Linux SVG-based theme engine for Qt and KDE.")
  (home-page "https://github.com/tsujan/Kvantum/")
  (license license:gpl3+)))
