unit Dashboard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ClipBrd, SHELLAPI, ExtDlgs, ImgList, FileCtrl;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    CheckBox1: TCheckBox;
    Button1: TButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    CalculateBtn: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    CheckBox2: TCheckBox;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    Button6: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CalculateBtnClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Edit1DblClick(Sender: TObject);
    procedure Edit6DblClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    procedure WndProc(var Msg: TMessage); override;
  private
    { Private declarations }
    hotkey1: integer;
    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
    procedure FillTime(isOrigin: boolean);
  public
    { Public declarations }
  end;

procedure ScreenShot;

var
  Form1: TForm1;
  MWM_LBUTTONDOWN: cardinal;
  NumberTimes: integer;
  LastClick, lastclick2, lastclick3: string;
  mystring: string;
  mousehook, tirarshots: boolean;
  pastaimagem: string;
  dir_name: string;
  imagenumber: integer;

function StartMouseHook(State: boolean; Wnd: HWND): boolean; stdcall;
  external 'LowLevelMouseHook.dll';
function StopMouseHook(): boolean; stdcall; external 'LowLevelMouseHook.dll';

implementation

uses Clock, Registry, SnapshotArea;

{$R *.DFM}

procedure TForm1.FillTime(isOrigin: boolean);
var
  hhstr, mmstr, ssstr: string;
begin
  if (CompareStr('[', Clipboard.AsText[1]) = 0) then
  begin
    hhstr := Clipboard.AsText[2] + Clipboard.AsText[3];
    mmstr := Clipboard.AsText[5] + Clipboard.AsText[6];
    ssstr := Clipboard.AsText[8] + Clipboard.AsText[9];
  end
  else
  begin
    hhstr := Clipboard.AsText[1] + Clipboard.AsText[2];
    mmstr := Clipboard.AsText[4] + Clipboard.AsText[5];
    ssstr := Clipboard.AsText[7] + Clipboard.AsText[8];
  end;

  if(isOrigin) then
  begin
    Edit1.Clear;
    Edit2.Clear;
    Edit3.Clear;
    Edit1.text := hhstr;
    Edit2.text := mmstr;
    Edit3.text := ssstr;
  end
  else
  begin
    Edit4.Clear;
    Edit5.Clear;
    Edit6.Clear;
    Edit4.text := hhstr;
    Edit5.text := mmstr;
    Edit6.text := ssstr;
  end;

end;

procedure TForm1.Edit1DblClick(Sender: TObject);
begin
  FillTime(true);
end;

procedure TForm1.Edit1Exit(Sender: TObject);
begin
  // if CompareStr('',TEdit(sender).Text)=0 then TEdit(sender).Text:='0';

end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (upcase(Char(key)) = 'V') then
      begin
        FillTime(true);
        Clipboard.Clear;
      end;
end;

procedure TForm1.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (upcase(Char(key)) = 'V') then
      begin
        FillTime(false);
        Clipboard.Clear;
      end;
end;

procedure TForm1.Edit6DblClick(Sender: TObject);
begin
  FillTime(false);
end;

procedure TForm1.WMHotKey(var Msg: TWMHotKey);
begin
  if Msg.HotKey = hotkey1 then
  begin
    Inc(NumberTimes);
    ListBox1.Items.Add('[' + LastClick + ']       ' + inttostr(NumberTimes));
    Form3.ListBox1.Items.Add('[' + LastClick + ']       ' +
      inttostr(NumberTimes));
    Form3.ListBox1.TopIndex := Form3.ListBox1.count - 1;
    ListBox1.TopIndex := ListBox1.count - 1;
  end;
end;

procedure TForm1.WndProc(var Msg: TMessage);
begin
  inherited;
  if (Msg.Msg = MWM_LBUTTONDOWN) then
  begin
    if tirarshots then
    begin
      ScreenShot;
    end;
    LastClick := TimeToStr(Time);
    lastclick2 := LastClick[1] + LastClick[2] + LastClick[4] + LastClick[5] +
      LastClick[7] + LastClick[8];
    if CompareStr(lastclick2, lastclick3) = 0 then
    begin
      Inc(imagenumber);
      lastclick2 := lastclick2 + '_' + inttostr(imagenumber);
    end
    else
    begin
      lastclick3 := lastclick2;
      imagenumber := 1;
    end;
    Form3.ListBox1.Items.Add('[' + LastClick + ']');
    Form3.ListBox1.TopIndex := Form3.ListBox1.count - 1;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  StopMouseHook;
end;

procedure TForm1.FormCreate(Sender: TObject);
const
  MOD_CONTROL = 2;
  VK_D = 68;

begin
  Form1.Left := Monitor.Width - Form1.Width - 20;
  Form1.Top := Monitor.Height - Form1.Height - 150;
  StartMouseHook(True, Handle);
  hotkey1 := GlobalAddAtom('Hotkey1');
  RegisterHotKey(Handle, hotkey1, MOD_CONTROL, VK_D);
  mousehook := True;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    Form1.FormStyle := TFormStyle.fsStayOnTop
  else
    Form1.FormStyle := TFormStyle.fsNormal;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
var
  Options: TSelectDirOpts;
begin
  Options := [sdAllowCreate, sdPerformCreate, sdPrompt];
  if CheckBox2.Checked then
  begin

    if SelectDirectory('Seleccione a Pasta', ExtractFileDrive(dir_name),
      dir_name, [sdNewUI, sdNewFolder]) then
    begin
      pastaimagem := dir_name;
      tirarshots := True
    end
    else
      CheckBox2.Checked := false;
  end
  else
    tirarshots := false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not assigned(Form2) then
    Form2 := TForm2.create(application);
  if Form2.Visible then
  begin
    Form2.Close;
    exit;
  end;
  Form2.Show;
end;

procedure TForm1.CalculateBtnClick(Sender: TObject);
var
  segundosvoo, segundosrecolha, segundostotal, horas, minutos,
    segundos: integer;
  strhoras, strmin, strseg: string;
begin
  if (CompareStr('', Edit1.text) = 0) or (CompareStr('', Edit2.text) = 0) or
    (CompareStr('', Edit3.text) = 0) or (CompareStr('', Edit4.text) = 0) or
    (CompareStr('', Edit5.text) = 0) or (CompareStr('', Edit6.text) = 0) then
    exit;

  segundosvoo := 3600 * (strtoint(Edit1.text)) + 60 * (strtoint(Edit2.text)) +
    strtoint(Edit3.text);
  segundosrecolha := 3600 * (strtoint(Edit4.text)) + 60 * (strtoint(Edit5.text))
    + strtoint(Edit6.text);
  segundostotal := segundosvoo + segundosrecolha;
  if (segundostotal >= 86400) then
    segundostotal := segundostotal - 86400;

  horas := trunc(segundostotal / 3600);
  minutos := trunc((segundostotal - (3600 * horas)) / 60);
  segundos := (segundostotal - (3600 * horas)) - (60 * minutos);

  if horas < 10 then
    strhoras := '0' + inttostr(horas)
  else
    strhoras := inttostr(horas);

  if minutos < 10 then
    strmin := '0' + inttostr(minutos)
  else
    strmin := inttostr(minutos);

  if segundos < 10 then
    strseg := '0' + inttostr(segundos)
  else
    strseg := inttostr(segundos);

  Label4.caption := strhoras + ':' + strmin + ':' + strseg;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if Form3.Visible then
    Form3.Visible := false
  else
    Form3.Visible := True;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Form3.ListBox1.Clear;
  ListBox1.Clear;
  NumberTimes := 0;
  Edit4.text := 'HH';
  Edit5.text := 'MM';
  Edit6.text := 'SS';
  Label4.caption := '';
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if mousehook then
  begin
    StopMouseHook;
    mousehook := false;
    Button5.caption := 'Começar Registo';
  end
  else
  begin
    StartMouseHook(True, Handle);
    mousehook := True;
    Button5.caption := 'Parar Registo';
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  if form4.Visible then
  begin
    form4.Visible := false;
    tirarshots := false
  end
  else
    form4.Visible := True;

end;

procedure TForm1.ListBox1Click(Sender: TObject);
var
  I: integer;
begin
  mystring := ListBox1.Items[ListBox1.ItemIndex];
  I := Form3.ListBox1.Items.IndexOf(mystring);
  Form3.ListBox1.ItemIndex := I;
  Edit4.text := mystring[2] + mystring[3];
  Edit5.text := mystring[5] + mystring[6];
  Edit6.text := mystring[8] + mystring[9];

end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  Clipboard.AsText := ListBox1.Items[ListBox1.ItemIndex];
end;

procedure ScreenShot;
var
  ScreenDC: HDC;
  ScreenHandle: HWND;
  ScreenBitmap: TBitmap;
begin
  ScreenHandle := GetDeskTopWindow;
  ScreenDC := GetDC(ScreenHandle);
  try
    ScreenBitmap := TBitmap.create;
    try
      ScreenBitmap.Width := form4.Width;
      ScreenBitmap.Height := form4.Height;
      BitBlt(ScreenBitmap.Canvas.Handle, 0, 0, form4.Width, form4.Height,
        ScreenDC, form4.Left, form4.Top, SRCCOPY);
      Clipboard.Assign(ScreenBitmap);
      Form1.Image1.Picture.Assign(ScreenBitmap);
      Form1.Image1.Picture.SaveToFile(dir_name + '/' + lastclick2 + '.png');
    finally
      ScreenBitmap.Free
    end
  finally
    ReleaseDC(ScreenHandle, ScreenDC)
  end
end;

initialization

application.MainFormOnTaskBar := True;
MWM_LBUTTONDOWN := RegisterWindowMessage('MWM_LBUTTONDOWN');
NumberTimes := 0;
// Form3 := TForm3.create(application);

end.
