# _Terraform Challenge_
### _Eduard Hernández Mejias_

## _Descripción_

Ahora si estudiantes, es la hora del hands-on! vamos a provisionar infraestructura de forma automatizada por medio de algun tool de Continuous Integration para aplicar los conocimientos adquiridos en el curso de CI.

### Objetivo

Lograr el provisionamiento de Infraestructura utilizando Terraform en conjunto a un sistema de Continuous Integration.

### Rubros a Calificar
- Utilización de un tool de CI, puede ser Jenkins / Github Actions / algún otro de su preferencia.
- No olviden que necesitan guardar la informacion sensible en el CI Tool, manteniendo informacion sensible a salvo. 
- Pipeline integrado al repositorio de Github, debe realizar accionar un job con un commit al repositorio.
- Repositorio debe contener los branches necesarios para el desarrollo del codigo SIN provisionar infraestructura, y un branch principal en el cual se crea la infraestructura
- Antes de cualquier ejecucion en Produccion, se debe primero crear un pull request en donde se ejecute un pipeline y al dar OK se pueda hacer Merge al branch de Produccion, de otra forma debe bloquarse el Merge.
- Infraestructura creada con Terraform, como un extra pueden instalar algun software en el recurso creado, o bien, poder hacer signin en caso de una VM.
- El pipeline debe contener la lógica para poder destruir la infraestructura.
- Adjuntar el Diagrama generado por Terraform con el comando terraform graph
- Pueden agregar a otro compañero como un reviewer de su código para fomentar la participacion entre ustedes y puedan revisarse y dar feedback unos a otros.


### Entregables
- Mini exposicion sobre la solucion lograda.
- Repositorio en Github con los archivos correspondientes (archivos.tf, terraform diagram)