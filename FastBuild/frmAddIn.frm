VERSION 5.00
Begin VB.Form frmAddIn 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Fast Build Addin             http://sandsprite.com"
   ClientHeight    =   4605
   ClientLeft      =   150
   ClientTop       =   435
   ClientWidth     =   10050
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4605
   ScaleWidth      =   10050
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command2 
      Caption         =   "Last CMD Output"
      Height          =   285
      Left            =   7110
      TabIndex        =   13
      Top             =   990
      Width           =   1590
   End
   Begin VB.CommandButton cmdTest 
      Caption         =   "Test"
      Height          =   285
      Left            =   8865
      TabIndex        =   12
      Top             =   990
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Save"
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   8865
      TabIndex        =   11
      Top             =   630
      Width           =   1095
   End
   Begin VB.TextBox txtPostBuild 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2385
      OLEDropMode     =   1  'Manual
      TabIndex        =   10
      Top             =   630
      Width           =   6360
   End
   Begin VB.TextBox txtAbout 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3165
      Left            =   90
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   7
      Top             =   1395
      Width           =   9870
   End
   Begin VB.Frame Frame1 
      BorderStyle     =   0  'None
      Height          =   510
      Left            =   135
      TabIndex        =   4
      Top             =   7425
      Width           =   9825
      Begin VB.CommandButton cmdAbout 
         Caption         =   "About"
         Height          =   375
         Left            =   90
         TabIndex        =   8
         Top             =   90
         Width           =   1050
      End
      Begin VB.CommandButton cmdRefresh 
         Caption         =   "Refresh"
         Height          =   375
         Left            =   7470
         TabIndex        =   6
         Top             =   90
         Width           =   1050
      End
      Begin VB.CommandButton cmdClearLog 
         Caption         =   "Clear Log"
         Height          =   375
         Left            =   8640
         TabIndex        =   5
         Top             =   90
         Width           =   1050
      End
   End
   Begin VB.CommandButton cmdUpdate 
      Caption         =   "Update"
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   8865
      TabIndex        =   3
      Top             =   180
      Width           =   1095
   End
   Begin VB.TextBox txtBuildPath 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2385
      OLEDropMode     =   1  'Manual
      TabIndex        =   2
      Top             =   180
      Width           =   6360
   End
   Begin VB.ListBox List1 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2205
      Left            =   135
      TabIndex        =   0
      Top             =   5130
      Width           =   9825
   End
   Begin VB.Label Label1 
      Caption         =   "Post Build Command"
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   1
      Left            =   90
      TabIndex        =   9
      Top             =   675
      Width           =   2220
   End
   Begin VB.Label Label1 
      Caption         =   "Default Build Path:"
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   0
      Left            =   90
      TabIndex        =   1
      Top             =   225
      Width           =   2400
   End
End
Attribute VB_Name = "frmAddIn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Name:   VB6 FastBuild Addin
' Author: David Zimmer
' Site:   http://sandsprite.com
'

Private Sub cmdTest_Click()
    Dim postbuild As String
    Dim ret As String
    
    postbuild = ExpandVars(txtPostBuild, txtBuildPath)
    ret = GetCommandOutput("cmd /c " & postbuild, True, True)
    
    txtAbout = "Expanded command script: " & vbCrLf & postbuild & vbCrLf & vbCrLf & _
               "Command output: " & vbCrLf & ret
    
End Sub

Private Sub cmdUpdate_Click()
     On Error Resume Next
     
     If Len(txtBuildPath) = 0 Then
        MsgBox "You must enter a valid path including file name and extension", vbExclamation
        Exit Sub
     End If
     
     VBInstance.ActiveVBProject.WriteProperty "fastBuild", "fullPath", txtBuildPath
     
     If Err.Number = 0 Then
        MsgBox "This build path has been set as default, you will not be prompted " & vbCrLf & _
               "again and must change it here or in the projects vbp file as long " & vbCrLf & _
               "as this plugin is active.", vbInformation
     Else
        MsgBox "Save failed: " & Err.Description, vbCritical
     End If
        
End Sub

Private Sub Command1_Click()
    On Error Resume Next
    VBInstance.ActiveVBProject.WriteProperty "fastBuild", "PostBuild", txtPostBuild
    If Err.Number <> 0 Then
        MsgBox "Error saving postbuild command: " & Err.Description
    End If
End Sub

Private Sub Command2_Click()
    txtAbout = LastCommandOutput
End Sub

Private Sub Form_Load()
    On Error Resume Next
    Dim x
    
    If isBuildPathSet() Then
        txtBuildPath = VBInstance.ActiveVBProject.ReadProperty("fastBuild", "fullPath")
    End If
        
    txtPostBuild = GetPostBuildCommand
    
     txtAbout = "Build Path once set will be used from then on out automatically as default" & vbCrLf & _
                "and you will no longer be prompted every single time you want to generate the " & vbCrLf & _
                "executable." & vbCrLf & _
                "" & vbCrLf & _
                "The post build command allows you to specify a command (or batch file) that" & vbCrLf & _
                "you want run after your executable is built. Click the last cmd output " & vbCrLf & _
                "button to see the results, or test to watch it live. This command" & vbCrLf & _
                " supports several envirnoment variables which it can expand: " & vbCrLf & _
                "" & vbCrLf & _
                "%1           = exeFullPath" & vbCrLf & _
                "%apppath = exe Home dir " & vbCrLf & _
                "%outname = exe file name" & vbCrLf
                
'    List1.Clear
'    For Each X In Module1.hookLog
'        List1.AddItem X
'    Next
'
'    txtAbout.Text = "This addin allows you to save a hardcoded default path to use everytime your " & vbCrLf & _
'                    "binary is built. This setting is saved to the vbp project file the first time you specify" & vbCrLf & _
'                    "a file name." & vbCrLf & _
'                    "" & vbCrLf & _
'                    "Once set, you will not be prompted again until you manually set it. The reason" & vbCrLf & _
'                    "for this plugin is because:" & vbCrLf & _
'                    "" & vbCrLf & _
'                    "1) sometimes vb messes up and changes directories on you" & vbCrLf & _
'                    "2) having to specify it everytime with a save file dialog and overwrite ok is annoying!" & vbCrLf & _
'                    "" & vbCrLf & _
'                    "This project uses an external open source hooking library written in C to " & vbCrLf & _
'                    "do a detours style hook on the GetSaveFileNameA API. It will only override" & vbCrLf & _
'                    "the default behavior if an executable extension is detected and if the default" & vbCrLf & _
'                    "build path has already been set. " & vbCrLf & _
'                    "" & vbCrLf & _
'                    "You can download the binaries and source from the github archive:" & vbCrLf & _
'                    "        https://github.com/dzzie/addins" & vbCrLf
                    
End Sub



Private Sub txtBuildPath_OLEDragDrop(data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, Y As Single)
    On Error Resume Next
    Dim pth As String
    
    pth = data.Files(1)
    
    If FileExists(pth) Then
        txtBuildPath = pth
        Exit Sub
    End If
    
    If FolderExists(pth) Then
        txtBuildPath = pth
    End If
    
End Sub

Private Sub txtPostBuild_OLEDragDrop(data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, Y As Single)
    
    On Error Resume Next
    Dim pth As String
    
    pth = data.Files(1)
    
    If FileExists(pth) Then
        txtPostBuild = pth
        Exit Sub
    End If
    
End Sub



'Private Sub cmdAbout_Click()
'    txtAbout.Visible = Not txtAbout.Visible
'End Sub
'
'Private Sub cmdClearLog_Click()
'    Set hookLog = New Collection
'    List1.Clear
'End Sub
'
'Public Sub cmdRefresh_Click()
'    List1.Clear
'    For Each X In Module1.hookLog
'        List1.AddItem X
'    Next
'End Sub

'Private Sub Form_Resize()
'    On Error Resume Next
'
'    Frame1.Top = Me.Height - Frame1.Height - 600
'    List1.Height = Frame1.Top - List1.Top - 200
'    List1.Width = Me.Width - List1.Left - 200
'    Frame1.Left = Me.Width - Frame1.Width - 200
'
'    With List1
'        txtAbout.Move .Left, .Top, .Width, .Height
'    End With
'
'End Sub