program WowCardioRaid;

uses
  //FastMM4,
  Forms,
  wcr_Main in 'wcr_Main.pas' {Form1},
  wcr_Parser_Events in 'wcr_Parser_Events.pas',
  wcr_Const in 'wcr_Const.pas',
  wcr_spellOpt in 'wcr_spellOpt.pas' {Form2},
  wcr_Hint in 'wcr_Hint.pas',
  wcr_unitOpt in 'wcr_unitOpt.pas' {Form3},
  wcr_utils in 'wcr_utils.pas',
  wcr_hintdatas in 'wcr_hintdatas.pas',
  wcr_Stats in 'wcr_Stats.pas',
  wcr_ressource in 'wcr_ressource.pas',
  wcr_exportstat in 'wcr_exportstat.pas' {Form4},
  wcr_saveopt in 'wcr_saveopt.pas' {Form5},
  wcr_Unitlist in 'wcr_Unitlist.pas' {Form7},
  wcr_VirtualBoss in 'wcr_VirtualBoss.pas' {Form8},
  wcr_AddLine in 'wcr_AddLine.pas' {Form6},
  wcr_Spelllist in 'wcr_Spelllist.pas' {FormSpell},
  wcr_options in 'wcr_options.pas' {OptionsForm},
  wcr_error in 'wcr_error.pas' {Form9},
  wcr_Html in 'wcr_Html.pas',
  wcr_Hash in 'wcr_Hash.pas',
  wcr_replay in 'wcr_replay.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'WowCardioRaid';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
