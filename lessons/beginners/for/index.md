## Jak opakovat – a neopakovat *se*

Udělej v editoru nový soubor a ulož ho jako `cykly.py`.
Budeš v něm zkoušet *cykly*.

První opakovací program, který napíšeš, bude dělat tohle:

* Stokrát po sobě:
  * Napiš "Nikdy nebudu odsazovat o tři mezery!"

Přeložené do jazyka Python to vypadá následovně:

```python
for i in range(100):
    print('Nikdy nebudu odsazovat o tři mezery!')
```

Na ono `for i in range(100)` se detailněji podíváme za chvíli,
teď to pro nás bude “hlavička”, která říká “opakuj stokrát”.

Podobnou “hlavičku” už jsi viděl{{a}} u příkazu `if`.
Stejně jako u `if` tu je na konci dvojtečka a za ní následuje
odsazený blok – *tělo* příkazu; to na co se hlavička vztahuje.
Tělo příkazu `if` se provede jen někdy;
tělo příkazu `for` se opakuje několikrát dokola.


### Výčet

Zkus napsat ještě jeden vzorový program, který v češtině zní:

* Pro každý <var>pozdrav</var> z výčtu: „Ahoj“, “Hello”, “Hola”, ”Hei”, "SYN":
  * Vypiš <var>pozdrav</var> a za ním vykřičník.

A v Pythonu:

```python
for pozdrav in ['Ahoj', 'Hello', 'Hola', 'Hei', 'SYN']:
    print(pozdrav + '!')
```

Opět je tu hlavička a tělo příkazu.
Tentokrát se na hlavičku podívej pozorněji.
Pythonní <code>for <var>promenna</var> in <var>sekvence</var></code>
znamená „Pro každé <var>promenna</var> ze <var>sekvence</var>“.

Jméno proměnné si volíš {{gnd('sám', 'sama')}}.
Příkaz `for` danou proměnnou vždy *nastaví* na aktuální
hodnotu a pak provede všechno, co je v odsazeném těle cyklu.
Program výše tedy funguje úplně stejně, jako kdybys napsal{{a}}:

```python
pozdrav = 'Ahoj'
print(pozdrav + '!')

pozdrav = 'Hello'
print(pozdrav + '!')

pozdrav = 'Hola'
print(pozdrav + '!')

pozdrav = 'Hei'
print(pozdrav + '!')

pozdrav = 'SYN'
print(pozdrav + '!')
```


### Range

Vraťme se k `for i in range(100)`.
Už víš, že to znamená „Pro každé <var>i</var> ze sekvence `range(100)`“.
Co je ale to `range`? Když si ho vypíšeš, nevypadne nic vysvětlujícího:

```pycon
>>> range(100)
range(0, 100)
```

Je ale použité jako „sekvence“
v <code>for <var>promenna</var> in <var>sekvence</var></code>.
Je to nějaký výčet, nějaká posloupnost hodnot.
A teď už umíš vypsat, jaké to jsou!

```python
for i in range(5):   # Doporučuju použít jen 5 místo 100
    print(i)
```

neboli česky:

* Pro každé <var>i</var> z `range(5)`:
  * Vypiš <var>i</var>

Program spusť. Jaká čísla se vypíšou? (Neboli: co je v sekvenci `range(5)`?)

{% filter solution %}
Vypíšou se čísla od 0 do 4!
Program funguje steně, jako kdybys napsal{{a}}:

```python
i = 0
print(i)

i = 1
print(i)

i = 2
print(i)

i = 3
print(i)

i = 4
print(i)
```

V sekvenci `range(5)` jsou čísla 0, 1, 2, 3 a 4. Je jich celkem pět.
{% endfilter %}

Funkce `range(n)` vrací *sekvenci čísel*.
Začíná od 0 a čísel v ní je přesně <var>n</var>.
(Na samotné <var>n</var> se tedy už nedostane.)

Často budeš potřebovat Pythonu říct, ať něco „<var>n</var>-krát zopakuje“.
Na to můžeš použít `for i in range(n)` („pro každé <var>i</var> od 0 do
<var>n</var>-1“) s tím, že proměnná <var>i</var> – „počitadlo“ – tě nezajímá.
V programu ji jednoduše nepoužiješ.

Teď by už mělo být jasné, jak funguje původní program:

```python
for i in range(100):
    print('Nikdy nebudu odsazovat o tři mezery!')
```

* Zopakuj 100krát:
  * Vypiš `'Nikdy nebudu odsazovat o tři mezery!'`

Python píše hlášky, jednu za druhou, a u toho si v promněnné <var>i</var>
počítá, jak už je daleko.

> [style-note]
> Proměnná <var>i</var> se v matematice typicky používá pro *celá čísla*;
> je to zkratka z termínu *index* (číslo prvku).
> V programování se tradičně používá pro číslo průchodu cyklem,
> jako v příkladu výše.
> Pro lepší pochopení bývá dobré použít popisnější jméno proměnné, tady
> například `cislo_vypisu`; v krátkých a přehledných cyklech – a zvlášť v těch
> které proměnnou nepoužívají – se ale často setkáš s krátkým `i`, `j`, `k`…
>
> Někteří programátoři pojmenovávají ignorovanou proměnnou `_` (podtržítko).
> To je pro Python jméno jako jakékoli jiné, ničím se neliší od `i` nebo `x`:
>
>```python
>for _ in range(100):
>   print('Nikdy nebudu odsazovat o tři mezery!')
>```