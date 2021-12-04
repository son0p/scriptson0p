;; Function to convert "BANCOLOMBIA sucursal virtual" format to ledger format

;; SAMPLE OF test.ldg
;;
;; 2021/12/03	SAN LUCAS PLAZA	IMPTO GOBIERNO 4X1000	 	$ -12,685.66
;; 2021/11/30	SAN LUCAS PLAZA	ABONO INTERESES AHORROS	 	$ 2,630.73


(defun procesaExtracto()
  (interactive)
  (find-file "/tmp/test.ldg")

  (goto-char (point-min))
  (while (search-forward "	SAN LUCAS PLAZA	IMPTO GOBIERNO 4X1000	 	" nil t)
    (replace-match " Impuesto 4xmil \n    Gastos:noOper:cta:ahorro               \n    Activos:Banco:ahorro                                         " t)
    ;; optional empty lines before and after
    (forward-line -2)
    (default-indent-new-line)
    (forward-line 3)
    (default-indent-new-line))

  (goto-line (point-min))
  (while (search-forward "	SAN LUCAS PLAZA	ABONO INTERESES AHORROS	 	" nil t)
    (replace-match " Interes ahorro \n    Ingresos:noOper:cta:ahorro               \n    Activos:Banco:ahorro                                         " t)
    (forward-line -2)
    (default-indent-new-line)
    (forward-line 3)
    (default-indent-new-line)))
