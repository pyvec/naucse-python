# Vytvoření lokálního kurzu

## Příprava

První věc, kterou budeš potřebovat, je Python, a to alespoň ve verzi 3.8.
Pokud zrovna danou verzi Pythonu nainstalovanou nemáš, můžeš postupovat podle [návodu na instalaci Pythonu][beginners-install].

[beginners-install]: {{lesson_url("beginners/install")}}

Druhá věc, kterou budeš potřebovat, je Git – pokud nemáš ten, můžeš postupovat podle [návodu na instalaci Gitu]({{lesson_url("git/install")}}).

Třetí věc, kterou budeš potřebovat, je nástroj Poetry.
Ten můžeš nainstalovat několika způsoby:

- Na některých variantách Linuxu můžeš nainstalovat systémový balíček, který se pak bude aktualizovat spolu se systémem), např.:
  - Fedora: `sudo dnf install poetry`
- Poetry můžeš nainstalovat do systému podle [návodu](https://python-poetry.org/docs/#installation) na stránkách Poetry
- Můžeš si aktivovat [virtuální prostředí]({{lesson_url("beginners/venv-setup")}}) a Poetry nainstalovat pomocí:
  ```console
  $ python -m pip install --user poetry
  ```

Poslední věc, kterou potřebuješ, už není žádný program, ale pár schopností.
Je potřeba, abys uměl{{a}} pracovat s příkazovou řádkou (terminálem), Gitem
a formátem YAML.
Vše potřebné si můžeš připomenout v [návodu na používání terminálu]({{lesson_url("beginners/cmdline")}}),
[návodu na používání Gitu]({{lesson_url("git/git-collaboration-2in1")}})
a v [úvodu k YAMLu]({{lesson_url("fast-track/yaml")}}).


## Naklonování základu

Kurz můžeš vytvořit úplně od začátku, ale pro začátek lepší varianta je vyjít
z nějakého už existujícího.
Naklonuj si buď základní začátečnický kurz z [https://github.com/pyvec/naucse-python](https://github.com/pyvec/naucse-python),
nebo si na naucse.python.cz vyber jiný základ.
(Odkaz na repozitář najdeš v patičce stránky kurzu.
Historické kurzy ale můžou být už zaarchivované a nejnovější verze v repozitáři
nemusí odpovídat tomu co je na webu.)


## Kontrola nastavení projektu

Zkontroluj si, že naklonovaný kurz obsahuje soubor `pyproject.toml`
s verzí `naucse = 0.5.0` nebo vyšší. Třeba takto:

```console
$ git grep ^naucse pyproject.toml
pyproject.toml:11:naucse = "^0.5.1"
pyproject.toml:12:naucse-render = "^1.8"
```

Jestli soubor `pyproject.toml` vůbec nemáš, zkopíruj si ho
[z repozitáre naucse-python](https://github.com/pyvec/naucse-python/blob/main/pyproject.toml).
Jestli máš starší verzi `naucse`, aktualizuj příkazem `poetry add naucse@latest`.


## Lokální spuštění

Po naklonování si zkontroluj, že kurz u tebe „jede“.

Nainstaluj protřebné závislosti:

```console
$ poetry install
```

A spusť vývojový server:

```console
$ poetry run python -m naucse serve
```

Program vypíše adresu (např. `http://127.0.0.1:8003/`); tu navštiv v prohlížeči.
Tam se „doklikej“ na kurz, ze kterého budeš vycházet.


## Struktura repozitáře

V repozitáři s kurzem najdeš následující soubory a adresáře:

### `lessons/`: Texty lekcí

Jednotlivé lekce jsou rozděleny do „kategorií“, aby se dalo lépe „smíchat“
několik kurzů dohromady.
Každá lekce má vlastní adresář se dvěma soubory:

* `info.yml` obsahuje metadata, například:

    ```yaml
    title: Vytvoření lokálního kurzu
    style: md
    attribution:
    - Napsal Mikuláš Poul, 2018
    - Napsal Petr Viktorin, 2022
    license: cc-by-sa-40
    license_code: cc0
    ```

    * `title` je titulek stránky, který se objeví v obsahu.
    * `style` je typ obsahu: `md` pro Markdown nebo `ipynb` pro
      Jupyter Notebooka
    * `attribution` je seznam autorů, který se objeví v patičce stránky.
    * `license` je kód licence, pod kterou lze šířit obsah lekce.
     (Stránky naucse.python.cz mají seznam přípustných licencí. Chceš-li
     použít jinou, kontaktuj Petra.)
    * `licence_code` je kód licence, pro ukázky kódu v textu. Je dobré
     použít `cc0`, aby čtenáři mohli kód používat bez omezení. Pokud je ale
     kód např. založený na dokumentaci Pythonu (nebo jiného projektu),
     je potřeba dodržet podmínky daného zdroje.
    * `pages` je seznam *podstránek*, které se používají např. pokud má být
     obsah lekce různý pro různé systémy.
     Viz např. lekce [instalace Pythonu]({{lesson_url("beginners/install")}}).

* `index.md` (resp. `index.ipynb`) obsahuje zdrojový text lekce ve formátu
  Markdown (resp. Jupyter Notebook JSON).

* Adresář `static/` obsahuje obrázky nebo jiné statické soubory k lekci.

### `course.yml`, `courses`, `runs`: Definice kurzu

Definice kurzu je uložena v souboru YAML.
Jsou dvé možnosti, kde tenhle soubor může být:

* `course.yml`: Jestli spravuješ jen jeden kurz, dej jeho definici do souboru
  `course.yml`.
* `courses/*.yml`: Jestli plánuješ mít v jednom repozitáři více kurzů,
  které budou sdílet obsah lekcí, tak pro každý vymysli identifikátor
  (malá písmena bez diakritiky, čísla, pomlčka, např. `zacatecnici-jaro`)
  a definici kurzu dej do souboru
  <code>courses/<var>identifikator</var>.yml</code>.
  Různým nástrojúm pro práci s kurzy pak budeš předávat přepínač
  <code>--slug <var>identifikator</var></code>.

Existuje i třetí možnost, spíš historická:

* <code>runs/<var>rok</var>/<var>identifikator</var>.yml</code>.
  Ta se hodí pokud chceš mít v repozitáři kurzy pro několik let.
  Většinou je ale lepší spravovat jen aktuální kurzy a ty staré archivovat.

Když zakládáš nový kurz, můžeš zkopírovat existující definici na nové místo,
nebo ji nechat kde je a změnit ji.

### `.github/workflows/main.yml`: Instrukce pro GitHub Actions

Tenhle soubor obsahuje instrukce pro GitHub Actions pomocí kterých se
kurz publikuje. Obsahuje kromě instalace a *cache* tři hlavní kroky:

- "kompilaci" kurzu do HTML a JSON souborů v adresáři `_compiled`,
- přidání adresáře `_compiled` do Gitu (pomocí nástroje `ghp_import`),
- notifikaci hooks.nauc.se,naucse.python.cz, aby se nová verze kurzu nasadila.

Tyhle instrukce můžou být pro každou sadu kurzů jiné.
Až budeš kurz přidávat na naucse.python.cz, měly by se zkontrolovat,
ale do té doby se s tímto souborem netrap.

### `licenses/`

Tenhle adresář obsahuje licence, pod kterými obsah může být.
Neměň ho.

### `pyproject.toml`, `poetry.lock`, `.github`: Definice projektu a závislostí

Tyhle soubory definují jaké nástroje se použijí pro publikování kurzu.


## Definice kurzu

Soubor `course.yml` nebo `courses/*.yml` obsahuje všechny informace
o kurzu – název, popisek, kde a kdy se koná a pak samozřejmě plán jednotlivých lekcí.

Celá definice kurzu je jeden velký slovník, který si postupně popíšeme a vyplníme.
Pro potřeby kurzu je [připravena šablona]({{static("info.yml")}}), kterou můžeš použít.

### Povinné informace

Nejdřív prvních pár základních povinných údajů:

* `title` slouží pro název kurzu (nepovinně lze dodefinovat pomocí `subtitle`)
* `description` slouží pro krátký popis kurzu (který se zobrazí v seznamu kurzů)
* `long_description` slouží pro dlouhý popis kurzu, který se zobrazí na stránce kurzu

A teď už jen nepovinné údaje.

### Místo a čas

Přidáváš-li kurz s instruktorem, kdy se na každou lekci budete scházet,
přidej informace o místu a času.
U kurzu pro samouky je naopak vynech.

* `place` slouží pro označení místa
* `time` slouží pro informaci o času, kdy se budou lekce konat.
  Je to popisek „pro lidi“, takže není nutný žádný specifický formát:
  můžeš napsat třeba `'Vždy půl hodiny před západem slunce'`.

Jestli chceš, aby pro kurz šel vygenerovat iCal soubor s plánem lekcí, přidej údaj `default_time`.
Tato hodnota musí být slovník, který obsahuje dva klíče `start` a `end`, kde bude čas lekcí.
Čas musí být ve formátu `HH:MM` a musí být obalen uvozovkami nebo apostrofy (kvůli té dvojtečce, aby si YAML nemyslel, že je to další slovník).

Kromě toho je potřeba zadat časovou zónu, kde se lekce odehrávají.
Pro ČR a Slovensko použij `Europe/Prague` (největší město v oblasti).

Takže třeba takhle:

```yaml
default_time:
  start: '18:00'
  end: '20:00'
timezone: Europe/Prague
```

Tohle výchozí čas.
U každé lekce se dá zvlášť nastavit jiný začátek a konec.


### Proměnné

Poslední nepovinná hodnota, než se dostaneme k obsahu kurzu, jsou proměné, které se definují klíčem `vars` a musí být také slovníkem.
Proměné mohou upravovat obsah lekcí a stránek kurzu, a pokud budeš vytvářet nebo upravovat materiály, můžeš si i definovat vlastní.

První proměnou, kterou můžeš použít je `user-gender`.
Pokud víš, že na tvém kurzu budou lidé jen jednoho pohlaví, můžeš nastavit materiály (které tak byly napsány), aby je správně oslovovaly.
Nastavíš to pomocí písmenka `f` pro ženy, `m` pro muže.
Pokud proměnou nevyplníš, materiály se přizpůsobí pro obě varianty.

Další proměnné závisí na konkrétních materiálech.
Začátečnický kurz používá tyto:

* `coach-present`: Pokud je tvůj kurz s lektorem nebo koučem, nastav tuto proměnou na `true`.
  Materiály pak budou místo hledání na internetu doporučovat rady od živých lidí.

* `pyladies` nastav na hodnotu `true`, pokud organizuješ kurz PyLadies.
  Tato proměná aktivuje v materiálech nějaké popisky navíc, například o tahácích, nebo také sjednotí názvy složek na `pyladies`.


### Plán lekcí

A teď už zbývá poslední věc, a to je sestavení programu kurzu.
Kurz se skládá z jednotlivých lekcí (*sessions*) a každá lekce obsahuje seznam materiálů.
Lekce nadefinuješ klíčem `sessions` v definici kurzu.
Ten musí být seznam dalších slovníků. Každý z nich představuje jednu lekci.

#### Definice lekce

Datum lekce nastavíš klíčem `date`, ve formátu `YYYY-MM-DD`.
Čas nastavovat nemusíš, použije se čas z `default_time`, ale můžeš ho přenastavit
pomocí klíče `time`, který bude mít jako hodnotu další slovník s hodnotami `start` a/nebo `end` (ve formátu `HH:MM` obalené uvozovkami).

Každá lekce má svůj identifikátor, který napiš do klíče `slug`.
Identifikátor musí být unikátní (v rámci kurzu).
Použije se v adrese (URL) lekce.

Dalším povinným údajem je `title` – název lekce.

Základní definice lekce tedy vypadá následovně:

```yaml
sessions:
- slug: first-lesson
  title: Název první lekce
  date: 2018-03-07
```

Většina lekcí bude mít navíc obsah – seznam materiálů.
Ty se nastavují pomocí klíče `materials`.

Existují tři druhy materiálů:

* **Interní materiály** se definují pomocí klíče `lesson`, do kterého patří
  identifikátor interního materiálu,
  tedy jméno podsložky ve složce `lessons`.
  Identifikátor materiálu je `<název kategorie>/<název materiálu z kategorie>`.
  Takže například materiál `beginners/install by se zadal takto:

    ```yaml
    sessions:
    - slug: first-lesson
      title: Název první lekce
      date: 2018-03-07
      materials:
      - lesson: beginners/install
    ```


* **Externí odkazy** se definují pomocí klíčů `url` a `title`.
  Do `url` patří kompletní odkaz na materiál, do `title` patří název odkazu.
  Příklad použítí:

    ```yaml
    sessions:
    - slug: first-lesson
      title: Název první lekce
      date: 2018-03-07
      materials:
      - title: Úvodní prezentace
        url: https://example.com/uvod.pdf
      - title: Tahák na příkazovou řádku
        url: https://example.com/tahak.pdf
        type: cheatsheet
      - title: Domácí projekty (PDF)
        url: https://example.com/ukol.pdf
        type: homework
    ```

* **Materiály bez odkazu** se definují stejně jako externí odkazy,
  jen se do klíče `url` dá hodnota `null`. Například:

    ```yaml
    sessions:
    - slug: last-lesson
      title: Název lekce
      date: 2019-03-07
      materials:
      - title: Přehlídka závěrečných projektů
        url: null
      - title: Předání diplomů
        url: null
    ```

U všech druhú materiálú lze nastavit typ, který určuje ikonku která se použije v seznamu materiálů vedle názvu.

Podporované typy jsou následující:

* `page` – výchozí typ pro druh interní materiály
* `url` – výchozí typ pro odkazy
* `cheatsheet` – pro taháky
* `homework` – pro domácí úkoly
* `special` – pro všechno ostatní

Poslední věc, která jde definovat u materiálů, jsou proměné, pomocí klíče `vars`.
Definují se stejně jako u celého kurzu, ale mají účinek jen pro specifický materiál.
Například takhle:

```yaml
plan:
- slug: first-lesson
  title: Název první lekce
  date: 2018-03-07
  materials:
  - lesson: beginners/install
    vars:
      bonus: true
```


## Otestování kurzu

Po vytvoření definice kurzu s povinnými položkami se můžeš podívat na to, jak tvůj kurz bude vypadat.
Spusť si vývojový server:

```console
$ poetry run python -m naucse serve
```

Otevři si adresu, kterou ti příkaz napíše. Měl by na ní být seznam nadefinovaných kurzů.

Pokud se stránka s kurzy nevykreslí, tak uvidíš Python vyjímku, která ti může pomoct, ale také může být pěkne matoucí.
Nejprve si zkontroluj, jeslti jsi vážně vyplnil{{a}} všechny povinné údaje.
Jestli si myslíš, že ano, tak se nám ozvi přes [issues na našem GitHubu](https://github.com/pyvec/naucse.python.cz/issues) a my ti rádi pomůžeme.
(Ozvi se i v případě že se ti podaří matoucí nebo nic neříkající chybu pochopit, ať ji můžeme opravit.)

Když stránku s kurzy uvidíš, rozklikni svůj kurz.
Pokud se ti nevykreslí detail kurzu, nejspíš jsi udělal{{a}} nějakou chybu v definici lekcí nebo materiálů – zkontroluj si, jestli například nemáš dvě lekce se stejným identifikátorem, jestli není překlep v nějakém klíčí a jestli například neodkazuješ na materiál který neexistuje.

Dále si pak můžeš proklikat všechny jednotlivé materiály, jestli vše funguje a vypadá jak má.

Pokud máš lekce naplánované na určité dny, rozklikni si na stránce kurzu
Kalendář a zkontroluj že odpovídá tvé představě.

Jako další test může posloužit druhý režim spuštění, `freeze` místo `serve`, který projde všechny stránky a zkontroluje jestli fungují:

```console
$ poetry run python -m naucse freeze
```


## Upravování a vytváření materiálů

Na závěr této části ještě trochu k materiálům.
Jak bylo zmíněno výše, obsah materiálů je definován ve složce `lessons`.
Kromě toho, že si můžeš sestavit vlastní kurz, můžeš si i upravit materiály, které využíváš, nebo si napsat úplně nové.

Většina materiálů je napsaná v formátu [Markdown](https://cs.wikipedia.org/wiki/Markdown) a pár je napsaných v [Jupyter Noteboocích]({{lesson_url("intro/notebook")}}).
Upravování je jednoduché, stačí se podívat do složky s daným specifickým materiálem a upravit, co je potřeba, v souboru s obsahem.

Vytváření je trošku složitější v tom, že člověk musí vybrat správnou kategorii a vymyslet název lekce a pak vytvořit ve složce kromě obsahu i soubor informacích o materiálech.
Soubor se znovu jmenuje `info.yml` a má povinné tři údaje, `title`, `style` a `license`:

- `title` nastavuje název,
- `style` může být `md` nebo `ipynb` podle toho, jaký formát bude mít text,
- `license` nastavuje licenci, pod kterou materiály píšeš – identifikátor ze složky `licenses`: doporučujeme použít `cc-by-sa-40`.

Dále má soubor nepovinné položky, první `attributions` – buď jednoduchý text, nebo seznam textů s informacemi o tom, kdo a proč materiál napsal.
Nakonec lze použít jinou licenci na ukázky kódu pomocí `license_code`: doporučujeme použít `cc0`.

Obecně je dobrý nápad se při psaní materiálů inspirovat již existujícími řešeními v ostatních materiálech a přebírat jejich styl a způsoby formátování.
Materiály z jedné kategorie byly většinou psány pro jeden typ kurzu a mají specifický styl:
v `beginners` jsou texty pro začátečníky psané kamarádsky, texty pro studenty v `intro` čtenářům vykají (v množném čísle),
úvody z `fast-track` jsou zkratkovité.
