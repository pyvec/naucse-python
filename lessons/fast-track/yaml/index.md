
# O formátu YAML

Formát se skládá z několika stavebních bloků, které se dají poté skládat dohromady.
Prvním je seznam hodnot (podobně jako v Pythonu).
Seznam se ve formátu YAML zapisuje následovně:

```yaml
- První položka
- Druhá položka
- 3
- Položka může být i něco jiného než text!
```

Druhým stavebním blokem je slovník (zase podobně jako v Pythonu), který se skládá z klíčů a hodnot, nezáleží v ní tedy na pořadí, protože se k informaci vždy člověk dostance pomocí klíče.
Slovník se ve formátu YAML zapisuje následovně:

```yaml
klic1: Hodnota klíče klic1.
klic2: 2
klic3: I hodnoty ve slovníku mohou být něco jiného než text.
klic4: |
    Pokud potřebuješ zapsat nějaký delší text, uděláš to takhle.

    Tento text budou dva separátní odstavce v rámci jednoho klíče.
klic5:
klic6: Jak vidíš v klíči klic5, hodnota může být i prázdá.
```

Seznamy a slovníky jde samozřejmě i skládat dohromady:

```yaml
klic1: Hodnota klíče
klic2:
- Tohle je seznam, které patří pod klíč klic2
- vnorenyklic: Můžeme skládat jednotlivé typy skoro do nekonečna.
- vnorenyklic: Klíče musí být unikátní jen v rámci jednoho slovníku, takže to může být takto.
klic3:
  vnorenyklic: Slovník může obsahovat další slovník i takto.
```
