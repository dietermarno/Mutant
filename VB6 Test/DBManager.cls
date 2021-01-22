VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "DBManager"
Attribute VB_GlobalNameSpace = True
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

'*********************************
'* Cria variável única de conexão
'*********************************
Public oConnection As New ADODB.Connection
Public sConnection As String
Public sErrorDescription As String
Public lErrorNumber As Long

Public Function GetConnection() As Boolean

    '**************************
    '* Ativa controle de erros
    '**************************
    'On Error Resume Next
    
    '**************************
    '* Obtem string de conexão
    '**************************
    sConnection = GetPrivateStringValue("MySQL", "Connection", App.Path & "\dbConfig.ini")
    
    '**************
    '* Houve erro?
    '**************
    If Err.Number <> 0 Then
       
       '**********************
       '* Salva dados do erro
       '**********************
       sErrorDescription = Err.Description
       lErrorNumber = Err.Number
       GetConnection = False
    Else
    
       '***************************************
       '* String de conexão obtida com sucesso
       '***************************************
       GetConnection = True
    End If
End Function

Public Function ExecuteCommand(SQL As String) As Long

   '*******************************
   '* Dimensionamento de variáveis
   '*******************************
   Dim tableKey As New ADODB.Recordset
   Dim SQLGetKey As String
   
   '**********************
   '* Anula erro anterior
   '**********************
   sErrorDescription = ""
   lErrorNumber = 0
   
   '**************************
   '* Ativa controle de erros
   '**************************
   'On Error Resume Next
   
    '*****************************
    '* Reinicia controle de erros
    '*****************************
    Err.Clear
    DoEvents
       
    '**************************
    '* A conexão está fechada?
    '**************************
    If oConnection.State = adStateClosed Then
       
       '*****************
       '* Abre a conexão
       '*****************
       oConnection.ConnectionTimeout = 60
       oConnection.CommandTimeout = 60
       oConnection.CursorLocation = adUseClient
       oConnection.Open sConnection
    End If
    
    '*******************
    '* Aguarda execução
    '*******************
    While oConnection.State = adStateConnecting Or oConnection.State = adStateExecuting
          DoEvents
    Wend
    
    '********************
    '* Executa o comando
    '********************
    oConnection.Execute SQL
       
    '*******************
    '* Aguarda execução
    '*******************
    While oConnection.State = adStateConnecting Or oConnection.State = adStateExecuting
          DoEvents
    Wend
        
    '**************
    '* Houve erro?
    '**************
    SQLGetKey = "SELECT LAST_INSERT_ID() AS idKey"
    tableKey.Open SQLGetKey, oConnection, adOpenKeyset, adLockOptimistic
    ExecuteCommand = tableKey("idKey")
    tableKey.Close
    Set tableKey = Nothing
    DoEvents
   
    '**************
    '* Houve erro?
    '**************
    If Err.Number <> 0 Then
       
       '**********************
       '* Salva dados do erro
       '**********************
       sErrorDescription = Err.Description
       lErrorNumber = Err.Number
       ExecuteCommand = -1
    End If

    '**************
    '* Fecha banco
    '**************
    If oConnection.State = adStateOpen Then
       oConnection.Close
    End If
    
    '****************************
    '* Desativa controle de erro
    '****************************
    Set oConnection = Nothing
    On Error GoTo 0
    Err.Clear
End Function

Public Function ExecuteCommandWithParameters(SQL As String, oParameters() As ADODB.Parameter) As Long

   '*******************************
   '* Dimensionamento de variáveis
   '*******************************
   Dim tableKey As New ADODB.Recordset
   Dim oParameter As ADODB.Parameter
   Dim SQLGetKey As String
   Dim i As Long
   
   '**********************
   '* Anula erro anterior
   '**********************
   sErrorDescription = ""
   lErrorNumber = 0
   
   '**************************
   '* Ativa controle de erros
   '**************************
   'On Error Resume Next
   
    '*****************************
    '* Reinicia controle de erros
    '*****************************
    Err.Clear
    DoEvents
       
    '**************************
    '* A conexão está fechada?
    '**************************
    If oConnection.State = adStateClosed Then
       
       '*****************
       '* Abre a conexão
       '*****************
       oConnection.ConnectionTimeout = 60
       oConnection.CommandTimeout = 60
       oConnection.CursorLocation = adUseClient
       oConnection.Open sConnection
    End If
    
    '*******************
    '* Aguarda execução
    '*******************
    While oConnection.State = adStateConnecting Or oConnection.State = adStateExecuting
          DoEvents
    Wend
    
    '********************
    '* Executa o comando
    '********************
    Dim oCommand As New ADODB.Command
    oCommand.ActiveConnection = oConnection
    oCommand.CommandText = SQL
    oCommand.CommandType = adCmdText
    For i = 0 To UBound(oParameters)
        oCommand.Parameters.Append oParameters(i)
    Next
    oCommand.Execute SQL
       
    '*******************
    '* Aguarda execução
    '*******************
    While oCommand.State = adStateConnecting Or oCommand.State = adStateExecuting
          DoEvents
    Wend
        
    '**************
    '* Houve erro?
    '**************
    SQLGetKey = "SELECT LAST_INSERT_ID() AS idKey"
    tableKey.Open SQLGetKey, oConnection, adOpenKeyset, adLockOptimistic
    ExecuteCommandWithParameters = tableKey("idKey")
    tableKey.Close
    Set tableKey = Nothing
    DoEvents
   
    '**************
    '* Houve erro?
    '**************
    If Err.Number <> 0 Then
       
       '**********************
       '* Salva dados do erro
       '**********************
       sErrorDescription = Err.Description
       lErrorNumber = Err.Number
       ExecuteCommandWithParameters = -1
    End If

    '**************
    '* Fecha banco
    '**************
    If oConnection.State = adStateOpen Then
       oConnection.Close
    End If
    
    '****************************
    '* Desativa controle de erro
    '****************************
    Set oConnection = Nothing
    On Error GoTo 0
    Err.Clear
End Function

Public Function ExecutaQuery(SQL As String, Optional ByVal CursorType As Integer = 0) As ADODB.Recordset

    '*******************************
    '* Dimensionamento de variáveis
    '*******************************
    Dim tableResult As New ADODB.Recordset
    
    '**********************
    '* Anula erro anterior
    '**********************
    sErrorDescription = ""
    lErrorNumber = 0
    
    '**************************
    '* Ativa controle de erros
    '**************************
    'On Error Resume Next
    
    '*************************
    '* Reinicia trap de erros
    '*************************
    Err.Clear
    DoEvents
         
    '**************************
    '* A conexão está fechada?
    '**************************
    If oConnection.State = adStateClosed Then
    
       '**********************************
       '* O tipo de cursor foi informado?
       '**********************************
       If CursorType <> 0 Then
       
          '*********************
          '* Usa tipo informado
          '*********************
          oConnection.CursorLocation = CursorType
       Else
       
          '*******************
          '* Usa tipo cliente
          '*******************
          oConnection.CursorLocation = adUseClient
       End If
    
       '*****************
       '* Abre a conexão
       '*****************
       oConnection.ConnectionTimeout = 60
       oConnection.CommandTimeout = 60
       oConnection.Open sConnection
    End If
      
    '*******************
    '* Aguarda execução
    '*******************
    While oConnection.State = adStateConnecting Or oConnection.State = adStateExecuting
          DoEvents
    Wend
      
    '********************
    '* Executa o comando
    '********************
    tableResult.Open SQL, oConnection, adOpenKeyset, adLockOptimistic
         
    '*******************
    '* Aguarda execução
    '*******************
    While tableResult.State = adStateConnecting Or tableResult.State = adStateExecuting
          DoEvents
    Wend
      
    '**********************
    '* Se houve erro fecha
    '**********************
    If Err.Number <> 0 Then
       
       '**********************
       '* Salva dados do erro
       '**********************
       sErrorDescription = Err.Description
       lErrorNumber = Err.Number
       
    Else
   
      '********************
      '* Retorna resultado
      '********************
      Set tableResult.ActiveConnection = Nothing
      Set ExecutaQuery = tableResult.Clone
    End If
   
    '***************
    '* Fecha tabela
    '***************
    If tableResult.State = adStateOpen Then
       tableResult.Close
    End If
    
    '**************
    '* Fecha banco
    '**************
    If oConnection.State = adStateOpen Then
       oConnection.Close
    End If
    
    '******************
    '* Destroi objetos
    '******************
    Set tableResult = Nothing
    Set oConnection = Nothing
    
    '****************************
    '* Desativa controle de erro
    '****************************
    On Error GoTo 0
    Err.Clear
End Function

Private Function GetPrivateStringValue(section$, Key$, File$) As String

    '********************************
    '* Obtém dados de um arquivo INI
    '********************************
    Dim KeyValue$
    Dim characters As Long
    KeyValue$ = String$(512, 0)
    characters = GetPrivateProfileStringByKeyName(section$, Key$, "", KeyValue$, 512, File$)
    If characters > 1 Then
       KeyValue$ = Left$(KeyValue$, characters)
    End If
    GetPrivateStringValue = KeyValue$
End Function

