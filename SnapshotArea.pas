unit SnapshotArea;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Dashboard;

type
  TForm4 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHitTest;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TForm4.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  if Msg.Result = htClient then
    Msg.Result := htCaption;
end;

procedure TForm4.CreateParams(var Params: TCreateParams);
begin
  BorderStyle := bsNone;

  inherited;

  Params.ExStyle := Params.ExStyle or WS_EX_STATICEDGE;
  Params.Style := Params.Style or WS_SIZEBOX;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  Form4.Left := Trunc(Monitor.Width / 4);
  Form4.Width := Trunc(Monitor.Width / 2);
  Form4.Top := Trunc(Monitor.Height / 4);
  Form4.Height := Trunc(Monitor.Height / 2);
end;

end.
