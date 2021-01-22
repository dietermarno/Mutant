VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmViewer 
   Caption         =   "Teste - Visual Basic 6"
   ClientHeight    =   8070
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   11175
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   8070
   ScaleWidth      =   11175
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.Timer timProgresso 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   10560
      Top             =   120
   End
   Begin VB.PictureBox picOperacao 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0FFFF&
      ForeColor       =   &H80000008&
      Height          =   1455
      Left            =   3360
      ScaleHeight     =   1425
      ScaleWidth      =   4305
      TabIndex        =   0
      Top             =   3720
      Visible         =   0   'False
      Width           =   4335
      Begin MSComctlLib.ProgressBar prbProgresso 
         Height          =   135
         Left            =   120
         TabIndex        =   14
         Top             =   840
         Visible         =   0   'False
         Width           =   4095
         _ExtentX        =   7223
         _ExtentY        =   238
         _Version        =   393216
         Appearance      =   0
         Scrolling       =   1
      End
      Begin VB.Label lblProgresso 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   1020
         Visible         =   0   'False
         Width           =   4095
      End
      Begin VB.Label lblOperacao 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "Operação"
         Height          =   255
         Left            =   240
         TabIndex        =   1
         Top             =   600
         Width           =   3855
      End
   End
   Begin VB.PictureBox picConsulta 
      BorderStyle     =   0  'None
      Enabled         =   0   'False
      Height          =   6255
      Left            =   240
      ScaleHeight     =   6255
      ScaleWidth      =   10695
      TabIndex        =   7
      Top             =   1560
      Visible         =   0   'False
      Width           =   10695
      Begin VB.TextBox txtFiltro 
         Height          =   285
         Left            =   670
         MaxLength       =   3
         TabIndex        =   10
         Text            =   "A"
         Top             =   180
         Width           =   735
      End
      Begin VB.CommandButton cmdFiltrar 
         Caption         =   "&Filtrar"
         Height          =   375
         Left            =   1560
         TabIndex        =   9
         Top             =   120
         Width           =   1095
      End
      Begin MSComctlLib.TreeView trvRegistros 
         Height          =   5535
         Left            =   0
         TabIndex        =   11
         Top             =   720
         Width           =   10695
         _ExtentX        =   18865
         _ExtentY        =   9763
         _Version        =   393217
         Indentation     =   529
         LabelEdit       =   1
         LineStyle       =   1
         Style           =   7
         FullRowSelect   =   -1  'True
         SingleSel       =   -1  'True
         Appearance      =   1
      End
      Begin VB.Label lblFiltro 
         AutoSize        =   -1  'True
         Caption         =   "Filtro:"
         Height          =   195
         Left            =   120
         TabIndex        =   12
         Top             =   215
         Width           =   420
      End
   End
   Begin VB.PictureBox picCaptura 
      BorderStyle     =   0  'None
      Height          =   6255
      Left            =   240
      ScaleHeight     =   6255
      ScaleWidth      =   10575
      TabIndex        =   3
      Top             =   1560
      Width           =   10575
      Begin VB.CommandButton cmdSave 
         Caption         =   "&Salvar Dados"
         Height          =   495
         Left            =   1320
         TabIndex        =   6
         Top             =   120
         Width           =   1215
      End
      Begin VB.CommandButton cmdDownload 
         Caption         =   "&Baixar Dados"
         Height          =   495
         Left            =   0
         TabIndex        =   5
         Top             =   120
         Width           =   1215
      End
      Begin VB.TextBox txtXMLView 
         BeginProperty Font 
            Name            =   "Courier"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   5295
         Left            =   0
         MultiLine       =   -1  'True
         ScrollBars      =   3  'Both
         TabIndex        =   4
         Top             =   840
         Width           =   10580
      End
   End
   Begin MSComctlLib.TabStrip tabOperacoes 
      Height          =   6855
      Left            =   120
      TabIndex        =   2
      Top             =   1080
      Width           =   10935
      _ExtentX        =   19288
      _ExtentY        =   12091
      TabWidthStyle   =   2
      TabFixedWidth   =   2646
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   2
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Captura"
            Key             =   "CA"
            Object.ToolTipText     =   "Captura de dados"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Consulta"
            Key             =   "CO"
            Object.ToolTipText     =   "Consulta de dados salvos"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin VB.Label lblTitulo 
      AutoSize        =   -1  'True
      Caption         =   "Teste - Visual Basic 6"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   20.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00808080&
      Height          =   495
      Left            =   3840
      TabIndex        =   8
      Top             =   285
      Width           =   3765
   End
   Begin VB.Image imgLogo 
      Height          =   915
      Left            =   120
      Picture         =   "frmViewer.frx":0000
      Stretch         =   -1  'True
      Top             =   120
      Width           =   3420
   End
End
Attribute VB_Name = "frmViewer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'*************************************
'* Declarações publicas para o módulo
'*************************************
Dim oDomain As New MutantDomain.Domain

Private Sub cmdDownload_Click()

    '**************
    '* Declarações
    '**************
    Dim isDataOk As Boolean
    
    '*****************************
    '* Exibe processo de consulta
    '*****************************
    Me.MousePointer = vbHourglass
    Me.txtXMLView.Text = ""
    Me.lblOperacao.Caption = "Consultando Webservice..."
    Me.picOperacao.Visible = True
    DoEvents
    
    '*******************
    '* Realiza consulta
    '*******************
    isDataOk = oDomain.GetFullCountryInfoAllCountries()
    
    '*****************************
    '* Exibe processo de consulta
    '*****************************
    Me.MousePointer = vbDefault
    Me.picOperacao.Visible = False
    DoEvents
    
    '**********************************
    '* A consulta ocorreu com sucesso?
    '**********************************
    If isDataOk Then
        Me.txtXMLView.Text = oDomain.CountryInfo
    Else
        Me.txtXMLView.Text = oDomain.LastError
    End If
End Sub

Private Sub cmdFiltrar_Click()

    '**************
    '* Declarações
    '**************
    Dim oNodeRoot As Node
    Dim oNodeCountry As Node
    Dim oNodeLanguage As Node
    
    '****************************
    '* Aguarda final da consulta
    '****************************
    Me.MousePointer = vbHourglass
    DoEvents
    
    '**********************
    '* Cria item principal
    '**********************
    Me.trvRegistros.Nodes.Clear
    Set oNodeRoot = Me.trvRegistros.Nodes.Add(, tvwFirst, "N0", "Countries")
    oNodeRoot.Expanded = True
    
    '*****************
    '* Atualiza lista
    '*****************
    oDomain.getSavedCountries Trim(Me.txtFiltro.Text)
    If oDomain.SavedCountries.RecordCount > 0 Then
       oDomain.SavedCountries.MoveFirst
    End If
    
    '***********************
    '* Cria lista de países
    '***********************
    While Not oDomain.SavedCountries.EOF
    
        '****************
        '* Adiciona país
        '****************
        Set oNodeCountry = Me.trvRegistros.Nodes.Add(oNodeRoot, tvwChild, oDomain.SavedCountries("ISOCode"))
        oNodeCountry.Text = oDomain.SavedCountries("name") & " (ISOCode " & oDomain.SavedCountries("ISOCode") & ")"
        oNodeCountry.Expanded = True
        
        '**********************
        '* Adiciona linguagens
        '**********************
        If oDomain.SavedLanguages.RecordCount > 0 Then
           oDomain.SavedLanguages.MoveFirst
        End If
        While Not oDomain.SavedLanguages.EOF
            If oDomain.SavedLanguages("countryISOCode") = oDomain.SavedCountries("ISOCode") Then
                Set oNodeLanguage = Me.trvRegistros.Nodes.Add(oNodeCountry, tvwChild, oDomain.SavedCountries("ISOCode") & "#" & oDomain.SavedLanguages("languageISOCode"))
                oNodeLanguage.Text = oDomain.SavedLanguages("name") & " (LanguageISOCode " & oDomain.SavedLanguages("languageISOCode") & ")"
            End If
            oDomain.SavedLanguages.MoveNext
        Wend
        oDomain.SavedCountries.MoveNext
    Wend
    
    '**********************
    '* Consulta finalizada
    '**********************
    Me.MousePointer = vbDefault
    DoEvents
End Sub

Private Sub cmdSave_Click()

    '**************
    '* Declarações
    '**************
    Dim isSaveOk As Boolean
    Dim message As String
    
    '*****************************
    '* Exibe processo de consulta
    '*****************************
    Me.MousePointer = vbHourglass
    Me.lblOperacao.Caption = "Salvando dados..."
    Me.picOperacao.Visible = True
    Me.lblProgresso.Visible = True
    Me.prbProgresso.Visible = True
    Me.timProgresso.Enabled = True
    DoEvents
    
    '***********************
    '* Salva dados no banco
    '***********************
    If oDomain.LastStatus Then
       isSaveOk = oDomain.SaveDatatoDB()
    Else
       message = "Não há dados disponíveis para salvar."
       MsgBox message, vbExclamation, "Gravação de dados"
       Me.txtXMLView.SetFocus
    End If
    
    '*****************************
    '* Exibe processo de consulta
    '*****************************
    Me.MousePointer = vbDefault
    Me.prbProgresso.Visible = False
    Me.lblProgresso.Visible = False
    Me.picOperacao.Visible = False
    Me.timProgresso.Enabled = False
    DoEvents
End Sub

Private Sub Form_Resize()

    '**********
    '* Largura
    '**********
    If Me.Width >= 11295 Then
        Me.tabOperacoes.Width = Me.Width - 360
        Me.picCaptura.Width = Me.tabOperacoes.Width - 240
        Me.txtXMLView.Width = Me.picCaptura.Width
        Me.trvRegistros.Width = Me.tabOperacoes.Width - 360
        Me.picConsulta.Width = Me.tabOperacoes.Width - 260
        Me.picOperacao.Left = (Me.Width - Me.picOperacao.Width) / 2
    End If
    
    '*********
    '* Altura
    '*********
    If Me.Height >= 8535 Then
        Me.tabOperacoes.Height = Me.Height - 1680
        Me.picCaptura.Height = Me.tabOperacoes.Height - 680
        Me.txtXMLView.Height = Me.picCaptura.Height - 240
        Me.picConsulta.Height = Me.tabOperacoes.Height - 560
        Me.trvRegistros.Height = Me.picConsulta.Height - 800
        Me.picOperacao.Top = (Me.Height - Me.picOperacao.Height) / 2
    End If
End Sub

Private Sub tabOperacoes_Click()

    '**************************************
    '* Habilita operação de acordo com TAB
    '**************************************
    Me.picCaptura.Enabled = False
    Me.picCaptura.Visible = False
    Me.picConsulta.Enabled = False
    Me.picConsulta.Visible = False
    
    Select Case Me.tabOperacoes.SelectedItem.Key
        Case "CA"
            Me.picCaptura.Enabled = True
            Me.picCaptura.Visible = True
        Case "CO"
            Me.picConsulta.Enabled = True
            Me.picConsulta.Visible = True
            cmdFiltrar_Click
    End Select
End Sub

Private Sub timProgresso_Timer()

    '*********************
    '* Atualiza progresso
    '*********************
    If (oDomain.TotalRegisters > 0) Then
       Me.lblProgresso.Caption = "Registro " & oDomain.ActualRegister & " de " & oDomain.TotalRegisters & " (" & Format((oDomain.ActualRegister / oDomain.TotalRegisters) * 100, "0.00") & "%)"
       Me.prbProgresso.Min = 0
       Me.prbProgresso.Max = 100
       Me.prbProgresso.Value = CInt((oDomain.ActualRegister / oDomain.TotalRegisters) * 100)
    End If
    DoEvents
End Sub
