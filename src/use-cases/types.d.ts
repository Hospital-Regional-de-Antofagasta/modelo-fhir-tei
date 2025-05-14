type PacienteExtraido = {
  nombre: string | null;
  apellido_paterno: string | null;
  apellido_materno: string | null;
  nombre_social: string | null;
  identificadores: {
    id_tipo_identificador: string;
    id_uso: string;
    valor: string;
    id_pais_emisor_documento: string;
  }[];
  fecha_nacimiento: string;
  id_sexo_biologico: string;
  id_identidad_genero: string;
  id_nacionalidad: string;
  id_pais_origen: string;
  id_religion: string;
  pertenece_a_pueblo_originario: boolean;
  pertenece_a_pueblo_afrodescendiente: boolean;
  id_pueblo_originario: string;
};

type TransactionOrConnectionPool =
  | import("mssql").Transaction
  | import("mssql").ConnectionPool;
