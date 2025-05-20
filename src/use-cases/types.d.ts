type PacienteExtraido = {
  nombre?: string;
  apellido_paterno?: string;
  apellido_materno?: string;
  nombre_social?: string;
  identificadores: IdentificadorPacienteExtraido[];
  fecha_nacimiento: string;
  id_sexo_biologico: string;
  id_identidad_genero: string;
  id_nacionalidad: string;
  id_pais_origen: string;
  id_religion?: string;
  pertenece_a_pueblo_originario: boolean;
  pertenece_a_pueblo_afrodescendiente?: boolean;
  id_pueblo_originario?: string;
  nombre_otro_pueblo_originario?: string;
};

type IdentificadorPacienteExtraido = {
  id_tipo_identificador: string;
  id_uso?: string;
  valor: string;
  id_pais_emisor_documento: string;
};

type SolicitudInterconsultaExtraida = {
  numero_paciente: number;
  id_motivo_cierre_interconsulta: string;
  requiere_examen: boolean;
  es_atencion_preferente: boolean;
  tiene_resolutividad_aps: boolean;
  referencia_origen: string;
  fundamento_priorizacion: string;
  id_especialidad_destino: string;
  id_subespecialidad_destino?: string;
  modalidad_atencion: string;
  prioridad: string;
  referencia_destino: string;
  motivo_derivacion: string;
  fhir_id: string;
  fhir_identifier_minsal: string;
  fhir_identifier_origin: string;
  created_by: string;
};

type TransactionOrConnectionPool =
  | import("mssql").Transaction
  | import("mssql").ConnectionPool;

type PacienteEncontradoDadoNumeroPaciente = Omit<
  PacienteExtraido,
  "fecha_nacimiento" | "identificadores"
> & {
  numero_paciente: string;
  fecha_nacimiento: Date;
  fecha_fallecimiento?: Date;
};
