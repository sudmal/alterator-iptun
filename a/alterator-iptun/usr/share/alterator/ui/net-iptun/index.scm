(document:surround "/std/frame")

(edit visibility #f name "new_name")
(gridbox 
  columns "100"
  margin 10

  (button text (_ "New connection...") align "left" name "new_button")
  (separator)

  (splitbox 
    columns "30;70"
    (listbox name "name")
    (gridbox 
      columns "0;100"
      ;;
      (label text (_ "Status:") align "right")
      (hbox align "left"
	    (label bold name "info")
	    (combobox name "status"))
      ;;
      (label text (_ "Description:") align "right" name "descr")
      (edit name "descr")
      ;;
      (label text (_ "IP Address:") align "right" name "ipv4address")
      (edit name "ipv4address")
      ;;
      (label text (_ "TUN Local IP:") align "right" name "tunlocal")
      (edit name "tunlocal")
      ;;
      (label text (_ "TUN Remote IP:") align "right" name "tunremote")
      (edit  name "tunremote")
      ;;
      (label text (_ "TUN Type:") align "right" name "tuntype")
      (edit  name "tuntype")
      ;;
      (label text (_ "Type:") align "right" name "tuntype")
      (edit  name "type")
      ;;
      (label text (_ "TUN MTU:") align "right" name "tunmtu")
      (edit  name "tunmtu")
      ;;
      (label text (_ "TUN MTU:") align "right" name "tunoptions")
      (edit  name "tunoptions")
      ;;
      (spacer)
      (label text (_ "Disable") align "right" name "disable")
      (edit  name "disable")
      ;;
      (label colspan 2)
      ;;
      (spacer)
      (hbox
	align "left"
	  (button text (_ "Apply") name "apply_button")
	  (button text (_ "Reset") name "reset_button")
	(label text "    ")
	(button text (_ "Delete connection") name "del_button")))))

