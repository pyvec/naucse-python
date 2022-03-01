# Přidání kurzu na Nauč se Python

Když už máme nadefinováný vlastní kurz, zbývá nám jen ho dostat na [naucse.python.cz](https://naucse.python.cz/).
Budeme k tomu potřebovat pár příkazů v Gitu a trochu trpělivosti.

## Definice GitHub Actions

Způsob, jakým se obsah kurz dostane na naucse.python.cz je následující:

- V rámci tvého repozitáře se zdrojový text (Markdown) a informace (YAML)
  převedou na HTML a JSON, uložené ve zvláštní větvi, `compiled`.
- naucse.python.cz potom vezme informace ze všech kurzů, spojí je dohromady
  a publikuje na web.

První krok je nadefinovaný v souboru `.github/workflows/main.yml` v tvém
repozitáři.
Jestli tenhle soubor nemáš, zkopíruj si ho
[z repozitáře pyvec/naucse-python](https://github.com/pyvec/naucse-python/blob/main/.github/workflows/main.yml).


## Nahrání do vlastního forku

První věc, kterou budeš potřebovat, je vlastní účet na [GitHubu](https://github.com/).

Přihlaš se na GitHub a vytvoř „fork” kurzu ze kterého vycházíš,
např. [repozitáře pyvec/naucse-python](https://github.com/pyvec/naucse-python).
Na stránce repozitáře vpravo nahoře na to je tlačítko _Fork_.

<div style="text-align: center">
{{ figure(
    img=static('naucse_fork.png'),
    alt="Tlačítko na vytvoření forku repozitáře",
) }}
</div>

Jsi-li na GitHubu v nějaké organizaci (např. PyLadiesCZ), můžeš vybrat,
jestli *fork* bude pod tvým účtem nebo pod organizací.
Děláš-li kurz pro organizaci, použij tu,
abyste do materiálů mohli přispívat všichni.
Jinak udělej kurz pod vlastním účtem.

Vytvoření chvilku trvá.
To, že je fork vytvořen, poznáš tak, že tě GitHub přesměruje na stránku, která bude skoro stejná, ale v hlavičce bude jiné uživatelské jméno (tvoje nebo tvé
organizace) a pod tím text <code>forked from <var>původní_repozitář</var></code>.

Tvůj fork si teď potřebuješ přidat do lokálního repozitáře jako *referenci*, abys tam pak mohl{{a}} poslat svůj kurz.
To uděláš pomocí příkazu (nahraď obě `uzivatelskejmeno` za uživatelské jméno
pod kterým fork je, a `nazevrepa` za název repozitáře):

```console
$ git remote add uzivatelskejmeno https://github.com/uzivatelskejmeno/nazevrepa
```

Dále potřebuješ vytvořit commit se svým kurzem a případně se změnami v materiálech.
Je dobré změny dělat v zvláštní větvi, ne v `main`/`master`.
Vymysli si název větve (např. `pridani-kurzu`) a pusť příkazy

```console
$ git branch nazevvetve
$ git checkout nazevvetve
```

Jak vytvořit commit, se dozvíš například v [návodu na používání Gitu]({{lesson_url("git/git-collaboration-2in1")}}).
Více o větvích se můžeš dozvědět v [návodu na větvení v Gitu]({{lesson_url("git/branching")}}).

## Pull request

Svůj commit teď potřebuješ dostat do svého forku na GitHubu.
To uděláš příkazem (`uzivatelskejmeno` nahraď za uživatelské jméno, pod kterým fork
je, `nazevvetve` za název větve):

```console
$ git push uzivatelskejmeno nazevvetve
```

Mezi informacemi které tento příkaz vypíše by měla být adresa na vytvoření
*pull requestu*. Tu navštiv, vyber na ní *compare across forks* a pod
*base repository* vyber repozitář se svým kurzem.
Pak pomocí zelených tlačítek vytvoř *pull request*.

Protože máš nastavené GitHub Actions (souborem `.github/workflows/main.yml`,
viz výše), měly by se u vytvořeného *pull requestu* spustit “testy”:
kurz se nanečisto převede na HTML.
Až proces doběhne, uvidíš zelené tlačítko *merge* kterým můžeš změny začlenit.
Tím se spustí další GitHub Action, který vytvoří větev `compiled` s obsahem pro
naucse.python.cz.


## Informace o tvém repozitáři

Teď potřebuješ ještě přidat kurz na naucse.python.cz.
To se dělá změnou souboru [courses.yml](https://github.com/pyvec/naucse.python.cz/blob/master/courses.yml),
nejlépe přímo na GitHubu pomocí tlačítka s ikonkou tužky.

Na konec souboru přidej záznam:

```yaml
rok/identifikator:
  url: https://github.com/uzivatelskejmeno/nazevrepa
  path: idkurzu
  branch: compiled
```

kde doplň:

* `rok` kdy se kurz koná. U kurzu který zasahuje do více kalendářních roků
  jeden vyber (např. rok většiny kurzu nsbo rok kdy kurz začíná.
  U časově  neomezených kurzů pro samouky rok i lomítko za ním vynech.
* `identifikator` je označení kurzu v rámci naucse, které se použije v URL.
  Musí být v daném roce unikátní. Použij v něm jen malá písmenka bez diakritiky
  a pomlčku.
* `idkurzu` je identifikátor kurzu, tedy jméno souboru `courses/*.yml`
  ve tvém repozitáři. Používáš-li `course.yml`, celý řádek `path` vynech.

Změnu pošli jako pull request (vyplň k ní ve formuláři na GitHubu komentář a
poklikej na zelená tlačítka). Neboj se že něco uděláš špatně, pull request musí
někdo schválit a v rámci toho může všechno zkontrolovat a upravit.

Po tom, co správci PR schválí a začlení tvoje změny do základního repozitáře, stačí počkat pár minut a tvůj kurz se objeví na [naucse.python.cz](https://naucse.python.cz/).

## Upravování kurzu

Pokud budeš chtít na svém kurzu něco změnit, musíš s každou změnou udělat commit a odeslat commit na GitHub.

Nastavené GitHub Actions pro každou změnu sestaví a publikují novou
verzi stránek.
