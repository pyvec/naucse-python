# Instalace Pythonu pro Windows

Máš-li Windows 10 nebo novější, otevři příkazovou řádku - nabídka start `cmd` - spustit příkazovou řádku.
Zadej do příkazové řádky python3.

Pokud ještě Python nemáš nainstalovaný, otevře se ti automaticky stránka Microsoft Store.
Python nainstaluj z ní. Pokud máš v oblibě jiné instalátory jako např. `choco` nebo `winget`, můžeš je použít.

Jestli Python už nainstalovaný máš, ukáže se ti v příkazové řádce něco jako:

```
> python3
Python 3.9.6 ...
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

Na prvním řádku výstupu je verze Pythonu. Zkontroluj si, že verze je 3.9 nebo novější.

Jestli ne, pokračuj sekcí níže.

Jestli ano, Python máš nainstalovaný! Ukonči ho zkratkou Ctrl+Z a Enter, aby řádek, kam budeš psát další příkazy, nezačínal na „tři zobáčky“ (>>>).
(Nebo okýnko s příkazovou řádkou zavři. Až ho budeš znovu potřebovat, můžeš otevřít nové.)

## Manuální instalace
Běž na [stahovací stránku Pythonu](https://www.python.org/downloads/)
a stáhni si instalátor nejnovější stabilní verze Pythonu.
Ověř si že je to verze **3.9.0 nebo novější** –
verze 3.9.0 má jistá vylepšení, která budeme v tomto kurzu používat.

Jak poznat, který instalátor je ten pravý?
Pokud má tvůj počítač 64bitovou verzi Windows,
stáhni si *Windows x86-64 executable installer*.
Pokud máš starší počítač s 32bitovými Windows,
stáhni si *Windows x86 executable installer*.
(Rozdíl je v *x86-64* versus *x86*.)

> [note]
> Kde zjistíš, zda máš 32bitové nebo 64bitové Windows? Otevři nabídku
> **Start**, vyhledat „Systém“ a otevřít **Systémové informace**.
> Pokud máš novější počítač, téměř jistě budeš mít Windows 64bitové.
>
> {{ figure(
    img=static('windows_32v64-bit.png'),
    alt='Screenshot zjišťování verze systému',
) }}

Stažený instalátor spusť.
Na začátku instalace zaškrtni **Install launcher for all users**
a také **Add Python to PATH**.
Tyto volby ti zjednoduší vytvoření virtuálního prostředí.

(Jestli nemáš administrátorské oprávnění, volbu
*Install launcher for all users* nezaškrtávej.)

{{ figure(
    img=static('windows_add_python_to_path.png'),
    alt='Screenshot instalace Pythonu',
) }}

Pak zmáčkni **Install now** a dále se drž instrukcí.

Máš-li otevřenou příkazovou řádku, po instalaci Pythonu ji zavři a otevři
novou.
Instalace mění systémové nastavení, které se musí načíst znovu.
