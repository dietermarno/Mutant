VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Domain"
Attribute VB_GlobalNameSpace = True
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

'***********************
'* Declarações públicas
'***********************
Public CountryInfo As String
Public LastStatus As Boolean
Public LastError As String
Public TotalRegisters As Long
Public ActualRegister As Long
Public SavedCountries As ADODB.Recordset
Public SavedLanguages As ADODB.Recordset

Public Function SaveDatatoDB() As Boolean

    '**************
    '* Declarações
    '**************
    Dim oParametersCountry() As New ADODB.Parameter
    Dim oParametersLanguages() As New ADODB.Parameter
    Dim oNodeListCountries As IXMLDOMNodeList
    Dim oNodeListLanguages As IXMLDOMNodeList
    Dim oXMLParser As New DOMDocument60
    Dim oDBManager As New DBManager
    Dim oNodeLanguage As IXMLDOMNode
    Dim oNodeCountry As IXMLDOMNode
    Dim Count As Long
    Dim sSQL As String
    Dim index As Long

    '*****************
    '* Inicia conexão
    '*****************
    LogWrite "Info", "Obtendo conexão do banco de dados..." & oDBManager.sConnection
    oDBManager.GetConnection
    LogWrite "Info", "Conexão: " & oDBManager.sConnection
    
    '*********************
    '* Percorre registros
    '*********************
    LogWrite "Info", "Carregando XML..."
    SaveDatatoDB = oXMLParser.loadXML(CountryInfo)
    If Not SaveDatatoDB Then
       LogWrite "Error", "XML não reconhecido ou inválido"
       LastError = "XML not recognized"
       LastStatus = False
       Exit Function
    End If
    
    '*****************************
    '* Limpa registros anteriores
    '*****************************
    LogWrite "Info", "Removendo registros anteriores do banco de dados..."
    sSQL = "DELETE FROM countryLanguages"
    oDBManager.ExecuteCommand sSQL
    sSQL = "DELETE FROM countryInfo"
    oDBManager.ExecuteCommand sSQL
    
    '************************
    '* Obtem lista de países
    '************************
    LogWrite "Info", "Obtendo lista de países a partir do XML..."
    Set oNodeListCountries = oXMLParser.getElementsByTagName("ArrayOftCountryInfo").Item(0).childNodes
    LogWrite "Info", "Total de registros encontrados: " & oNodeListCountries.length
    TotalRegisters = oNodeListCountries.length
    For Each oNodeCountry In oNodeListCountries
    
        '*****************************
        '* Define comando de inserção
        '*****************************
        sSQL = "INSERT INTO countryInfo (ISOCode, name, capitalCity, phoneCode, continentalCode, "
        sSQL = sSQL & "currencyISOCode, countryFlag) VALUES (?, ?, ?, ?, ?, ?, ?)"
        
        '***************************
        '* Cria lista de parâmetros
        '***************************
        ReDim oParametersCountry(6)
        For index = 0 To 6
            Set oParametersCountry(index) = New Parameter
        Next
        
        '********************
        '* Inclui país atual
        '********************
        LogWrite "Info", "Salvando registro de país (ISOCode " & oNodeCountry.selectSingleNode("sISOCode").Text & ")"
        SetParameter oParametersCountry(0), "ISOCode", adVarChar, adParamInput, 2, oNodeCountry.selectSingleNode("sISOCode").Text
        SetParameter oParametersCountry(1), "name", adVarChar, adParamInput, 50, oNodeCountry.selectSingleNode("sName").Text
        SetParameter oParametersCountry(2), "capitalCity", adVarChar, adParamInput, 50, oNodeCountry.selectSingleNode("sCapitalCity").Text
        SetParameter oParametersCountry(3), "phoneCode", adVarChar, adParamInput, 6, oNodeCountry.selectSingleNode("sPhoneCode").Text
        SetParameter oParametersCountry(4), "continentalCode", adVarChar, adParamInput, 2, oNodeCountry.selectSingleNode("sContinentCode").Text
        SetParameter oParametersCountry(5), "currencyISOCode", adVarChar, adParamInput, 3, oNodeCountry.selectSingleNode("sCurrencyISOCode").Text
        SetParameter oParametersCountry(6), "countryFlag", adVarChar, adParamInput, 300, oNodeCountry.selectSingleNode("sCountryFlag").Text
        oDBManager.ExecuteCommandWithParameters sSQL, oParametersCountry
        ActualRegister = Count
        Count = Count + 1
        DoEvents
        
        '********************************
        '* Possui linguagens associadas?
        '********************************
        If oNodeCountry.selectSingleNode("Languages").hasChildNodes Then
        
           '****************************
           '* Obtem lista de linguagens
           '****************************
           LogWrite "Info", "Obtendo lista de linguagens a partir do XML..."
           Set oNodeListLanguages = oNodeCountry.selectSingleNode("Languages").childNodes
           LogWrite "Info", "Total de registros encontrados: " & oNodeListLanguages.length
           For Each oNodeLanguage In oNodeListLanguages
           
               '*****************************
               '* Define comando de inserção
               '*****************************
               sSQL = "INSERT INTO countryLanguages (languageISOCode, countryISOCode, name) "
               sSQL = sSQL & "VALUES (?, ?, ?)"
               
               '***************************
               '* Cria lista de parâmetros
               '***************************
               ReDim oParametersLanguages(2)
               For index = 0 To 2
                   Set oParametersLanguages(index) = New Parameter
               Next
               
               '*************************
               '* Inclui linguagem atual
               '*************************
               LogWrite "Info", "Salvando registro de linguagem (LanguageISOCode " & oNodeLanguage.selectSingleNode("sISOCode").Text & ")"
               SetParameter oParametersLanguages(0), "languageISOCode", adVarChar, adParamInput, 3, oNodeLanguage.selectSingleNode("sISOCode").Text
               SetParameter oParametersLanguages(1), "countryISOCode", adVarChar, adParamInput, 2, oNodeCountry.selectSingleNode("sISOCode").Text
               SetParameter oParametersLanguages(2), "name", adVarChar, adParamInput, 50, oNodeLanguage.selectSingleNode("sName").Text
               oDBManager.ExecuteCommandWithParameters sSQL, oParametersLanguages
               DoEvents
           Next
        End If
    Next
    
    '*****************
    '* Libera objetos
    '*****************
    LogWrite "Info", "Cadastro de países encerrado"
    Set oNodeListCountries = Nothing
    Set oNodeListLanguages = Nothing
    Set oXMLParser = Nothing
    Set oDBManager = Nothing
    Set oNodeLanguage = Nothing
    Set oNodeCountry = Nothing
    Erase oParametersLanguages
    Erase oParametersCountry
End Function

Function SetParameter(ByRef oParameter As ADODB.Parameter, name As String, fieldType As Long, directionType As Long, fieldSize As Long, value As String)

    '****************************
    '* Define dados do parâmetro
    '****************************
    oParameter.name = name
    oParameter.Type = fieldType
    oParameter.Direction = directionType
    oParameter.value = value
    If fieldType = adVarChar Then
       oParameter.Size = fieldSize
    Else
       oParameter.value = Val(value)
    End If
End Function

Function GetFullCountryInfoAllCountries() As Boolean

    '**************
    '* Declarações
    '**************
    Dim oHTTP As New WinHttp.WinHttpRequest
    Dim oXMLParser As New DOMDocument60
    Dim xmlParsed As Boolean
    Dim URL As String
    
    '**************
    '* Trata erros
    '**************
    'On Error Resume Next
    Err.Clear
    
    '*******************
    '* Executa consulta
    '*******************
    LogWrite "Info", "Obtendo dados a partir do webservice..."
    URL = "http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso/FullCountryInfoAllCountries"
    oHTTP.Open "GET", URL
    oHTTP.Send
    CountryInfo = oHTTP.ResponseText
    
    '****************************
    '* Ocorreu erro no processo?
    '****************************
    If Err.Number <> 0 Then
       LogWrite "Error", "Falha ao consultar webservice: " & Err.Description
       GetFullCountryInfoAllCountries = False
       LastError = Err.Description
       LastStatus = False
       
    Else
    
       '**********************
       '* Valida XML recebido
       '**********************
       xmlParsed = oXMLParser.loadXML(CountryInfo)
       
       '****************************
       '* Ocorreu erro no processo?
       '****************************
       If Err.Number <> 0 Then
       
          LogWrite "Error", "Falha ao validar XML: " & Err.Description
          GetFullCountryInfoAllCountries = False
          LastError = Err.Description
          LastStatus = False
       Else
       
          '******************
          '* O XMl foi lido?
          '******************
          If xmlParsed Then
             LogWrite "Info", "Dados XML reconhecidos com sucesso"
             GetFullCountryInfoAllCountries = True
             LastStatus = True
             LastError = ""
          Else
             LogWrite "Error", "Falha ao validar XML: XML não reconhecido"
             GetFullCountryInfoAllCountries = False
             LastStatus = False
             LastError = "XML not recognized"
          End If
       End If
    End If
    
    '*****************
    '* Libera objetos
    '*****************
    Set oHTTP = Nothing
End Function

Sub LogWrite(logType As String, logText As String)

   '**************
   '* Declarações
   '**************
   Dim oFs As New FileSystemObject
   Dim oStream As TextStream
   Dim logFile As String
   Dim logLine As String
   
   '*****************
   '* Controla erros
   '*****************
   On Error Resume Next
   
   '*************************
   '* Define nome do arquivo
   '*************************
   logFile = App.Path & "\" & Format(Now(), "yyyymmdd") & ".log"
   
   '*********************
   '* Monta linha de log
   '*********************
   logLine = "[" & Format(Now(), "dd/mm/yy hh:mm:ss") + "] - " & logType & " - " + logText
  
   '*******************
   '* Executa gravação
   '*******************
   Set oStream = oFs.OpenTextFile(logFile, ForAppending, True)
   oStream.WriteLine logLine
   oStream.Close
   Set oStream = Nothing
   Set oFs = Nothing

   '*****************************
   '* Finaliza controle de erros
   '*****************************
   On Error GoTo 0
End Sub

Sub getSavedCountries(ISOCode As String)

    '**************
    '* Declarações
    '**************
    Dim oDBManager As New DBManager
    Dim sSQL As String
    
    '*****************************
    '* Evita caracteres inválidos
    '*****************************
    ISOCode = SQLFilter(ISOCode)
    
    '*****************
    '* Inicia conexão
    '*****************
    oDBManager.GetConnection
    
    '****************************************************
    '* Obtem lista de países acordo com filtro (ISOCode)
    '****************************************************
    sSQL = "SELECT * FROM countryInfo WHERE ISOCode LIKE '" & ISOCode & "%'"
    Set SavedCountries = oDBManager.ExecutaQuery(sSQL)
    
    '********************************************************
    '* Obtem lista de linguagens acordo com filtro (ISOCode)
    '********************************************************
    sSQL = "SELECT * FROM countryLanguages WHERE countryISOCode IN ("
    sSQL = sSQL & "SELECT ISOCode FROM countryInfo WHERE ISOCode LIKE '" & ISOCode & "%')"
    Set SavedLanguages = oDBManager.ExecutaQuery(sSQL)
    
    '*****************
    '* Libera objetos
    '*****************
    Set oDBManager = Nothing
End Sub

Function SQLFilter(SQLString As String) As String
    
    '*****************************
    '* Remove todos os apóstrofos
    '*****************************
    SQLFilter = Replace(SQLString, "\", "\\")
    SQLFilter = Replace(SQLFilter, "`", "\`")
    SQLFilter = Replace(SQLFilter, "'", "\'")
End Function

