# Zápis řetězců

Teď se podíváme na zoubek řetězcům.
Už s nimi trochu umíš, tak začneme rekapitulací.

Textový *řetězec* (angl. *string*) je datový typ (druh *hodnot*),
který obsahuje text – třeba slovo nebo větu.

Když řetězec zadáváš do programu, musíš ho označit – uzavřít do
*uvozovek*, buď jednoduchých nebo dvojitých:

```python
'tohle je řetězec'
"tohle taky"
```

Je velký rozdíl mezi `print('cislo')` – vypiš slovo „cislo“ –
a `print(cislo)` – vypiš hodnotu výrazu `cislo`.
Jednou je `cislo` pět konkrétních písmen; podruhé *instrukce* k použití
proměnné.
Počítač, na rozdíl od lidí, rozdíl mezi textem a instrukcí nepozná z kontextu,
a tak je uvozovky potřeba používat důsledně.

{{ figure(
    img=static('quote-comic.svg'),
    alt='(Ilustrační komiks. Člověk říká robotovi: "Řekni Pavlovi, ať mi zavolá!". Robot odpoví: "PAVLOVI AŤ MI ZAVOLÁ!")',
) }}


## Znaky

Texty sestávají z jednotlivých písmenek.
Řetězce víceméně taky, ale aby bylo jasné, co přesně tím *písmenkem*
myslíme, říkáme, že řetězce sestávají ze *znaků* (angl. *characters*).

Takový znak může být písmenko (např. `A`) nebo číslice (`3`),
ale i jiný symbol (`!`).

Každý řetězec má určitý počet znaků.
Kolik, to zjistíš pomocí funkce `len()`.
Třeba řetězec `Ahoj!` má znaků pět:

```pycon
>>> len('Ahoj!')
5
```

Jeden ze zajímavějších znaků je *mezera*.
Je to taky znak. V řetězci se tedy chová stejně jako písmenko:

```pycon
>>> len(' ')
1
>>> len('K ní')
4
>>> len('3 + 2')
5
```

Sekvence `\\` znamená „jedno zpětné lomítko“.

```python
print('C:\\PyLadies\\Nový adresář')
```

Podobně jako `\"` je zápis pro uvozovku a `\'` pro apostrof, sekvence `\\`
je zápis pro jedno zpětné lomítko.


### Nový řádek

Někdy potřebuješ řetězce, které obsahují více řádků.
Pythonní řetězce ale můžeš normálně napsat jen na *jeden* řádek.
(Python se tak snaží ulehčit hledání chyby, kdybys koncovou uvozovku
zapoměl{{a}}.)

Můžeš ale do řetězce znak pro nový řádek vložit pomocí sekvence `\n`:

```pycon
>>> print('Haló haló!\nCo se stalo?')
Haló haló!
Co se stalo?
```

Ono `\n` do řetězce vloží znak nového řádku.
Ten při výpisu ukončí stávající řádek a přejde na nový – ale jinak se chová
jako jakýkoli jiný znak:

```pycon
>>> print('-\n-')
-
-
>>> len('-\n-')
3
```


## Trojité uvozovky

Kromě `\n` je i druhý způsob, jak zadat řetězec se znakem nového řádku:
ohraničit ho *třemi* uvozovkami (jednoduchými nebo dvojitými)
na každé straně.
Dají se tak zadávat delší víceřádkové řetězce:

```python
basen = '''Haló haló!
Co se stalo?
Prase kozu potrkalo!'''
```

Pozor na to, že pokud je tenhle řetězec
v odsazeném kódu, každý jeho řádek bude začínat
několika mezerami.
(V dokumentačních řetězcích tohle nevadí, tam se s odsazením počítá.)

```python
cislo = 4

if cislo > 0:
    print("""
        Výsledek porovnání:

        Číslo je kladné.
    """)
```


## Cvičení

Zkus napsat program, který vymění znak na dané pozici řetězce za jiný.
Od uživatele vyžádá řetězec, pozici, na které se má provést výměna
a znak, který se má na pozici zadat. Pozor na to, že řetězce v Pythonu nelze měnit.
Musíš vytvořit nový řetězec poskládaný z částí toho starého.

{% filter solution %}
```python
retezec = input('Zadej původní řetězec: ')
pozice = int(input('Na jaké pozici provedeme výměnu? '))
znak = input('Jaký znak tam dáme? ')

print('Po výměně to vypadá takto:')
print(retezec[:pozice] + znak + retezec[pozice + 1:])
```
{% endfilter %}
