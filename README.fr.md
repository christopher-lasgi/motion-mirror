<p align="center"><img src="assets/banner.png" alt="motion-mirror : cloner un film motion de référence, le prouver par les chiffres, le décliner pour n'importe quelle marque" width="100%"></p>

<p align="center">
  <a href="LICENSE"><img alt="Licence MIT" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <a href="https://github.com/christopher-lasgi/motion-mirror/actions/workflows/check.yml"><img alt="check" src="https://github.com/christopher-lasgi/motion-mirror/actions/workflows/check.yml/badge.svg"></a>
  <a href="https://github.com/christopher-lasgi/motion-mirror/releases"><img alt="release" src="https://img.shields.io/github/v/release/christopher-lasgi/motion-mirror"></a>
</p>

<p align="center"><a href="README.md">English</a> · <b>Français</b></p>

# motion-mirror

Un skill d'agent qui apprend à un agent de code à cloner une vidéo de motion design de référence (durée des plans, chorégraphie, décor, transitions, placement du son), à **prouver** le clone avec des contrôles mesurés, à le verrouiller scène par scène, puis à le transformer en template que n'importe quelle marque peut habiller et décliner en 16:9, 9:16, 1:1, 4:5 et dans d'autres langues.

Sans méthode, un agent invente sa propre chorégraphie, règle les durées à l'œil et vous montre une vidéo qu'il faut discuter. Avec ce skill, il part de planches avec timecodes, mesure l'écart avec la référence en chiffres, et vous remet une preuve côte à côte sur laquelle vous pouvez annoter.

## Démo

<p align="center"><img src="assets/demo-16x9.gif" alt="Extrait du film de lancement d'Orbit, 16:9" width="720"></p>

Réalisé avec ce skill : le film de lancement de 30 secondes d'[Orbit](https://orbit.easyconnector.app), extrait 16:9. L'image et la bande-son sont générées par du code ; aucune image ni musique de tiers n'est utilisée.

▶ **[Voir le film complet avec le son](assets/demo-16x9.mp4)** (16:9, 30 s) · [Storyboard et découpage des plans](showcase/README.fr.md)

<p align="center"><img src="assets/vertical-strip.png" alt="Le même film en 9:16, huit images réparties sur le film" width="100%"></p>

Le même film en 9:16 : recomposé à partir de la même timeline et de la même bande-son, jamais recadré.

## Ce que vous obtenez

- **Un pipeline** de l'ingestion aux déclinaisons : plan de coupes, inventaire par plan, une seule table d'événements partagée par l'image et le son, une scène à la fois, verrouillage, assemblage.
- **Des contrôles mesurés** : timing (T), attaques sonores (S), densité de mouvement (M), décor (D), continuité (C), marque et texte (B), loudness (L), zones de sécurité (A), export (E), mention IA (X). Des chiffres, pas des opinions.
- **Des recettes ffmpeg à copier** : planches avec timecodes, vidéos côte à côte RÉF et NOUS, paires de décor éclaircies au gamma, densité de mouvement, attaques audio, spectrogrammes, remux sans re-rendu.
- **Un modèle de template** : la chorégraphie reste fixe, l'identité (logo, couleurs, polices, textes par langue) est de la donnée, donc une deuxième marque se rend sans toucher à la chorégraphie.
- **Une boucle d'auto-correction** : chaque erreur devient une ligne du journal et une règle durcie, pour ne jamais vous répéter.
- **Des évals** pour vérifier le skill sur votre modèle et votre matière ([`evals/`](evals/README.md)).

## Installation

Le skill est du Markdown simple ([`skills/motion-mirror`](skills/motion-mirror)) : tout agent de code compatible avec le format [Agent Skills](https://agentskills.io/specification) peut l'utiliser.

```bash
npx skills add christopher-lasgi/motion-mirror
```

Cela utilise l'installeur ouvert [`skills`](https://github.com/vercel-labs/skills), qui copie le skill dans le dossier de chaque agent détecté. Ou copiez-le vous-même :

```bash
git clone https://github.com/christopher-lasgi/motion-mirror
cp -r motion-mirror/skills/motion-mirror ~/.claude/skills/            # Claude Code, tous les projets
cp -r motion-mirror/skills/motion-mirror <votre-repo>/.claude/skills/ # Claude Code, un seul projet
```

Les autres agents lisent leurs skills dans leur propre dossier (plusieurs lisent aussi `.agents/skills/`) : consultez la documentation de votre agent, ou référencez `skills/motion-mirror/SKILL.md` dans son fichier d'instructions (par exemple `AGENTS.md`).

Prérequis : ffmpeg 6 ou plus (avec `drawtext`), Node 20 ou plus, et un moteur de rendu déterministe comme [Remotion](https://www.remotion.dev) 4.

## Utilisation

Demandez à votre agent en langage courant. Par exemple :

- *« Utilise motion-mirror. La référence est `~/refs/teaser.mov` (garde-la hors du repo). Fais le plan de coupes, puis clone uniquement la scène 1 et montre-moi la preuve côte à côte. »*
- *« Seul le son a changé : remixe la bande-son et reconstruis le paquet de preuves, sans rendre une seule image. »*
- *« Décline le film 16:9 terminé en 9:16, recomposé, et montre-moi une planche contact avant de livrer. »*
- *« Habille le film verrouillé pour cette marque avec ces couleurs, ce logo et ces textes. Aucun changement de chorégraphie. »*
- *« Audite notre film par rapport à la référence avec les contrôles et liste les écarts. »*

Une session type : l'agent demande une fois la référence et les données de marque, cartographie les plans, clone une scène, montre la preuve, attend votre validation, verrouille la scène, puis passe à la suivante.

## Cas d'usage

- **Film de lancement ou teaser** pour un produit, cloné d'une référence dont vous admirez le rythme, dans votre propre identité.
- **Un film, plusieurs marques** : une agence habille un template verrouillé pour chaque client avec de la donnée d'identité uniquement.
- **Déclinaisons verticales et localisées** : 9:16, 1:1, 4:5 et autres langues, recomposées depuis le master sans dériver de son timing ni de son son.
- **Contrôle qualité** d'un film existant face à sa référence, avec un tableau d'écarts plutôt qu'une impression.

## Obtenir les meilleurs résultats

- Utilisez le modèle le plus puissant dont vous disposez, avec un raisonnement étendu pour le plan de coupes, l'analyse sonore et le tableau d'écarts. Le skill supprime les explications répétées et rend les résultats vérifiables ; il ne remplace pas un modèle capable, et un modèle faible donnera toujours des résultats faibles.
- Jugez sur les planches et les chiffres produits par l'agent, pas sur son propre rapport.
- Vérifiez le skill sur votre matière : lancez les cinq scénarios de [`evals/`](evals/README.md) avec et sans lui, sur votre modèle. Nous ne pouvons pas promettre le même gain sur tous les modèles, c'est pourquoi cette vérification fait partie du dépôt.

## Usage responsable

- motion-mirror est une méthode : elle apprend à un agent à étudier le timing, la structure et le placement du son d'une référence. Elle ne livre pas, et vous ne devez pas redistribuer, les images, la musique, les polices, les logos, les textes ou les autres éléments d'une référence.
- Vous êtes responsable de détenir les droits sur chaque référence, musique, voix et élément que vous utilisez, et de ce que vous publiez. Le droit d'auteur protège l'expression ; les idées, méthodes et structures sont en général traitées différemment, mais la frontière dépend du pays et des faits. Ce n'est pas un avis juridique : consultez un avocat avant de publier une adaptation proche de l'œuvre d'autrui.
- Gardez privées les comparaisons côte à côte avec une référence. Publiez votre propre version avec votre propre bande-son.
- Les noms de marques et marques déposées appartiennent à leurs propriétaires. Ce projet n'est ni affilié à eux ni approuvé par eux, y compris les outils d'agents cités.
- Mentionnez l'usage de l'IA honnêtement, selon les règles de chaque plateforme.
- Fourni tel quel sous licence MIT, sans garantie.

## Contribuer

Les améliorations sont les bienvenues : voir [CONTRIBUTING.md](CONTRIBUTING.md) (en anglais). Le skill reste neutre vis-à-vis des marques et sans média de tiers ; `scripts/check.sh` le vérifie.

## Licence

[MIT](LICENSE), © 2026 Christopher Lasgi.
