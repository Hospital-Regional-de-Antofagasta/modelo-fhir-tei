
IF OBJECT_ID('dbo.PacienteFHIR') IS NOT NULL BEGIN
    CREATE TABLE [dbo].[PacienteFHIR](
        NumeroPaciente FLOAT NOT NULL CONSTRAINT FK_PACIENTEFHIR_PACIENTE FOREIGN KEY REFERENCES [dbo].[PAC_Paciente]([PAC_PAC_Numero]),
        
        /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.id */
        FHIR_Id VARCHAR(64) PRIMARY KEY,

        /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.link */
        FHIR_Link VARCHAR(MAX) NULL,

        /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.generalPractitioner */
        FHIR_GeneralPractitioner VARCHAR(MAX) NULL,

        /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.gender */
        FHIR_IdGeneroAdministrativo [TINYINT] NULL CONSTRAINT FK_PACIENTEFHIR_GENEROADMINISTRATIVO FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_SexoBiologico]([Id]),

        /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.address */
        FHIR_Address VARCHAR(MAX) NULL,
        
        /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.telecom */
        FHIR_Telecom VARCHAR(MAX) NULL,

        /* https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.communication */
        FHIR_Communication VARCHAR(MAX) NULL,
    );
END