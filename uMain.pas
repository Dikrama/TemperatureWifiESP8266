unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, FMX.Layouts,
  RDLuCircleGauge;

type
  TForm4 = class(TForm)
    rctngl1: TRectangle;
    lbl1: TLabel;
    nthtpclnt1: TNetHTTPClient;
    tmr1: TTimer;
    rdlcrclg1: TRDLCircleGauge;
    lbl2: TLabel;
    btn1: TButton;
    procedure tmr1Timer(Sender: TObject);
    procedure nthtpclnt1ValidateServerCertificate(const Sender: TObject;
      const ARequest: TURLRequest; const Certificate: TCertificate;
      var Accepted: Boolean);
    procedure nthtpclnt1RequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure nthtpclnt1RequestError(const Sender: TObject;
      const AError: string);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  var st: TStringStream;

implementation

{$R *.fmx}

procedure TForm4.btn1Click(Sender: TObject);
begin
tmr1.Enabled := True;
end;

procedure TForm4.nthtpclnt1RequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
begin
lbl1.Text := st.DataString+' C';

rdlcrclg1.ValueAngle := ((Round(StrToFloatDef(Trim(st.DataString),0) * 2.4)-120));
lbl2.Text := 'Done request';
tmr1.Enabled := True;
end;

procedure TForm4.nthtpclnt1RequestError(const Sender: TObject;
  const AError: string);
begin
lbl2.Text := 'Error happen :( ... pls check connection';
end;

procedure TForm4.nthtpclnt1ValidateServerCertificate(const Sender: TObject;
  const ARequest: TURLRequest; const Certificate: TCertificate;
  var Accepted: Boolean);
begin
Accepted:=True;
end;

procedure TForm4.tmr1Timer(Sender: TObject);
begin
try
st := TStringStream.Create;
{$IF DEFINED(Win64) or DEFINED(Win32)}
nthtpclnt1.Get('https://192.168.4.1',st);
{$ELSE}
nthtpclnt1.Get('https://192.168.4.1',st);
{$ENDIF}
lbl2.Text := 'Receiving Data...';

tmr1.Enabled :=False;
finally

end;

end;

end.
