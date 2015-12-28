;; custom report implementation for GnuCash

;; 2015-12-28 - Shaun L. Cloherty <s.cloherty@ieee.org>

(define-module (custom_imp))

(use-modules (gnucash gnc-module))

(gnc:module-load "gnucash/report/report-system" 0)
(gnc:module-load "gnucash/html" 0) ; provides gnc-build-url

;; options routine
;;
;; populates the options dialog
(define (custom_options)
  (let* ((options (gnc:new-options))
         ;; a helper function for adding options
         (add-option
          (lambda (new-option)
            (gnc:register-option options new-option))))

		;; this defined a boolean option in the "General" settings section
    (add-option
     (gnc:make-simple-boolean-option
      (N_ "General") (N_ "Boolean Option")
      "a" (N_ "This is a boolean option.") #t))
        
    (gnc:options-set-default-section options "General")
		options))


(define (custom_renderer report-obj)
  ;; helper functions for looking up option values
  (define (get-op section name)
    (gnc:lookup-option (gnc:report-options report-obj) section name))
  
  (define (op-value section name)
    (gnc:option-value (get-op section name)))
  
  (let ((bool-val (op-value "General" "Boolean Option"))
        (document (gnc:make-html-document)))

    (gnc:html-document-set-title! document (_ "Custom Report"))

		(gnc:html-document-add-object! 
		 document 
		 (gnc:make-html-text 
      (gnc:html-markup-p (_ "Custom report template v1.0."))))
		
    (gnc:html-document-add-object!
     document
     (gnc:make-html-text
      (gnc:html-markup-p
       (gnc:html-markup/format
        (_ "The boolean option is %s.")
        (gnc:html-markup-b (if bool-val (_ "true") (_ "false")))))))
		document))


(export custom_options)
(export custom_renderer)

;; Local Variables:
;; mode: scheme
;; End:
