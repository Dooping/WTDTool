object Form4: TForm4
  Left = 304
  Top = 190
  AlphaBlend = True
  AlphaBlendValue = 120
  BorderStyle = bsNone
  Caption = 'Form4'
  ClientHeight = 433
  ClientWidth = 579
  Color = clGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    579
    433)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    AlignWithMargins = True
    Left = 8
    Top = 400
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
end
