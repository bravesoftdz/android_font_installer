unit Trans;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const langcount = 2;
const en = 0;
const hy = 1;

const
  hytitle = 'Armenian fonts installer for Android by hy-AM.org';
   entitle = 'Armenian fonts installer for Android by hy-AM.org';
   hyabout = 'Ծրագրի մասին';
   enabout = 'About ...';
   enAboutTitle = 'Ծրագրի մասին';
   enAboutContent = 'Ինչո՞ւ ապշած ես, լըճակ,' + LineEnding +
'Ու չեն խայտար քո ալեակք,' + LineEnding +
'Միթէ հալւոյդ մեջ անձկաւ' + LineEnding +
'Գեղուհի՞ մը նայեցաւ:';
   hyAboutTitle = 'Ծրագրի մասին';

   hyAboutContent = 'Հայերեն տառատեսակների տեղադրիչ' + LineEnding +
  'Անդրոիդ սարքերի համար վ. 1.0 (2011 մարտ 27)' + LineEnding +  LineEnding +
  'Ծրագրավորում՝' + LineEnding +
  'Նորայր Չիլինգարյան և Ալեքսեյ Չալաբյան' + LineEnding +
  'Տառատեսակները՝' + LineEnding +
  'Ռուբեն Թառումյան և Ascender' + LineEnding + LineEnding +
  'Ծրագրի ֆինանսավորող՝ ' + LineEnding +
  'Բաց Հասարակության հիմնադրամներ – Հայաստան ' + LineEnding + LineEnding +
  'Ծրագիրը տարածվում է GPLv3 թույլատրագրով։';

   enhelp='Help';
   hyhelp='Օգնություն';
   enbefore = 'Before installing restart the phone into recovery mode';
   hybefore = 'Ծրագիրը գործում է միայն ամբողջապես ռութ արած սարքերի վրա։' + LineEnding +
     'Միացրեք աարքի վրա «USB Debugging»-ը (Settings-> Applications -> Development)։'  + LineEnding +
     'Տեղակայելուց արաջ բեռնեք սարքը «recovery mode»-ում։';
   hypathadb = 'adb ֆայլի ուղին';
   engpathadb = 'path to the adb file';
   hybrowse = 'զննել';
   enbrowse = 'browse';
   hyinstall = 'Տեղակայել տառատեսակները';
   eninstall = 'install fonts';
   hychooselang = 'ընտրեք միջներեսի լեզուն';
   enchooselang = 'choose interface language';
   enshowpath = 'Please, first show path to the "adb" executable';
   hyshowpath = 'Խնդրում ենք նախ նշել "adb" ծրագրի ուղին';
   enwaitingfordevice = 'Waiting for device. Ensure USB debugging is enabled.';
   hywaitingfordevice = 'Միացրեք սարքը։ Համոզվեք, որ «USB debugging»-ը ակտիվացված է։';
   enfailedtoexecuteadb = 'Failed to execute "adb kill-server". Please, ensure you have provided the correct file and try again';
   hyfailedtoexecuteadb = 'Խափանվել է «adb kill-server» գործածումը։ Համոզվեք, որ դուք ուղին ճիշտ է, և կրկին փորձեք';
   enfailedtoexecute = 'Failed to execute';
   hyfailedtoexecute = 'Գործածումը խափանվել է';
   enrunning = 'Running ';
   hyrunning = 'Գործարկվում է ';
   ensuccess = 'Fonts have been installed successfully';
   hysuccess = 'Շնորհավորու՛մ ենք։ Տառատեսակների տեղակայումը հաջովեց։ Վերբենռեք ձեր սարքը։';
   ennotsuccess = 'Installation failed.';
   hynotsuccess = 'Ցավոք տեղակայումը խափանվեց։';
var languagenames : array of string;
    language : byte;
procedure SetLang(a : byte);
function GetLang() : byte;
procedure Init;
implementation

procedure Init;
begin
language := hy;
setlength(languagenames, langcount);
languagenames[0] := 'English';
languagenames[1] := 'Հայերեն';
end;

procedure SetLang(a : byte);
begin
    language := a;
end;//SetLang

function GetLang() : byte;
begin
     GetLang := language;
end;//GetLang;

//initialization



end.

