{%- macro sidebyside(titles=['Unix', 'Windows']) -%}
    <div class="row side-by-side-commands">
        {%- for title in titles -%}
            <div class="col">
                <h4>{{ title }}</h4>
{%- filter markdown() -%}
```{%- if title.lower().startswith('win') -%}dosvenv{%- else -%}console{%- endif -%}
{{ caller() | extract_part(loop.index0, '---') | dedent }}
```
{%- endfilter -%}
            </div>
        {%- endfor -%}
    </div>
{%- endmacro -%}


# Příkazová řádka

V této lekci se seznámíme s *příkazovou řádkou* – černým okýnkem,
které programátoři používají na zadávání textových příkazů.

Na většinu z toho, co příkazová řádka umí, můžeš použít i něco jiného – ikonku
na ploše, speciální program nebo editor, webovou aplikaci – ale tyhle
vychytávky mají dvě nevýhody:
* často se liší mezi různými počítači, takže s „tvojí“ variantou ti bude moci
  pomoct míň lidí, a
* z příkazové řádky se dá jednoduše kopírovat text, což zjednodušuje
  spolupráci přes e-mail nebo chat.

I když příkazová řádka možná není úplně nejjednodušší způsob jak
s programováním začít,
dlouhodobě se ti základy práce s ní určitě vyplatí.
A i o tom tenhle kurz je.

Příkazová řádka (respektive program, kterému se říká i *konzole* či *terminál*;
anglicky *command line*, *console*, *terminal*)
se na různých systémech otevírá různě:

* Windows (české): Start → napsat na klávesnici „cmd“ → Příkazový řádek
* Windows (anglické): Start → napsat na klávesnici „cmd“ → Command Prompt
* macOS (anglický): Applications → Utilities → Terminal
* Linux (GNOME, čeština): Činnosti → hledat Terminál
* Linux (GNOME, angličtina): Activities → hledat Terminál
* Linux (KDE): Hlavní Menu → hledat Konsole

Nevíš-li si rady, zkus buď googlit, nebo se zeptat někoho zkušenějšího.

Po otevření konzole tě uvítá *výzva* (angl. *prompt*): řádek,
kterým počítač vybízí k zadání příkazu.
Výzva končí na Unixových systémech (např. Linux a macOS) znakem `$`;
na Windows znakem `>`.

Před tím znakem `$` nebo `>` budou nejspíš ještě nějaké další
informace, které jsou ovšem v těchto materiálech vynechané.
A budou vynechané i ve většině ostatních návodů co najdeš na internetu.
Na každém počítači totiž můžou být trochu jiné.

{% call sidebyside(titles=['Unix (Linux, macOS)', 'Windows']) %}
$
---
>
{% endcall %}

Podle systému se potom liší i samotné příkazy, které budeš zadávat:
Unixové systémy (Linux a macOS) rozumí jiným příkazům než Windows.

> [note] Velikost písma
> Je-li ve Windows moc malé písmo, klikni na ikonku okna a vyber Možnosti.
> V záložce Písmo si pak můžeš vybrat větší font.
> <!-- XXX: are the Czech names correct? -->
>
> {{ figure(
     img=static('windows-cmd-properties.png'),
     alt='Screenshot menu příkazové řádky',
) }}
>
> Na ostatních systémech hledej v nastavení, nebo zkus
> <kbd>Ctrl</kbd>+<kbd>+</kbd> a
> <kbd>Ctrl</kbd>+<kbd>-</kbd> (příp. se Shift).


## První příkaz

Začněme ale příkazem, který je všude stejný.
Napiš `whoami` (z angl. *who am I?* – kdo jsem?)
a stiskni <kbd>Enter</kbd>.
Objeví se přihlašovací jméno. Třeba u Heleny by to vypadalo takhle:

{% call sidebyside() %}
$ whoami
helena
---
> whoami
pocitac\Helena
{% endcall %}

> [note]
> Znak `$` nebo `>` je v ukázce jen proto, aby bylo jasné že zadáváš
> příkaz do příkazové řádky.
> Vypíše ho počítač, většinou ještě s něčím před ním,
> takže ho nepiš {{gnd('sám','sama')}}! Zadej jen `whoami` a <kbd>Enter</kbd>.
>
> Stejně tak počítač sám vypíše přihlašovací jméno.


## Aktuální adresář

Příkazová řádka pracuje vždy v nějakém *adresáři* neboli *složce*
(angl. *directory*, *folder*).
Adresář a složka jsou synonyma; můžeš používat kterékoli z nich.

Ve kterém adresáři zrovna jsi, to ti poví příkaz, který se podle systému
jmenuje `pwd` nebo `cd` (z angl. *print working directory* – vypiš pracovní
adresář, resp. *current directory* – aktuální adresář).

{% call sidebyside() %}
$ pwd
/home/helena/
---
> cd
C:\Users\helena
{% endcall %}

Aktuální adresář se většinou ukazuje i ve výzvě příkazové řádky, před znakem
`$` nebo `>`.
Ale je dobré `pwd`/`cd` znát, kdyby ses náhodou ztratil{{a}}.
Občas totiž bývá vypsaný zkráceně.
A taky třeba budeš v budoucnu muset pracovat na počítači který před `$`
ukazuje něco jiného.

Něco jako aktuální adresář možná znáš z grafických programů,
kterými vybíráš soubory: typicky mají v horní (nebo na Macu dolní)
části uvedeno který adresář zrovna ukazují.
Příkazová řádka umí soubory ukazovat taky – ale musíš si o to říct.


## Co v tom adresáři je?

Příkaz `ls` nebo `dir` (z angl. *list* – vyjmenovat, resp. *directory* – adresář)
ti vypíše, co aktuální adresář obsahuje: všechny soubory,
včetně podadresářů, které se v aktuálním adresáři nacházejí.

{% call sidebyside() %}
$ ls
Applications
Desktop
Downloads
Music
…
---
> dir
 Directory of C:\Users\helena
05/08/2014 07:28 PM <DIR>  Applications
05/08/2014 07:28 PM <DIR>  Desktop
05/08/2014 07:28 PM <DIR>  Downloads
05/08/2014 07:28 PM <DIR>  Music
…
{% endcall %}


## Změna aktuálního adresáře

Aktuální adresář se dá změnit pomocí příkazu `cd`
(z angl. *change directory* – změnit adresář).
Za `cd` se píše mezera a jméno adresáře, kam chceš přejít.
Pokud máš adresář `Desktop` nebo `Plocha`, přejdi tam.
Pak nezapomeň ověřit, že jsi na správném místě.

Používáš-li Linux nebo macOS, dej si pozor na velikost písmen: na těchto
systémech jsou `Desktop` a `desktop` dvě různá jména.

Používáš-li Windows, `cd` už jsi používal{{a}} – tento příkaz se chová různě
podle toho, jestli něco napíšeš za něj nebo ne.

{% call sidebyside() %}
$ cd Desktop
$ pwd
/home/helena/Desktop
---
> cd Desktop
> cd
C:\Users\helena\Desktop
{% endcall %}

> [note] Poznámka pro Windows
> Pokud přecházíš do adresáře na jiném disku,
> například `D:` místo `C:`, je potřeba kromě `cd`
> zadat jméno disku s dvojtečkou jako zvláštní příkaz (např. `D:`).


## Vytvoření adresáře

Co takhle si zkusit vytvořit adresář? To se dělá příkazem `mkdir`
(z angl. *make directory* – vytvořit adresář).
Za tento příkaz napiš jméno adresáře, který chceš vytvořit – v našem případě
`zkouska`:

{% call sidebyside() %}
$ mkdir zkouska
---
> mkdir zkouska
{% endcall %}

Vypiš si teď obsah aktuálního adresáře pomocí `ls` nebo `dir`.
Jeden z vypsaných adresářů bude `zkouska`.

Když je adresář vytvořený, můžeš do něj přejít podobně jako jsi před chvílí
{{gnd('přešel', 'přešla')}} na `Desktop` nebo `Plocha`:

{% call sidebyside() %}
$ cd zkouska
---
> cd zkouska
{% endcall %}


## V grafickém hledátku

Často nebudeš pracovat *jenom* s příkazovou řádkou.
Vyplatí se umět aktuální adresář z příkazové řádky otevřít i v jiných
programech.

Otevři si prohlížeč souborů.
Tenhle program je na každém systému jiný:

<div class="row side-by-side-commands">
    <div class="col">
        <h4>Linux</h4>
        {{ figure(
            img=static('linux-file-browser.png'),
            alt='Screenshot programu Nautilus na GNOME',
        ) }}
    </div>
    <div class="col">
        <h4>macOS</h4>
        {{ figure(
            img=static('macos-file-browser.png'),
            alt='Screenshot programu Finder na macOS',
        ) }}
    </div>
    <div class="col">
        <h4>Windows</h4>
        {{ figure(
            img=static('windows-file-browser.png'),
            alt='Screenshot průzkumníka na Windows',
        ) }}
    </div>
</div>

Možná umíš v tomhle programu klikáním „donavigovat“ do adresáře, který je
aktivní v příkazové řádce.
V budoucnu to ale bude složitější, takže bude dobré si vyzkoušet kopírovat text
z příkazové řádky a vložit ho do prohlížeče souborů.

Bohužel se to dělá na každém systému jinak.
A protože známé zkratky <kbd>Ctrl</kbd>+<kbd>C</kbd> a
<kbd>Ctrl</kbd>+<kbd>V</kbd> dělají v příkazové řádce něco jiného než
kopírování, nejspíš se to dělá jinak, než jsi zvykl{{gnd('ý', 'á')}}.

Nejdřív si pomocí příkazu `cd` nebo `pwd` nech vypsat celé jméno adresáře
`zkouska`:

{% call sidebyside() %}
$ pwd
/home/helena/Desktop/zkouska
---
> cd
C:\Users\helena\Desktop\zkouska
{% endcall %}

### Kopírování z příkazové řádky

Na **Linuxu** vyber text myší a pak buď:
* pravým tlačítkem myši otevři menu a vyber *Kopírovat* nebo *Copy*, nebo
* zmáčkni <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>C</kbd>.
  (Pozor, v příkazové řádce musíš použít navíc Shift.)

Na **macOS** vyber text myší a pak stiskni <kbd>⌘ Command</kbd>+<kbd>C</kbd>.

Na **Windows** v menu příkazové řádky (ikonce vlevo nahoře) vyber
*Edit* → *Mark*, text vyber myší a zkopíruj pomocí <kbd>Enter</kbd>.

### Otevření v prohlížeči souborů

Na **Linuxu** záleží na programu, který používáš. Buď:
* zmáčkni <kbd>Ctrl</kbd>+<kbd>L</kbd> a jméno adresáře vlož pomocí
  <kbd>Ctrl</kbd>+<kbd>V</kbd>, nebo
* vyber jméno adresáře v horní části, smaž ho a vlož nové pomocí
  <kbd>Ctrl</kbd>+<kbd>V</kbd>.
V obou případech potvrď pomocí <kbd>Enter</kbd>

Na **macOS** vyber v menu *Go* → *Go to Folder*, vlož jméno adresáře pomocí
<kbd>⌘ Command</kbd>+<kbd>V</kbd> a potvrď pomocí <kbd>Enter</kbd>.

Na Windows klikni na jméno adresáře v horní části.
Převede se tím na editovatelný text.
Smaž ho a pomocí <kbd>Ctrl</kbd>+<kbd>V</kbd> místo něj vlož nové jméno.
Potvrď pomocí <kbd>Enter</kbd>.


Teď se můžeš podívat na Plochu nebo do nějakého grafickém programu na
prohlížení adresářů: zjistíš, že se adresář opravdu vytvořil.

### Vkládání do příkazové řádky

Občas si otevřeš soubor v prohlížeči souborů a budeš do něj chtít přejít
v příkazové řádce.
Zkopírování jména adresáře doufám nebude problém; vkládání do příkazové řádky
je ale občas jiné než v ostatních programech:

* Linux: <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>V</kbd>
* macOS: <kbd>⌘ Command</kbd>+<kbd>V</kbd>
* Windows: Menu *Edit* → *Paste*

> [note]
> Pokud jsou ve jménu mezery nebo jiné speciální znaky jako `*#$%^()><;"?`,
> musíš ho v příkazové řádce ještě uzavřít do uvozovek: před a za jméno napiš
> `"`, např:
>
> ```console
> $ cd "můj super adresář"
> ```
>
> Lepší je ale mezery a zvláštní znaky ve jménech souborů nepoužívat.


## Pozorování změn

Vyzkoušej si, že se v řádce projeví i změny, které na počítači
uděláš jiným způsobem.

V grafickém prohlížeči, který se „dívá“ na stejný adresář, jako máš aktivní
v příkazové řádce, vytvoř nový soubor nebo adresář.
Pak se pomocí příkazu `ls` nebo `dir` podívej, že se opravdu vytvořil.
Potom ho v grafickém programu smaž – a v příkazové řádce se ujisti,
že je opravdu smazaný.

Na počítači máš jen jednu sadu souborů, se kterou umí manipulovat jak grafické
programy tak příkazová řádka.


## O úroveň nahoru

A poslední věc: jsi-li teď v adresáři `Desktop/zkouska` (nebo `Plocha/zkouska`,
`Desktop\zkouska` atp.), jak se dostat zpátky do `Desktop`?

Příkaz `cd Desktop` fungovat nebude: tím bys počítači řekl{{a}}, ať se přepne
do adresáře `Desktop` *v aktuálním adresáři*.
Ale v adresáři `zkouska` žádný `Desktop` není!
Je to naopak: `zkouska` je v `Desktop`.
Odborně řečeno, adresář `Desktop` je *nadřazený* aktuálnímu adresáři.

Nadřazený adresář má speciální jméno `..`, dvě tečky.
Přejdi do něj zadáním `cd ..` a pak se ujisti, že jsi opravdu v `Desktop`:

{% call sidebyside() %}
$ cd ..
$ pwd
/home/helena/Desktop
---
> cd ..
> cd
C:\Users\helena\Desktop
{% endcall %}

Další `cd ..` by tě přesunulo do dalšího nadřazeného adresáře – v našem
příkladu `helena`.


## Konec

Příkazů existuje samozřejmě daleko víc.

Když se je naučíš, můžeš z příkazové řádky plnohodnotně ovládat
počítač: vytvářet soubory, mazat je, pouštět programy, měnit nastavení
a podobně.
Vydalo by to ale vydalo na samostatný kurz, a tak tady skončíme.

Vyzkoušej si ještě jeden příkaz, ten, který příkazovou řádku zavírá: `exit`.

Příkaz `exit` funguje stejně na všech systémech.
To samé platí pro překvapivě mnoho příkazů (kromě těch základních jako
`cd`, `pwd` a `ls`).
Proto ve zbytku těchto materiálů nebudu používat ukázky dvojmo podle
operačního systému.

A budu používat unixovskou výzvu `$`.
S touto konvencí se setkáš i ve většině návodů na internetu.
Používáš-li Windows, je dobré si na `$` zvyknout i když ve své
řádce máš místo něj `>`.

Zkus si tedy, co dělá příkaz `exit`:

```console
$ exit
```

A tím je úvod do příkazové řádky hotový.


## Přehled

Tady je tabulka základních příkazů, se kterými si do začátku vystačíš:

<table class="table">
    <tr>
        <th>Unix</th>
        <th>Windows</th>
        <th>Popis</th>
        <th>Příklad</th>
    </tr>
    <tr>
        <td><code>cd <var>adresář</var></code></td>
        <td><code>cd <var>adresář</var></code></td>
        <td>změna adresáře</td>
        <td><code>cd test</code><br><code>cd ..</code></td>
    </tr>
    <tr>
        <td><code>pwd</code></td>
        <td><code>cd</code></td>
        <td>výpis aktuálního adresáře</td>
        <td><code>pwd</code><br><code>cd</code></td>
    </tr>
    <tr>
        <td><code>ls</code></td>
        <td><code>dir</code></td>
        <td>výpis adresáře</td>
        <td><code>ls</code><br><code>dir</code></td>
    </tr>
    <tr>
        <td><code>exit</code></td>
        <td><code>exit</code></td>
        <td>ukončení</td>
        <td><code>exit</code></td>
    </tr>
</table>

Další příkazy jako `python` nebo `git` si vysvětlíme až budou potřeba,
po tom, co si je nainstaluješ.
