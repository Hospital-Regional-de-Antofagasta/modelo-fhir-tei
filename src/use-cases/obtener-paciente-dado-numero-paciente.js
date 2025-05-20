import mssql from "mssql";

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {string} numeroPaciente
 * @returns {Promise<PacienteEncontradoDadoNumeroPaciente>}
 */
export async function obtenerPacienteDadoNumeroPaciente(tran, numeroPaciente) {
  const pacienteEncontrado = (
    await tran
      .request()
      .input("NumeroPaciente", mssql.Float, numeroPaciente)
      .execute("API_TEIM_ObtenerPacienteDadoNumeroPaciente")
  ).recordset[0];

  if (pacienteEncontrado === undefined) {
    throw new Error("Paciente no encontrado");
  }

  return {
    numero_paciente: pacienteEncontrado.numero_paciente,
    nombre: pacienteEncontrado.nombre ?? undefined,
    apellido_paterno: pacienteEncontrado.apellido_paterno ?? undefined,
    apellido_materno: pacienteEncontrado.apellido_materno ?? undefined,
    nombre_social: pacienteEncontrado.nombre_social ?? undefined,
    fecha_nacimiento: pacienteEncontrado.fecha_nacimiento,
    fecha_fallecimiento: pacienteEncontrado.fecha_fallecimiento ?? undefined,
    id_sexo_biologico: pacienteEncontrado.id_sexo_biologico,
    id_identidad_genero: pacienteEncontrado.id_identidad_genero,
    id_nacionalidad: pacienteEncontrado.id_nacionalidad,
    id_pais_origen: pacienteEncontrado.id_pais_origen,
    id_religion: pacienteEncontrado.id_religion ?? undefined,
    pertenece_a_pueblo_originario:
      pacienteEncontrado.pertenece_a_pueblo_originario,
    pertenece_a_pueblo_afrodescendiente:
      pacienteEncontrado.pertenece_a_pueblo_afrodescendiente ?? undefined,
    id_pueblo_originario: pacienteEncontrado.id_pueblo_originario ?? undefined,
    nombre_otro_pueblo_originario:
      pacienteEncontrado.nombre_otro_pueblo_originario ?? undefined,
  };
}
