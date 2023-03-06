# Instalace Pythonu pro Windows

## Zjisti, jestli už máš Python nainstalovaný

Otevři si příkazovou řádku (pokud nevíš o co jde, přečti si o ní [tady]({{ lesson_url('beginners/cmdline') }})).

Napiš `python` a zmáčkni na klávesnici <kbd>Enter</kbd>. Teďka se může stát několik různých věcí:
1. Otevře se ti Microsoft Store → okno zavři a pokračuj v kroku [Stažení](#download)
1. Zobrazí se ti text podobný tomuto níže?
```plain
> python
Python 3.8.1 (...)
Type "help", "copyright", "credits" or "license" for more information.
>>>
```
To je dobrá zpráva! Ještě si zkontroluj, jakou verzi máš nainstalovanou (např.`Python 3.11.2` je `3.11`,
`Python 3.8.1` je `3.8` atd.). Třetí číslo za tečkou není tady podstatné.
  - je verze `3.6` nebo novější? Výborně, máš instalaci hotovou! Okýnko s příkazovou řádkou můžeš pro teďka zavřít. Až ho budeš znovu potřebovat, můžeš otevřít nové.
  Pokračuj dále [Nastavením prostředí]({{ lesson_url('beginners/venv-setup') }}).
  - v opačném případě přejdi na [Stažení](#download)
1. Stane se něco jiného? Řekni si o pomoc.



{{ anchor('download') }}
## Stažení
- Běž na [stahovací stránku](https://www.python.org/downloads/windows/)
- klepni na *Latest Python 3 Release*
- v části *Files*, ve sloupci *Version*, vyber vhodný *Windows installer* pro tvou verzi windows (32 nebo 64bit).

> [note]
> Kde zjistíš, zda máš 32bitové nebo 64bitové Windows? Otevři nabídku
> **Start**, vyhledat „Systém“ a otevřít **Systémové informace**.
> Pokud máš novější počítač, téměř jistě budeš mít Windows 64bitové.
>
> {{ figure(
    img=static('windows_32v64-bit.png'),
    alt='Screenshot zjišťování verze systému',
) }}

## Instalace

Stažený instalátor spusť.

Na začátku instalace zaškrtni:
- **Use admin privileges when installing py.exe**
- a také **Add python.exe to PATH**.
Tyto volby ti zjednoduší vytvoření virtuálního prostředí.

(Jestli nemáš administrátorské oprávnění, volbu
*Use admin privileges when installing py.exe* nezaškrtávej.)

{{ figure(
    img=static('windows_add_python_to_path.png'),
    alt='Screenshot instalace Pythonu',
) }}

Pak zmáčkni **Install now** a dále se drž instrukcí.

Máš-li otevřenou příkazovou řádku, po instalaci Pythonu ji zavři a otevři
novou.
Instalace mění systémové nastavení, které se musí načíst znovu.
