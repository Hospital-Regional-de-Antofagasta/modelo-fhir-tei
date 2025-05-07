
IF OBJECT_ID('dbo.TAB_FHIR_Lenguaje') IS NULL BEGIN
  CREATE TABLE [dbo].[TAB_FHIR_Lenguaje]
  (
    Id SMALLINT CONSTRAINT PK_FHIR_LENGUAJE PRIMARY KEY,
    Codigo VARCHAR(5) NOT NULL UNIQUE,
    Nombre VARCHAR(50) NOT NULL,
    Detalle VARCHAR(100) NOT NULL,
    Vigente BIT DEFAULT 1 NOT NULL,

    [CreatedBy] [VARCHAR](10) CONSTRAINT FK_FHIR_LENGUAJE_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
  );

  EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'https://hl7chile.cl/fhir/ig/clcore/1.9.2/ValueSet-VSCodigoslenguaje.html' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_FHIR_Lenguaje', @level2type=N'COLUMN',@level2name=N'Codigo'

  INSERT INTO [dbo].[TAB_FHIR_Lenguaje]
    (Id, Codigo, Nombre, Detalle)
  VALUES
    (1, 'ar-SA', 'Arabic', 'Saudi Arabia, Arabic (Saudi Arabia)'),
    (2, 'bn-BD', 'Bangla', 'Bangladesh, Bangla (Bangladesh)'),
    (3, 'bn-IN', 'Bangla', 'India, Bangla (India)'),
    (4, 'cs-CZ', 'Czech', 'Czech Republic, Czech (Czech Republic)'),
    (5, 'da-DK', 'Danish', 'Denmark, Danish (Denmark)'),
    (6, 'de-AT', 'German', 'Austria, Austrian German'),
    (7, 'de-CH', 'German', 'Switzerland, Swiss German'),
    (8, 'de-DE', 'German', 'Germany, Standard German (as spoken in Germany)'),
    (9, 'el-GR', 'Greek', 'Greece, Modern Greek'),
    (10, 'en-AU', 'English', 'Australia, Australian English'),
    (11, 'en-CA', 'English', 'Canada, Canadian English'),
    (12, 'en-GB', 'English', 'United Kingdom, British English'),
    (13, 'en-IE', 'English', 'Ireland, Irish English'),
    (14, 'en-IN', 'English', 'India, Indian English'),
    (15, 'en-NZ', 'English', 'New Zealand, New Zealand English'),
    (16, 'en-US', 'English', 'United States, US English'),
    (17, 'en-ZA', 'English', 'South Africa, English (South Africa)'),
    (18, 'es-AR', 'Spanish', 'Argentina, Argentine Spanish'),
    (19, 'es-CL', 'Spanish', 'Chile, Chilean Spanish'),
    (20, 'es-CO', 'Spanish', 'Columbia, Colombian Spanish'),
    (21, 'es-ES', 'Spanish', 'Spain, Castilian Spanish (as spoken in Central-Northern Spain)'),
    (22, 'es-MX', 'Spanish', 'Mexico, Mexican Spanish'),
    (23, 'es-US', 'Spanish', 'United States, American Spanish'),
    (24, 'fi-FI', 'Finnish', 'Finland, Finnish (Finland)'),
    (25, 'fr-BE', 'French', 'Belgium, Belgian French'),
    (26, 'fr-CA', 'French', 'Canada, Canadian French'),
    (27, 'fr-CH', 'French', 'Switzerland, Swiss French'),
    (28, 'fr-FR', 'French', 'France, Standard French (especially in France)'),
    (29, 'he-IL', 'Hebrew', 'Israel, Hebrew (Israel)'),
    (30, 'hi-IN', 'Hindi', 'India, Hindi (India)'),
    (31, 'hu-HU', 'Hungarian', 'Hungary, Hungarian (Hungary)'),
    (32, 'id-ID', 'Indonesian', 'Indonesia, Indonesian (Indonesia)'),
    (33, 'it-CH', 'Italian', 'Switzerland, Swiss Italian'),
    (34, 'it-IT', 'Italian', 'Italy, Standard Italian (as spoken in Italy)'),
    (35, 'jp-JP', 'Japanese', 'Japan, Japanese (Japan)'),
    (36, 'ko-KR', 'Korean', 'Republic of Korea, Korean (Republic of Korea)'),
    (37, 'nl-BE', 'Dutch', 'Belgium, Belgian Dutch'),
    (38, 'nl-NL', 'Dutch', 'The Netherlands, Standard Dutch (as spoken in The Netherlands)'),
    (39, 'no-NO', 'Norwegian', 'Norway, Norwegian (Norway)'),
    (40, 'pl-PL', 'Polish', 'Poland, Polish (Poland)'),
    (41, 'pt-BR', 'Portugese', 'Brazil, Brazilian Portuguese'),
    (42, 'pt-PT', 'Portugese', 'Portugal, European Portuguese (as written and spoken in Portugal)'),
    (43, 'ro-RO', 'Romanian', 'Romania, Romanian (Romania)'),
    (44, 'ru-RU', 'Russian', 'Russian Federation, Russian (Russian Federation)'),
    (45, 'sk-SK', 'Slovak', 'Slovakia, Slovak (Slovakia)'),
    (46, 'sv-SE', 'Swedish', 'Sweden, Swedish (Sweden)'),
    (47, 'ta-IN', 'Tamil', 'India, Indian Tamil'),
    (48, 'ta-LK', 'Tamil', 'Sri Lanka, Sri Lankan Tamil'),
    (49, 'th-TH', 'Thai', 'Thailand, Thai (Thailand)'),
    (50, 'tr-TR', 'Turkish', 'Turkey, Turkish (Turkey)'),
    (51, 'zh-CN', 'Chinese', 'China, Mainland China, simplified characters'),
    (52, 'zh-HK', 'Chinese', 'Hond Kong, Hong Kong, traditional characters'),
    (53, 'zh-TW', 'Chinese', 'Taiwan, Taiwan, traditional characters');
END