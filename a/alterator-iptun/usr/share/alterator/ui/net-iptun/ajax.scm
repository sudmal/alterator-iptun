(define-module (ui net-iptun ajax)
    :use-module (alterator ajax)
    :use-module (alterator woo)
    :export (on-load))

(define (ui-update-activity)
  (let* ((name (form-value "name"))
         (active (and (string? name)
                      (not (string=? "" name)))))
    (form-update-activity "info" active)
    (form-update-activity "status" active)
    (form-update-activity "descr" active)
    (form-update-activity "ipv4address" active)
    (form-update-activity "tunlocal" active)
    (form-update-activity "tunremote" active)
    (form-update-activity "tuntype" active)
    (form-update-activity "type" active)
    (form-update-activity "tunmtu" active)
    (form-update-activity "tunoptions" active)
    (form-update-activity "disable" active)
    (form-update-activity "apply_button" active)
    (form-update-activity "reset_button" active)
    (form-update-activity "del_button" active)))

(define (init-iface)
  (form-update-enum "iface" (woo-list "/net-iptun/avail_iface"))
  (form-update-enum "status" (woo-list "/net-iptun/avail_state" 'language (form-value "language"))))

(define (read-current-iface)
  (read-iface (or (form-value "name") "")))

(define (read-iface name)
  (catch/message
    (lambda()
      (let ((data (woo-read-first "/net-iptun/" 'name name 'language (form-value "language"))))

	(form-update-enum "name" (woo-list "/net-iptun/avail_connection"))
	(form-update-value-list '("name"
				  "new_name"
				  "info"
				  "status"
				  "descr"
				  "ipv4address"
				  "tunlocal"
				  "tunremote"
				  "tuntype"
				  "type"
				  "tunmtu"
				  "tunoptions"
				  "disable")
				data)))))

(define (write-iface)
  (catch/message
    (lambda()
      (apply woo-write "/net-iptun" 'commit #t (form-value-list))
      (read-iface (form-value "name")))))

(define (new-iface)
  (catch/message
    (lambda()
      (let ((new_name (form-value "new_name")))
	(woo-write "/net-iptun" 'new #t 'new_name new_name)
	(read-iface new_name)
    (ui-update-activity)))))

(define (delete-iface)
  (catch/message
    (lambda()
      (woo-write "/net-iptun/" 'delete #t 'name (or (form-value "name") ""))
      (read-iface "")
      (ui-update-activity))))

(define (on-load)
  (form-bind "new_button" "click" new-iface)
  (form-bind "del_button" "click" delete-iface)

  (form-bind "apply_button" "click" write-iface)
  (form-bind "reset_button" "click" read-current-iface)
  (form-bind "name" "change" read-current-iface)

  (init-iface)
  (read-current-iface)
  (ui-update-activity))
