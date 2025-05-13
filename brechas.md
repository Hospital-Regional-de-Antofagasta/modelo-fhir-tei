# Brechas en soporte de datos

## Modelo actual del paciente

### Domicilio

- ❌ No admite más de un domicilio
- ❌ No hay donde guardar el 'periodo de tiempo durante el cual es válida la dirección entregada' (period)
- ✅ El nuevo modelo admite múltiples domicilios

### Medio de contacto

- ❌ No admite más de 2 telefonos, siendo uno un teléfono de casa y el otro un telefono movil
- ❌ No hay donde guardar el uso ni el orden de preferencia del telefono
- ❌ No admite más de un correo electrónico
- ❌ No hay donde guardar el uso ni el orden de preferencia del correo
- ✅ El nuevo modelo admite múltiples telefonos y correos

### Identificador (Al menos 1 requerido)

- ❌ No admite más de 2 identificadores, siendo estos el 'PASAPORTE' y el 'RUN' (este útlimo puede ser RUN o RUN provisorio, no guarda ambos por separado)
- ❌ No hay donde guardar el uso del identificador (aunque es opcional)
- 👀 El campo de RUT no es fiable al 100% ya que pueden existir RUTs invalidos (por ejemplo, '00000000-0')
- ✅ El nuevo modelo admite múltiples identificadores

### Nombre

- ❌ No guarda los nombres del paciente por separado
- 👀 Se debe modificar el sistema 'Indice de Pacientes' para que los nuevos nombres se guarden por separado
- 👀 De momento simplemente tributar los nombres de pacientes como uno solo
- ✅ El nuevo modelo contempla un campo para guardar los nombres separados por caracter especial

### Pertenece a un pueblo afrodescendiente

- ❌ No admite el indicador de si el paciente pertenece a un pueblo afrodescendiente
- ✅ El nuevo modelo admite el campo
- 👀 No es necesario asumir algún valor para los pacientes actuales dado que el campo es opcional

### Pertenece a un pueblo originario (Requerido)

- ❌ No admite el indicador de si el paciente pertenece a un pueblo originario
- 👀 Se puede asumir que si el paciente tiene un pueblo originario seleccionado, entonces pertenece a un pueblo originario
- 👀 Para los demás casos, habría que asumir que no pertenece
- ✅ El nuevo modelo admite el campo por separado

### Nacionalidad (Requerido)

- ❌ No admite el campo 'Nacionalidad'
- 👀 No es posible asumir la nacionalidad
- ✅ El nuevo modelo admite el campo

### Contactos

- ❌ No hay donde guardar los 'contactos' (personas) de un paciente
- ❌ Lo más parecido es 'familiares', pero todas las relaciones serían tributadas como 'next of kin', y habría que ignorar los registros con relación 'mismo paciente'
- ✅ El nuevo modelo admite múltiples contactos

## Prestador

### Fecha de nacimiento (Requerido)

- ❌ No admite la fecha de nacimiento
- ❌ No es posible asumir la fecha de nacimiento, tampoco podemos mandar un valor por defecto.
- 👀 Quizas sea posible extraer este dato mediante scraping hacia RNPI
- ✅ El nuevo modelo admite la fecha de nacimiento

### Identidad de genero

- ❌ No admite la identidad de genero
- ✅ El nuevo modelo admite la identidad de genero

### Nacionalidad

- ❌ No admite la nacionalidad
- ✅ El nuevo modelo admite la nacionalidad

### Sexo biologico

- ❌ No admite el sexo biologico
- ✅ El nuevo modelo admite el sexo biologico

### Identificador (RUT Requerido)

- ❌ No admite el identificador RNPI
- ❌ Existen RUTs invalidos
- 👀 Es posible corregir la mayoria de estos casos
- ✅ El nuevo modelo admite los identificadores RUT y RNPI

### Domicilio

- ❌ No admite más de un domicilio
- ✅ El nuevo modelo admite multiples domicilios

### Medio de contacto

- ❌ No admite más de un telefono
- ✅ El nuevo modelo admite multiples medios de contacto

### Titulo profesional (Requerido para prestador profesional)

- ❌ No admite el titulo profesional
- ❌ No es posible asumir el titulo profesional
- 👀 Quizas sea posible extraer este dato mediante scraping hacia RNPI
- ✅ El nuevo modelo admite el titulo profesional

## Brechas en tributación de eventos

El sistema SICLOPE debe actualizarse para permitir lo siguiente

- Al momento de crear la solicitud de interconsulta, debe tributar el evento **iniciar** y **referenciar**
- Al momento de registrar la atención del paciente, debe tributar el evento **atender** y **terminar**

El nuevo sistema de agenda cuenta con los módulos que permiten **revisar**, **priorizar** y **agendar** una solicitud de interconsulta.

- El módulo **revisar** solo está disponible para las SIC que sean generadas desde el mismo hospital
- Los módulo **priorizar** y **agendar** están disponible para todas las SIC

Queda pendiente la tributación del evento **terminar** cuando el motivo de cierre es distinto de _Atención Realizada_.
Por ejemplo, está pendiente determinar como se manejará el proceso para las solicitudes de interconsulta que sean para pacientes GES. ¿En que módulo se debe manejar esta acción y que usuario debe realizarla?

## Problemas encontrados

- No hay forma confiable de comparar domicilios ni medios de contacto de un paciente que vengan en el bundle 'iniciar enriquecido' con los domicilios y medios de contacto del mismo paciente registrados en el sistema del hospital, ya que no cuentan con un identificador que los diferencie. Esto también aplica para el caso del prestador.

- Pasa lo mismo con los contactos (personas) de un paciente, ya que la guía de implementación tiene como opcional el identificador del contacto, no es posible identificarlos.

- Para pacientes con RUT invalido o RUT 0 no es posible tributar una solicitud de interconsulta nueva, ya que la guía de implementación exige un identificador. Del resto de identificadores es posible enviar:

  - El numero de pasaporte
  - El RUT de la madre (en caso de haber ingresado una como familiar)
  - "Número de Ficha Clínica Sistema Local" (número de ficha), ¿pero como se distingue del mismo tipo de identificador en otro establecimiento?

## TODO

### Atender
- Modificar SICLOPE para exigir uno o más diagnosticos CIE10 (https://interoperabilidad.minsal.cl/fhir/ig/tei/0.2.1/ValueSet-VSTerminologiasDiag.html)
- Modificar SICLOPE para exigir cero o más solicitudes de exámenes LOINC (https://interoperabilidad.minsal.cl/fhir/ig/tei/0.2.1/ValueSet-CodigoExamen.html)
- ❔ Si en la atención primaria se determina que el paciente padece de una intolerancia/alergia, es requerido que esta misma información sea enviada en el evento "atender"?
- ❔ si en la atención primaria se solicitaron examenes, es requerido que estén los resultados en 'observación resultado de examen' en el evento "atender"?









