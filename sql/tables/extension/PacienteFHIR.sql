

CREATE TABLE [dbo].[PacienteFHIR](
    Id UNIQUEIDENTIFIER DEFAULT NEWID() CONSTRAINT PK_PACIENTEFHIR PRIMARY KEY,
    NumeroPaciente FLOAT NOT NULL,
    
    /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.id */
    FHIR_Id VARCHAR(64) NOT NULL UNIQUE,

    /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.link */
    FHIR_Link VARCHAR(MAX) NULL,

    /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.generalPractitioner */
    FHIR_GeneralPractitioner VARCHAR(MAX) NULL,

    /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.gender */
    FHIR_IdGeneroAdministrativo [TINYINT] NULL,

    /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.address */
    FHIR_Address VARCHAR(MAX) NULL,
    
    /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.telecom */
    FHIR_Telecom VARCHAR(MAX) NULL,

    /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.communication */
    FHIR_Communication VARCHAR(MAX) NULL,
);