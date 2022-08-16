{%- macro sidebyside(titles=['Unix', 'Windows'], code=True) -%}
    <div class="row side-by-side-commands">
        {%- for title in titles -%}
            <div class="col">
                <h4>{{ title }}</h4>
{%- filter markdown() -%}
{%- if code -%}```
    {%- if title.lower().startswith('win') -%}dosvenv{%- else -%}console{%- endif -%}
{%- endif -%}
{{ caller() | extract_part(loop.index0, '---') | dedent }}
{%- if code -%}```{%- endif -%}
{%- endfilter -%}
            </div>
        {%- endfor -%}
    </div>
{%- endmacro -%}

# Nastavení prostředí

V této sekci si:
* připravíš adresář, do kterého budeš ukládat soubory k začátečnickým kurzům
  Pythonu a
* aktivuješ virtuální prostředí.

## Příprava adresáře

Programátoři vytváří spoustu souborů a víc než u mnoha jiných uživatelů
počítače jim záleží na tom, kde jsou ty soubory uložené.

Níže uvedený postup zdaleka není jediná možnost, jak si organizovat soubory.
Když ale použiješ tenhle ozkoušený způsob,
může to hodně zjednodušit život těm, kteří ti budou pomáhat
s případnými problémy.

{%- if var('pyladies') -%}
{% set rootname = 'pyladies' %}
{%- else -%}
{% set rootname = 'naucse-python' %}
{%- endif %}

Nejdřív vytvoř adresář (složku), ve kterém budeš mít soubory ke kurzu Pythonu.
Může to být třeba `{{ rootname }}` ve tvém domovském adresáři.
(Můžeš ho pojmenovat i jinak, ale `{{ rootname }}` používají příklady níže.)

Zvolený adresář po vytvoření nesmíš přesouvat jinam.
Proto ho nedoporučuji vytvářet na Ploše.

> [note]
> Kdybys někdy adresář přece jen přesunul{{a}} jinam,
> přestane fungovat *virtuální prostředí*, které za chvíli vytvoříme.
> Musel{{a}} bys ho smazat a vytvořit nové.

Tenhle adresář budeš potřebovat na celý zbytek kurzu i na případné
navazující kurzy.
Poznamenej si proto kde přesně je – zkopíruj si celé jeho jméno, které pak
můžeš vložit do `cd` v příkazové řádce nebo do grafického prohlížeče souborů.


### Adresář pro každou lekci

Nový adresář je zatím prázdný.
To se ale brzo změní a čím víc věcí v něm bude, tím bude důležitější
mít obsah zorganizovaný.

Pro začátek si budeme tvořit nový podadresář pro každou lekci tohoto kurzu.
Aby byly tyhle adresáře hezky seřazené, budeme je číslovat:
tahle první lekce bude mít číslo `00`,
příště si vytvoříš adresář `01` a tak dále.

Všechny budou v tvém novém adresáři, který jsi vytvořil{{a}} před chvilkou.

Adresář `00` si vytvoř už teď.
(Možná do něj dnes nic nedáš, ale hodí se ho mít jako ukázku pro příště.)


### Přepnutí

Pak otevři příkazovou řádku a příkazem `cd` přepni do adresáře,
ve kterém jsi právě vytvořil{{a}} `00` (t.j. ne přímo do `00`).
Například:

```console
$ cd {{ rootname }}
```

Pak zkontroluj, že jsi na správném místě:
* Pomocí příkazu `pwd` (na Windows `cd`) zkontroluj,
  že opravdu jsi v nově vytvořeném adresáři.
* Pomocí příkazu `ls` (na Windows `dir`) zkontroluj,
  že v něm je podadresář `00`.

Například:

{% call sidebyside(titles=['Unix (Linux, macOS)', 'Windows']) %}
$ pwd
/home/helena/{{rootname}}

$ ls
00
---
> cd
C:\Users\Helena\{{rootname}}

> dir
 Directory of C:\Users\Helena\{{rootname}}
05/08/2014 07:28 PM <DIR>  00
{% endcall %}


## Virtuální prostředí

Teď si vytvoříš *virtuální prostředí* pro Python.

Virtuální prostředí je něco, co zajistí že se všechny počítače budou
chovat zhruba stejně.
Až ho zprovozníme, nebudu už potřebovat instrukce zvlášť pro Linux,
zvlášť pro Windows a zvlášť pro macOS.

> [note]
> V budoucnu využiješ i druhou výhodu: každé virtuální prostředí je oddělené od
> ostatních, takže když doinstaluješ nějakou knihovnu (rozšíření pro Python),
> projeví se to jen v jednom virtuálním prostředí.
> Kdyby se pak při práci na projektu něco pokazilo, neohrozí to další
> projekty ve tvém počítači.

Jak na to?
Na každém systému jinak!

* **Linux**:

   Podle toho jak máš Python nainstalovaný bude fungovat jeden z následujících
   příkazů.
   Bude je rychlejší vyzkoušet než popsat kdy je který správný,
   takže nejdřív zkus:

   ```console
   $ python3 -m venv venv
   ```

   A jestli dostaneš chybu `No module named venv`, zkus místo toho:

   ```console
   $ virtualenv -p python3 venv
   ```

* **macOS**:

   ```console
   $ python3 -m venv venv
   ```

* **Windows**:

   Podle toho jak máš Python nainstalovaný bude fungovat jeden z následujících
   příkazů.
   Bude je rychlejší vyzkoušet než popsat kdy je který správný,
   takže nejdřív zkus:

   ```doscon
   > py -3 -m venv venv
   ```

   A jestli dostaneš chybu `'py' is not recognized`, zkus místo toho:

   ```doscon
   > python3 -m venv venv
   ```

Tím se ti vytvořil adresář `venv`, který virtuální prostředí obsahuje.
Můžeš se podívat dovnitř, ale neukládej tam své soubory a nikdy tam nic neměň!

Zkontroluj si, že `00` a `venv` jsou pěkně vedle sebe:

{% call sidebyside(titles=['Unix', 'Windows']) %}
$ ls
01
venv
---
> dir
 Directory of C:\Users\Helena\{{rootname}}
05/08/2014 07:28 PM <DIR>  00
05/08/2014 07:38 PM <DIR>  venv
{% endcall %}

V grafickém prohlížeči souborů to vypadá např. takto:

{{ figure(
    img=static('dirs-00.png'),
    alt="(adresáře '00' a 'venv' vedle sebe)",
) }}


### Aktivace virtuálního prostředí

Nakonec virtuální prostředí aktivuj:

{% call sidebyside(titles=['Unix', 'Windows'], code=False) %}
```console
$ source venv/bin/activate
```
---
```doscon
> venv\Scripts\activate
```

Jestli používáš  příkazovou řádku ve Visual Studio Code,
je příkaz pro Windows složitější:
```doscon
> &powershell -ExecutionPolicy bypass
> venv/Scripts/Activate.ps1
```
{% endcall %}

Po spuštění tohoto příkazu by se mělo na začátku příkazové řádky
(před `$` nebo `>`) objevit slovo `(venv)`.
Tak poznáš, že je virtuální prostředí *aktivní*.

Aktivační příkaz si zapiš.

Vždycky, když pustíš příkazovou řádku ve které budeš zkoušet své programy,
budeš muset pomocí `cd` přepnout do `{{rootname}}` a zadat tento
aktivační příkaz.
