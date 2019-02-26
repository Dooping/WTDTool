unit Registry;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ClipBrd, Dashboard;

type
  TForm3 = class(TForm)
    ListBox1: TListBox;
    SaveDialog1: TSaveDialog;
    Button1: TButton;
    procedure FormDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

procedure TForm3.FormCreate(Sender: TObject);
begin
  Form3.Left := Form1.Left - Form3.Width - 20;
  Form3.Top := Form1.Top;
end;

procedure TForm3.FormDblClick(Sender: TObject);
begin
  close;
end;

procedure TForm3.ListBox1Click(Sender: TObject);
var
  I: integer;
  mystring: string;
begin
  if (ListBox1.ItemIndex >= 0) then
  begin
    mystring := ListBox1.Items[ListBox1.ItemIndex];
    I := Form1.ListBox1.Items.IndexOf(mystring);
    Form1.ListBox1.ItemIndex := I;
    Form1.Edit4.Text := mystring[2] + mystring[3];
    Form1.Edit5.Text := mystring[5] + mystring[6];
    Form1.Edit6.Text := mystring[8] + mystring[9];
  end;
end;

procedure TForm3.ListBox1DblClick(Sender: TObject);
begin
  if (ListBox1.ItemIndex >= 0) then
    Clipboard.AsText := ListBox1.Items[ListBox1.ItemIndex];
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  // Create the save dialog object - assign to our save dialog variable
  SaveDialog1 := TSaveDialog.Create(self);

  // Give the dialog a title
  SaveDialog1.Title := 'Save your text or word file';

  // Set up the starting directory to be the current one
  SaveDialog1.InitialDir := GetCurrentDir;

  // Allow only .txt and .doc file types to be saved
  SaveDialog1.Filter := 'Text file|*.txt|Word file|*.doc';

  // Set the default extension
  SaveDialog1.DefaultExt := 'txt';

  // Select text files as the starting filter type
  SaveDialog1.FilterIndex := 1;

  // Display the open file dialog
  if SaveDialog1.Execute then
    ListBox1.Items.savetofile(SaveDialog1.FileName);

  // Free up the dialog
  SaveDialog1.Free;
end;

end.
