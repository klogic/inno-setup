; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppPublisher "Refinitiv."
#define MyAppURL "http://www.example.com/"
#define MyAppExeName "electron-quick-start.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{92A7903F-5AE6-4150-84BA-FF6E4067BA9C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName="C:\Users\UC268969\Desktop\Output\{#MyAppName}"
DisableProgramGroupPage=yes
; The [Icons] "quicklaunchicon" entry uses {userappdata} but its [Tasks] entry has a proper IsAdminInstallMode Check.
UsedUserAreasWarning=no
; Uncomment the following line to run in non administrative install mode (install for current user only.)
; PrivilegesRequiredOverridesAllowed=commandline
; PrivilegesRequired=lowest
OutputBaseFilename=test
UsePreviousAppDir=no
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
; Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 6.1; Check: not IsAdminInstallMode

[Files]
Source: "C:\Users\UC268969\Dev\POC\electron-wix-msi\electron-quick-start-win32-x64\*"; Permissions: users-modify; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
; Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
; Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
; Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent shellexec 

[Code]

var
  OptionPage: TInputOptionWizardPage;

procedure InitializeWizard();
begin
  OptionPage :=
    CreateInputOptionPage(
      wpWelcome,
      'Choose installation options', 'Who should this application be installed for?',
      'Please select whether you wish to make this software available for all users ' +
        'or just yourself.',
      True, False);

  OptionPage.Add('&Anyone who uses this computer');
  OptionPage.Add('&Only for me');

  if IsAdminLoggedOn then
  begin
    OptionPage.Values[0] := True;
  end
    else
  begin
    OptionPage.Values[1] := True;
    OptionPage.CheckListBox.ItemEnabled[0] := False;
  end;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  if CurPageID = OptionPage.ID then
  begin
    if OptionPage.Values[1] then
    begin
      WizardForm.DirEdit.Text := ExpandConstant('{userappdata}\My Program')
    end
      else
    begin
      WizardForm.DirEdit.Text := ExpandConstant('{pf}\My Program');
    end;
  end;
  Result := True;
end;