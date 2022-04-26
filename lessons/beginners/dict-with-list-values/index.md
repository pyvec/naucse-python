# Více hodnot v jednom záznamu slovníku

Ke každému klíči může patřit jen jedna hodnota.
Jak bys zařídil{{a}}, aby hodnot bylo víc?

Řekněme, že bys chtěl{{a}} do slovníku uložit tyto telefonní kontakty:

* Katka:
    * 4925219
* Jirka:
    * 7477058
    * 3251156
* Verča:
    * 1019103

Jak na to?
Jednoduchý slovník použít nemůžeš. Pozor na následující zápis!

```python
kontakty = {
    'Katka': '4925219',
    'Jirka': '7477058',
    'Jirka': '3251156',
    'Verča': '1019103',
}
```

Python v tomto případě jednotlivé záznamy uloží postupně, jako kdybys napsal{{a}}:

```python
kontakty = {}
kontakty['Katka'] = '4925219'
kontakty['Jirka'] = '7477058'
kontakty['Jirka'] = '3251156'
kontakty['Verča'] = '1019103'
```

A ve výsledku bude mít `'Jirka'` uložené jen jedno číslo.
Python tohle nenahlásí jako chybu, ačkoli to často není to, co chceš.

Protože ve slovníku může být každému klíči přiřazena jen jedna hodnota,
bude potřeba více hodnot směstnat do jedné.
Každému kontaktu můžeš přiřadit *seznam* čísel:

```python
kontakty = {
    'Katka': ['4925219'],
    'Jirka': ['7477058', '3251156'],
    'Verča': ['1019103'],
}
```

Výraz jako `kontakty['Katka']` pak označuje seznam.
Pokud se Katka přestěhuje do zahraničí a pořídí si nové číslo,
můžeš napsat:

```python
kontakty['Katka'].append('+897 3788509')
print(len(kontakty['Katka']))
print(kontakty['Katka'][-1])
del kontakty['Katka'][0]
print(kontakty['Katka'])
```
