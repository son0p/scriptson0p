  (defun derivados-pago ()
    "A partir de la informacion de pago genera una entrada en el archivo de
contabilidad, crea un archivo de texto con la información de pago, y envía un correo.

La entrada al archivo de contabilidad ej: cuentas.ldg es en  formato ledger-cli,
el archivo de información de pago es formato texto, extensión .txt y el nombre
en formato AAAA-MM-DD <período> <objeto de pago> v <valor> -- <tag1> <tag2>.txt
el correo genera el asunto a partir de la información del comprobante, pega
la información de pago y adjunta el archivo de texto correspondiente a la
transacción"
  (interactive )
  (progn
    (setq
     paste (concat "\n" (read-from-minibuffer "Pega información de pago: ") "\n\n")
     period (read-from-minibuffer "Período: ")
     entity (read-from-minibuffer "Objeto de pago/Entidad: ")
     ledger-val (read-from-minibuffer "Valor: ")
     val (replace-regexp-in-string "\\$\\|\\,\\|\\.00" "" ledger-val) ;; convierte moneda a numero, $123,456.00  a 123456
     number-to-words (replace-regexp-in-string "	" ""
                                               (shell-command-to-string
                                                (concat "numero_a_palabras" " " val))) ;; convierte numero a letras usando script "numero_a_palabras"
     ledger-account "  Expenses:                       " ;; cuenta a donde ingresa
     ledger-asset "  Assets:Banco:ahorro:0609        "   ;; cuenta de donde sale
     tag1 (read-from-minibuffer "tag1: ")
     tag2 (read-from-minibuffer "tag2: ")
     subject (concat ":pago:" tag1 ":" tag2 ": " period " " entity ) ;; asunto para el correo
     tags (concat " -- " tag1 " " tag2 " " ) ;; tags para el archivo .txt
     ext  ".txt"
     date (format-time-string "%Y-%m-%d ")
     path  "~/mi/ruta/comprobantes/"  ;; ruta para guardar el archivo
     path2 "~/mi/ruta/cuentas.ldg"  ;; ruta del archivo de contabilidad para agregar la entrada
     fpath (concat path date period " " entity " " "v " val " " tags ext)) ;; construye el nombre del archivo .txt
    (write-region paste nil fpath) ;; create empty file
    (write-region
     (concat "\n" date "PAGO " period " " entity "\n"
             ledger-account ledger-val "\n" ledger-asset "-" ledger-val "\n")  nil path2 'append)  ;; hace el ingreso con formato ledger-cli
    ;; inicia el servidor, conforma el correo, evia con C-c C-c
    (setq smtpmail-stream-type 'ssl)
    (setq smtpmail-smtp-server "smtp.gmail.com")
    (setq smtpmail-smtp-service 465)
    (mail)
    (compose-mail "miCorreo@gmail.com" subject nil nil nil nil nil nil)
    (mail-text) (insert paste)
    (mml-attach-file fpath "text/x-patch" nil "attachment")
    (mail-send)))
