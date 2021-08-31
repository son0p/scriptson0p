# tt

is a script for timing task with leadger using in bash .

you need change line 83 , to fix filename to write the tasks
	
	[ "$TIMELOG" ] && timelog="$TIMELOG" || timelog="${HOME}< path >timelog.ldg"

### use

**add task** to timeng you need have creted the file and run *bash tt in < task >* , exameple

	bash tt in study:math

**end clock** use *bash tt out* , tt know what you finsh .

**see data** for see for all use bal.

	in:
		bash tt bal
	out example
              25.12h  proyectos
               4.13h    BePPmiNAir
               13.0m    SandCripts
               57.7m    colegio_euskadi:Documentar_QRs
              18.11h    comunitarios
               16.4m      15lucas:letrero
               2.90h      AQA
               41.2m        app
               2.02h        codigo
               11.3m        dialogar
              10.04h      Unloquer
               23.0m        docuemntar
               9.65h        garajevirtual
               4.89h      attrez
                 50s      tt
               1.70h    my_good_site
                7.5m      diseño
               1.58h      issues
--------------------
              29.35h
(29.35h but i dont add all data ;-) )

to see all timing in day use hours

	in:
 		bash tt hours
	example
                1.4m  U:calculo
                2.5m  proyectos:comunitarios:tt
--------------------
                3.8m

### file 

in file you get data in format like i/o:datetime :task

like this 
		
		i 2021/08/26 21:25:33 U:calculo  
		o 2021/08/26 21:35:44 
		i 2021/08/30 21:14:38 proyectos:comunitarios:tt  
		o 2021/08/30 21:17:03 
		i 2021/08/30 21:17:11 U:calculo  
		o 2021/08/30 21:18:33 
		i 2021/08/30 21:18:36 proyectos:comunitarios:tt  


 