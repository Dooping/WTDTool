unit Clock;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Dashboard;

{$R *.DFM}

procedure TForm2.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  { code to alter the CreateParams values }
  with Params do
  begin
    ExStyle := ExStyle or WS_EX_TOPMOST;
    WndParent := GetDesktopwindow;
  end;

end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Label1.Caption := TimeToStr(Time);
  if (Form2 <> nil) then
  begin
    Form2.Left := Form1.Left + Round((Form1.Width - Form2.Width) / 2);
    Form2.Top := Form1.Top + Form1.Height + 20;
  end;
  // SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
  // if form1.CheckBox1.Checked then
  // SetWindowPos(Application.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE)
  // else
  // SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOSIZE);

end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  Label1.Caption := TimeToStr(Time);
end;

procedure TForm2.FormDblClick(Sender: TObject);
begin
  Close;
end;

end.
