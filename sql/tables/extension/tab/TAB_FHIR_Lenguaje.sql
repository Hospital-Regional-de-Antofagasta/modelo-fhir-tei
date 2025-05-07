
IF OBJECT_ID('dbo.TAB_FHIR_Lenguaje') IS NULL BEGIN
  CREATE TABLE [dbo].[TAB_FHIR_Lenguaje]
  (
    Codigo VARCHAR(5) PRIMARY KEY CHECK (Codigo LIKE '[a-z][a-z]-[A-Z][A-Z]'),
    Nombre VARCHAR(50) NOT NULL,
    Detalle VARCHAR(100) NULL,
    Vigente BIT DEFAULT 1 NOT NULL,

    [CreatedBy] [VARCHAR](10) CONSTRAINT FK_LENGUAJE_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
  );

  EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'https://hl7chile.cl/fhir/ig/clcore/1.9.2/ValueSet-VSCodigoslenguaje.html' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_FHIR_Lenguaje', @level2type=N'COLUMN',@level2name=N'Codigo'

  INSERT INTO [dbo].[TAB_FHIR_Lenguaje]
    (Codigo, Nombre, Detalle)
  VALUES
    ('ar-SA', 'Arabic', 'Saudi Arabia, Arabic (Saudi Arabia)'),
    ('bn-BD', 'Bangla', 'Bangladesh, Bangla (Bangladesh)'),
    ('bn-IN', 'Bangla', 'India, Bangla (India)'),
    ('cs-CZ', 'Czech', 'Czech Republic, Czech (Czech Republic)'),
    ('da-DK', 'Danish', 'Denmark, Danish (Denmark)'),
    ('de-AT', 'German', 'Austria, Austrian German'),
    ('de-CH', 'German', 'Switzerland, Swiss German'),
    ('de-DE', 'German', 'Germany, Standard German (as spoken in Germany)'),
    ('el-GR', 'Greek', 'Greece, Modern Greek'),
    ('en-AU', 'English', 'Australia, Australian English'),
    ('en-CA', 'English', 'Canada, Canadian English'),
    ('en-GB', 'English', 'United Kingdom, British English'),
    ('en-IE', 'English', 'Ireland, Irish English'),
    ('en-IN', 'English', 'India, Indian English'),
    ('en-NZ', 'English', 'New Zealand, New Zealand English'),
    ('en-US', 'English', 'United States, US English'),
    ('en-ZA', 'English', 'South Africa, English (South Africa)'),
    ('es-AR', 'Spanish', 'Argentina, Argentine Spanish'),
    ('es-CL', 'Spanish', 'Chile, Chilean Spanish'),
    ('es-CO', 'Spanish', 'Columbia, Colombian Spanish'),
    ('es-ES', 'Spanish', 'Spain, Castilian Spanish (as spoken in Central-Northern Spain)'),
    ('es-MX', 'Spanish', 'Mexico, Mexican Spanish'),
    ('es-US', 'Spanish', 'United States, American Spanish'),
    ('fi-FI', 'Finnish', 'Finland, Finnish (Finland)'),
    ('fr-BE', 'French', 'Belgium, Belgian French'),
    ('fr-CA', 'French', 'Canada, Canadian French'),
    ('fr-CH', 'French', 'Switzerland, Swiss French'),
    ('fr-FR', 'French', 'France, Standard French (especially in France)'),
    ('he-IL', 'Hebrew', 'Israel, Hebrew (Israel)'),
    ('hi-IN', 'Hindi', 'India, Hindi (India)'),
    ('hu-HU', 'Hungarian', 'Hungary, Hungarian (Hungary)'),
    ('id-ID', 'Indonesian', 'Indonesia, Indonesian (Indonesia)'),
    ('it-CH', 'Italian', 'Switzerland, Swiss Italian'),
    ('it-IT', 'Italian', 'Italy, Standard Italian (as spoken in Italy)'),
    ('jp-JP', 'Japanese', 'Japan, Japanese (Japan)'),
    ('ko-KR', 'Korean', 'Republic of Korea, Korean (Republic of Korea)'),
    ('nl-BE', 'Dutch', 'Belgium, Belgian Dutch'),
    ('nl-NL', 'Dutch', 'The Netherlands, Standard Dutch (as spoken in The Netherlands)'),
    ('no-NO', 'Norwegian', 'Norway, Norwegian (Norway)'),
    ('pl-PL', 'Polish', 'Poland, Polish (Poland)'),
    ('pt-BR', 'Portugese', 'Brazil, Brazilian Portuguese'),
    ('pt-PT', 'Portugese', 'Portugal, European Portuguese (as written and spoken in Portugal)'),
    ('ro-RO', 'Romanian', 'Romania, Romanian (Romania)'),
    ('ru-RU', 'Russian', 'Russian Federation, Russian (Russian Federation)'),
    ('sk-SK', 'Slovak', 'Slovakia, Slovak (Slovakia)'),
    ('sv-SE', 'Swedish', 'Sweden, Swedish (Sweden)'),
    ('ta-IN', 'Tamil', 'India, Indian Tamil'),
    ('ta-LK', 'Tamil', 'Sri Lanka, Sri Lankan Tamil'),
    ('th-TH', 'Thai', 'Thailand, Thai (Thailand)'),
    ('tr-TR', 'Turkish', 'Turkey, Turkish (Turkey)'),
    ('zh-CN', 'Chinese', 'China, Mainland China, simplified characters'),
    ('zh-HK', 'Chinese', 'Hond Kong, Hong Kong, traditional characters'),
    ('zh-TW', 'Chinese', 'Taiwan, Taiwan, traditional characters');
END