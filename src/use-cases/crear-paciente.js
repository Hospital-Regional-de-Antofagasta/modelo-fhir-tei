import mssql from "mssql";

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {Omit<PacienteExtraido, 'identificadores'>} pacienteExtraido
 * @returns {Promise<{ numero_paciente: string }>}
 */
export async function crearPaciente(tran, pacienteExtraido) {
  const {
    nombre,
    apellido_paterno,
    apellido_materno,
    fecha_nacimiento,
    id_sexo_biologico,
    id_identidad_genero,
    id_nacionalidad,
    id_pais_origen,
    id_religion,
    pertenece_a_pueblo_originario,
    pertenece_a_pueblo_afrodescendiente,
    id_pueblo_originario,
  } = pacienteExtraido;
  const resultado = (
    await tran
      .request()
      .input("Nombre", mssql.VarChar(40), nombre)
      .input("ApellidoPaterno", mssql.VarChar(20), apellido_paterno)
      .input("ApellidoMaterno", mssql.VarChar(20), apellido_materno)
      .input("FechaNacimiento", mssql.DateTime, fecha_nacimiento)
      .input("IdSexoBiologico", mssql.TinyInt, id_sexo_biologico)
      .input("IdIdentidadGenero", mssql.TinyInt, id_identidad_genero)
      .input("IdNacionalidad", mssql.SmallInt, id_nacionalidad)
      .input("IdPaisOrigen", mssql.SmallInt, id_pais_origen)
      .input("IdReligion", mssql.TinyInt, id_religion)
      .input(
        "PerteneceAPuebloOriginario",
        mssql.Bit,
        pertenece_a_pueblo_originario
      )
      .input(
        "PerteneceAPuebloAfrodescendiente",
        mssql.Bit,
        pertenece_a_pueblo_afrodescendiente
      )
      .input("IdPuebloOriginario", mssql.TinyInt, id_pueblo_originario)
      .input("IdEstadoCivil", mssql.TinyInt, null)
      .execute("API_TEIM_CrearPaciente")
  ).recordset;

  return resultado[0];
}
