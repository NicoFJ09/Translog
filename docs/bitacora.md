# Bitácora - TransLog

**Equipo de Desarrollo: David, Fabiola, Nicolas, Tamara**

**Viernes 10 de octubre**
Recolección de información para la creación del dataset para las palabras de español e ingles. 

**Sabado 11 de octubre**
Establecimiento de dataset mínimo para las palabras a utilizar en el proyecto.

**Miercoles 15 de octubre**
Establecimieno de requerimientos y planificación de tareas para cada integrante del equipo. Se distribuyen las tareas de la siguiente manera:
- David: Artículos y Adjetivos
- Fabiola: Verbos
- Nicolas: Estructura general de la lógica e integración simple con el BNF
- Tamara: Preprocesamiento y numeros.
**16 de octubre** 
- David: Se revisaron los requerimientos para implementar la concordancia y el reordenamiento de los sintagmas tanto de ingles a español como viceversa
- Fabiola: Se repasaron y establecieron las reglas para los verbos en presente, tanto en español e ingles. 
- Tamara: Se realizaron los procedimientos de pre-procesamiento lo que incluye ignorar tildes y caracteres especiales, y convertir mayusculas a minusculas. Y se confecciono la interfaz grafica.
- Nicolas: Se realizaron correcciones relacionadas con el orden de los artículos en las traducciones, trabajo que posteriormente se integró con la implementación de concordancia de David. 


**17 de octubre**
- David: Se implemento la logica de los adjetivos y de los concordancia para las oraciones ademas de ejecutar tests simples con frases como "el gato gordo", y se hicieron metodos para traducir y verificar el sentido de las oraciones simples, se utilizaran oraciones completas hasta que este toda la logica implementada y el BNF. Ademas se expandio la base de datos añadiendo mas articulos y adjetivos.
- Fabiola: Se implementó la logica para la conjugación de verbos en presente, tanto en español como en inglés y se realizaron pruebas simples para verificar la correcta conjugación de las palabras agregadas a la base de datos. Además, se realizó la logica para la lematización de los verbos en ambas lenguas.

**20 de octubre**
- Tamara: Se implemento la deteccion y traduccion de numeros del 0 al cien en oraciones que usen numeros como una cantidad unicamente.

**21 de octubre**
- David: Se realizo una reestructuracion del codigo ya que estaba todo muy disperso en documentos .pl por eso se decidio sintetizar y eliminar mucho archivos vacios y otro con codigo que no era necesario y mas bien generaba confusion al momento de intentar la integracion. Esta limpieza quito muchas cosas entre esas mi trabajo pero se realizo de nuevo de manera mas ordenada para que no hubieran tantos problemas sintetizando la mayoria de la logica en el archivo traductor.pl.
- Fabiola: Después de la reestructuración del código, se procedió a integrar la lógica de los verbos en presente dentro del archivo principal de conjugador y la incorporación de los mismos al nuevo traductor. Se realizaron pruebas adicionales para asegurar que la conjugación, lematización y traducción funcionaran correctamente en el nuevo formato.
- Nicolas: Se participó activamente en la limpieza general del repositorio, consolidando la estructura dispersa en los archivos definitivos: conjugador.pl, sintagmas.pl y traductor.pl. Se creó un archivo BNF.pl básico para la interfaz de usuario y se implementó soporte completo para oraciones afirmativas con todos los componentes integrados. 

**22 de octubre**
- David: Se reviso los requerimientos faltantes asi como la documentacion, se termino el proyecto agregando lo faltante en este caso las reglas para preguntas y para negacion. Se realizaron pruebas de oraciones para verificar el funcionamiento correcto de la logica implementada.
- Fabiola: Despues de la revisión de los requerimientos faltantes se comenzó el trabajo de la documentación del proyecto y revisión de bitacora.
- Nicolas: Se trabajó de forma complementaria en la lógica completa para oraciones negativas e interrogativas, finalizando el soporte para todos los tipos de oraciones posibles. Además, se implementó el manejo de múltiples oraciones separadas por puntuación en una misma entrada.





