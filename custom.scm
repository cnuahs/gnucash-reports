;; custom report definition for GnuCash

;; 2015-12-28 - Shaun L. Cloherty <s.cloherty@ieee.org>

(define-module (custom))
(use-modules (custom_imp))

(use-modules (gnucash gnc-module))

(gnc:module-load "gnucash/report/report-system" 0) ; provides gnc:define-report

; get and reload the module
(define (reload-report-module)
  (reload-module (resolve-module 'custom_imp)))
; reload and run options from the module
(define (options_loader)
  (reload-report-module)
  (custom_options))
; reload and run renderer from the module
(define (renderer_loader report-obj)
  (reload-report-module)
  (custom_renderer report-obj))

(gnc:define-report
 ;; version of this report.
 'version 1
 
 ;; the name of this report, used for the reports menu entry
 'name (N_ "Custom Report")

 ;; the GUID of this report, a unique string used to identify this
 ;; report
 ;;
 ;; generated using `uuidgen | sed -e s/-//g`
 'report-guid "D0A26460E9BC46DBAC64A3E0DC5FCD51"
  
 ;; the menu name of this report (overides the name defined above)
 'menu-name (N_ "Custom Report")

 ;; menu tool tip, displayed on mouse over the reports menu entry
 'menu-tip (N_ "Custom Report.")

 ;; the 'path' to the reports menu entry...?
 'menu-path (list gnc:menuname-utility)

 ;; option generator, called on report open?
 'options-generator custom_options

 ;; report generator/renderer, called on report open or reload
 'renderer custom_renderer)
 
;; Local Variables:
;; mode: scheme
;; End:
