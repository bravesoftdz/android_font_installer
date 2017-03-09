unit Trans;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const langcount = 2;
const en = 0;
const hy = 1;

const
   hytitle = 'Հայերեն տառատեսակների տեղակայում Անդրոիդ սարքերի համար';
   entitle = 'Armenian fonts installer for Android phones';
   hyabout = 'Ծրագրի մասին';
   enabout = 'About ...';
   enAboutTitle = 'Ծրագրի մասին';
   enAboutContent = 'Ինչո՞ւ ապշած ես, լըճակ,' + LineEnding +
'Ու չեն խայտար քո ալեակք,' + LineEnding +
'Միթէ հալւոյդ մեջ անձկաւ' + LineEnding +
'Գեղուհի՞ մը նայեցաւ:';
   hyAboutTitle = 'About';
   hyAboutContent = 'Ինչո՞ւ ապշած ես, լըճակ,' + LineEnding +
'Ու չեն խայտար քո ալեակք,' + LineEnding +
'Միթէ հալւոյդ մեջ անձկաւ' + LineEnding +
'Գեղուհի՞ մը նայեցաւ:';
   enbefore = 'Before installing restart the phone into recovery mode';
   hybefore = 'Տեղակայելուց արաջ բեռնեք հեռախոսը «recovery mode»';
   hypathadb = 'adb ֆայլի ուղին';
   engpathadb = 'path to the adb file';
   hybrowse = 'զննել';
   enbrowse = 'browse';
   hyinstall = 'տեղակայել տառատեսակները';
   eninstall = 'install fonts';
   hychooselang = 'ընտրեք միջներեսի լեզուն';
   enchooselang = 'choose interface language';
   enshowpath = 'Please, first show path to the "adb" executable';
   hyshowpath = 'Խնդրում ենք սկզբից ցույց տալ "adb" ծրագրի ուղին';
   enwaitingfordevice = 'Waiting for device. Ensure USB debugging is enabled.';
   hywaitingfordevice = 'Միացրեք սարքը։ Համոզվեք, որ "USB debugging"-ը ակտիվացված է';
   enfailedtoexecuteadb = 'Failed to execute "adb kill-server". Please, ensure you have provided the correct file and try again';
   hyfailedtoexecuteadb = 'Խափանվել է "adb kill-server" գործածումը։ Համոզվեք, որ դուք ուղին ճիշտ է, և կրկին փորձեք';
   enfailedtoexecute = 'Failed to execute';
   hyfailedtoexecute = 'գործածումը խափանվել է';
   enrunning = 'Running ';
   hyrunning = 'Գործարկվում է ';
   ensuccess = 'Fonts have been installed successfully';
   hysuccess = 'Տառատեսակների տեղակայումը հաջովեց';
   ennotsuccess = 'Installation failed.';
   hynotsuccess = 'Տեղակայումը խափանվեց։';
var languagenames : array of string;
    language : byte;
procedure SetLang(a : byte);
function GetLang() : byte;
procedure Init;
implementation

procedure Init;
begin
language := en;
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

