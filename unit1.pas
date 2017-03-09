unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation
           uses fs0, Trans,
             LCLProc, LazHelpHTML, UTF8Process;
{ TForm1 }
{$ifdef windows}
const adb = 'adb.exe';
{$endif}
{$ifdef linux}
const adb = 'adb';
{$endif}
const linktosite = 'http://hy.wikipedia.org';
procedure SetLang;
begin
  if Trans.language = Trans.en then begin
   Form1.Caption:= entitle;
//  Form1.Label1.Caption:= Trans.engpathadb;
  Form1.Button2.Caption:= Trans.eninstall;
  Form1.Label2.Caption:= Trans.enchooselang;
  Form1.Label3.Caption:= Trans.enbefore;
  Form1.Button1.Caption := Trans.enabout;
  end;
  if Trans.language = Trans.hy then begin
  Form1.Caption:=hytitle;
  Form1.Button1.Caption := Trans.hyabout;
//  Form1.Label1.Caption:= Trans.hypathadb;
  Form1.Button2.Caption:= Trans.hyinstall;
  Form1.Label2.Caption := Trans.hychooselang;
  Form1.Label3.Caption:= Trans.hybefore;
  end;
end; //SetLang

procedure TForm1.FormCreate(Sender: TObject);
var i : integer;
begin
 // Trans.SetLang(Trans.en);
//  setlength(trans.languagenames, Trans.langcount);
  Trans.Init;
  SetLang;
  StatusBar1.Caption:= '';
  Label1.Caption:=linktosite;
  Label1.Font.Color:=clBlue;
  Label1.Font.Style:= Label1.Font.Style + [fsUnderline];

  ComboBox1.Caption:= Trans.languagenames[Trans.language];
  for  i := 0 to (High(Trans.languagenames) )do begin
      ComboBox1.Items.Add(Trans.languagenames[i]);
  end;
   Image1.Picture.LoadFromFile('osi.png');
end;

procedure TForm1.Label1Click(Sender: TObject);
var
  v: THTMLBrowserHelpViewer;
  BrowserPath, BrowserParams: string;
  p: LongInt;
  URL: String;
  BrowserProcess: TProcessUTF8;
begin
  v:=THTMLBrowserHelpViewer.Create(nil);
  try
    v.FindDefaultBrowser(BrowserPath,BrowserParams);
    debugln(['Path=',BrowserPath,' Params=',BrowserParams]);

    URL:=linktosite;
    p:=System.Pos('%s', BrowserParams);
    System.Delete(BrowserParams,p,2);
    System.Insert(URL,BrowserParams,p);

    // start browser
    BrowserProcess:=TProcessUTF8.Create(nil);
    try
      BrowserProcess.CommandLine:=BrowserPath+' '+BrowserParams;
      BrowserProcess.Execute;
    finally
      BrowserProcess.Free;
    end;
  finally
    v.Free;
  end;
end; //labelclick


function ExecCommand(cmd, args : string) : integer;
var p : TProcess;
stmp: string;
   begin
      stmp := cmd + ' ' + args;
      if Trans.GetLang() = Trans.en then Form1.StatusBar1.Caption:= enrunning + stmp;//p.CommandLine;
      if Trans.GetLang() = Trans.hy then Form1.StatusBar1.Caption:= hyrunning + stmp;//p.CommandLine;
      p := TProcess.Create(nil);
      p.CommandLine := stmp;//Edit1.Text +  ' ' + cmd;
      p.Options := p.Options + [poWaitOnExit, poUsePipes];
      p.Execute;
         if p.ExitStatus <> 0 then begin
         if Trans.GetLang() = Trans.en then begin
          MessageDlg ('', Trans.enfailedtoexecute + ' ' + p.CommandLine, mtError, [mbOK],0);
         end;
         //ShowMessage(Trans.enfailedtoexecute + ' ' + p.CommandLine);
         if Trans.GetLang() = Trans.hy then MessageDlg ('', Trans.hyfailedtoexecute + ' ' + p.CommandLine, mtError,
                  [mbOK],0);
         //ShowMessage(Trans.hyfailedtoexecute + ' ' + p.CommandLine);
         p.Free;
         Result := -1;
         Exit;
      end;
      //Memo1.Lines.LoadFromStream(p.Output);
      {ss := TStringList.Create;
      ss.LoadFromStream(p.Output);
      ss.Free;}
      p.Free;
   end; //ExecCommand


procedure TForm1.Button2Click(Sender: TObject);
var CurDir: string;
adbpath : string;
ttfpath : string;
flist : TstringList;
i, exitcode : integer;
params : string;
success : boolean;
begin
success := false;
CurDir := ExtractFilePath(Application.ExeName);
adbpath := CurDir + {DirectorySeparator +} adb;
  If SysUtils.FileExists(adbpath) then
  begin
   if Trans.language = Trans.en then Form1.StatusBar1.Caption:= Trans.enwaitingfordevice;
   if Trans.language = Trans.hy then Form1.StatusBar1.Caption:= Trans.hywaitingfordevice;
   ExecCommand(adbpath, 'kill-server');
   if Trans.GetLang() = Trans.en then Form1.StatusBar1.Caption:= Trans.enwaitingfordevice;
   if Trans.GetLang() = Trans.hy then Form1.StatusBar1.Caption:= Trans.hywaitingfordevice;
   //ExecCommand('wait-for-device');
   ExecCommand(adbpath, 'remount');

   flist := TStringList.Create;
   ttfpath := CurDir + 'ttf';
   fs0.FindFiles (flist, ttfpath, '*.ttf');
   Form1.ProgressBar1.Max:= flist.Count - 1;
   Form1.ProgressBar1.Position:= 0;

   for i := 0 to flist.Count - 1 do begin
      params := 'push ' + ttfpath + DirectorySeparator + flist[i] + ' /system/fonts/' + flist[i];
      exitcode := ExecCommand (adbpath, params);
      if exitcode = -1 then begin success := false end;
      Form1.ProgressBar1.Position := Form1.ProgressBar1.Position + 1;
   end;
   flist.Free;
//   ExecCommand('reboot');
   ExecCommand(adbpath, 'kill-server');
   if success then begin
      if Trans.GetLang() = Trans.en then MessageDlg ('', Trans.ensuccess, mtInformation,
                  [mbOK],0);
//ShowMessage(Trans.ensuccess);
      if Trans.GetLang() = Trans.hy then MessageDlg ('', Trans.hysuccess, mtInformation,
                  [mbOK],0);
      //ShowMessage(Trans.hysuccess);
   end
   else
   begin
      if Trans.GetLang() = Trans.en then MessageDlg ('', Trans.ennotsuccess, mtError,
                  [mbOK],0);
      //ShowMessage(Trans.ennotsuccess);
      if Trans.GetLang() = Trans.hy then  MessageDlg ('', Trans.hynotsuccess, mtError,
                  [mbOK],0);
      //ShowMessage(Trans.hynotsuccess);
   end;
   halt;
  end
  else
   begin
   if Trans.GetLang() = Trans.en then Dialogs.ShowMessage(Trans.enshowpath);
   if Trans.GetLang() = Trans.hy then Dialogs.ShowMessage(Trans.hyshowpath);
  end;
end; //button2click

procedure TForm1.Button1Click(Sender: TObject);
begin
  if Trans.language = Trans.en then begin
    MessageDlg(enAboutTitle,enAboutContent,mtInformation,[mbOk],0)
  end;
  if Trans.language = Trans.hy then begin
     MessageDlg(hyAboutTitle,hyAboutContent,mtInformation,[mbOk],0)
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Trans.language:= ComboBox1.ItemIndex;
  SetLang;
end;

initialization
  {$I unit1.lrs}

end.

