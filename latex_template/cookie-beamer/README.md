# Cookie Beamer

**Cookie** is a standalone, LuaLaTeX-first Beamer theme. It keeps the
asymmetric, numbered visual language of `awesome-beamer`, while adopting the
low-noise configuration habits people like in Metropolis: optional progress
bars, section pages, compact blocks, predictable options, and useful defaults
for technical slides.

![Cookie demo preview](cookie-demo-preview.png)

## Quick start

Cookie is a single `.sty` file. Download it beside your presentation:

```sh
curl -LO https://raw.githubusercontent.com/SeniorMars/dotfiles/main/latex_template/cookie-beamer/beamerthemecookie.sty
```

If this repository is already cloned locally, copying the file works too:

```sh
cp /path/to/dotfiles/latex_template/cookie-beamer/beamerthemecookie.sty .
```

Then write your deck:

```tex
\documentclass[aspectratio=169]{beamer}

\definecolor{myaccent}{HTML}{356AE6}
\usetheme[
  accent=myaccent,
  progressbar=foot,
  sectionpage=progressbar,
  subsectionpage=progressbar,
  numbering=fraction,
  block=fill
]{cookie}

\title{My talk}
\author{My name}
\date{\today}

\begin{document}
\maketitle

\section{First section}
\subsection{First idea}
\begin{frame}{A frame title}{A subtitle that clears the divider}
  Hello, cookie.
\end{frame}
\end{document}
```

Build with:

```sh
latexmk -lualatex my-talk.tex
```

## Theme options

| Option | Values | Default |
|---|---|---|
| `accent` | any defined `xcolor` color | `cookieAccentDefault` |
| `progressbar` | `none`, `head`, `frametitle`, `foot` | `foot` |
| `sectionpage` | `none`, `simple`, `progressbar` | `progressbar` |
| `subsectionpage` | `none`, `simple`, `progressbar` | `none` |
| `numbering` | `none`, `counter`, `fraction` | `fraction` |
| `numberrail` | `none`, `section`, `subsection` | `subsection` |
| `numberrailcolor` | `muted`, `accent` | `muted` |
| `block` | `transparent`, `fill` | `fill` |
| `background` | `light`, `dark` | `light` |
| `titleformat` | `regular`, `smallcaps`, `allcaps` | `regular` |
| `fonts` | `auto`, `none` | `auto` |
| `mathfonts` | `libertinus`, `none` | `libertinus` |
| `toc` | `none`, `aftertitle` | `none` |
| `closing` | `none`, `contact` | `none` |
| `covered` | `invisible`, `transparent` | `invisible` |
| `notes` | `hide`, `show`, `second`, `only` | `hide` |

`coloraccent=<color>` is accepted as an alias for `accent=<color>`.

The structural number rail is muted by default so values such as `1.1` support
the title instead of competing with it. Use `numberrailcolor=accent` to restore
the brighter legacy treatment.

The progress subsection page reports the current subsection and the number of
subsections in its section. Run LuaLaTeX twice after changing the section
structure; `latexmk` handles this automatically.

## LuaLaTeX and fonts

With `fonts=auto`, Cookie selects installed Noto fonts when available:

1. Noto Sans for main text and sans text.
2. Noto Sans Mono for code and monospaced text.
3. TeX Gyre Heros / DejaVu Sans Mono as fallbacks.

With `mathfonts=libertinus`, Cookie loads `unicode-math` and uses Libertinus
Math when available. Text remains in Noto; the Libertinus setup is math-only.
Use `mathfonts=none` before loading a custom math package yourself.

No fonts are bundled. To use your own setup, choose `fonts=none` and load
`fontspec` yourself:

```tex
\usetheme[fonts=none]{cookie}
\usepackage{fontspec}
\setmainfont{Your Text Font}
\setsansfont{Your Sans Font}
\setmonofont{Your Mono Font}
```

## Metadata, title images, and the closing QR

All extended title-page fields are optional and safe when empty:

```tex
\cookieemail{you@example.edu}
\cookieuni{Your University}
\cookielocation{Your City}
\cookietagline{A short kicker above the title}
\cookietitleimage{assets/title-image.jpg}
```

`\cookietitleimage` clips an image into the colored title-page wedge. Standard
Beamer `\titlegraphic{...}` also works.

The closing slide can include contact details, the Cookie penguin, and an
optional clickable QR code:

```tex
\cookieclosingtitle{Thank you}
\cookieclosingtext{Questions?}
\cookieclosingqr{https://example.org/my-slides}
\cookieclosingqrlabel{Slides and source}
\makeclosing
```

Add `closing=contact` to insert the closing slide automatically. Cookie uses
`qrcode` when it is installed and falls back to a clickable URL otherwise.

## Background images on ordinary frames

Use frame keys for a local, full-canvas background:

```tex
\begin{frame}[
  bgimage=assets/photo.jpg,
  bgfit=cover,
  bgoverlay=cookieInk,
  bgoverlayopacity=.56
]{A readable photo slide}
  Content goes here.
\end{frame}
```

Available frame keys:

| Key | Values / meaning |
|---|---|
| `bgimage` | image filename |
| `bgfit` | `cover`, `contain`, or `stretch` |
| `bgopacity` | image opacity from `0` to `1` |
| `bgoverlay` | any defined color |
| `bgoverlayopacity` | wash opacity from `0` to `1` |

The frame keys only draw the image and wash. For a dark photo slide, set local
text colors yourself:

```tex
{
\setbeamercolor{normal text}{fg=white,bg=}
\setbeamercolor{frametitle}{fg=white,bg=}
\begin{frame}[bgimage=assets/photo.jpg,bgoverlay=cookieInk,bgoverlayopacity=.56]{Title}
  \color{white}
  Content goes here.
\end{frame}
}
```

The settings reset after the frame. A global image is also available:

```tex
\cookiebackgroundimage{assets/photo.jpg}
% subsequent frames
\cookieclearbackgroundimage
```

## Components

Cookie uses ordinary Beamer components and adds a few small helpers:

```tex
\cookiekicker{Small uppercase label}
\cookiebadge{compact badge}
\cookieseparator
\cookiecheck
\cookiecross
\cookiepenguin[scale=.55]
```

A light card works well in columns:

```tex
\begin{cookiecard}[title=Result]
  Compact supporting content.
\end{cookiecard}
```

A themed `listings` code card requires no shell escape:

```tex
\begin{frame}[fragile]{Code}
  \begin{cookiecode}[title=Example]{C}
int square(int x) {
  return x * x;
}
  \end{cookiecode}
\end{frame}
```

For ordinary `lstlisting`, select the supplied style:

```tex
\lstset{style=cookie}
```

Algorithms use `algorithm2e` with Cookie's line numbers, keywords, captions,
and comments:

```tex
\begin{frame}{Algorithm}
  \begin{algorithm}[H]
    \caption{Projected gradient descent}
    \KwIn{Objective $f$, feasible set $C$, initial point $x_0$}
    \KwOut{Approximate minimizer $x_t$}
    \For{$t = 0,1,\ldots,T-1$}{
      $g_t \leftarrow \nabla f(x_t)$\tcp*{gradient}
      $x_{t+1} \leftarrow \Pi_C(x_t-\eta_t g_t)$\;
    }
    \Return $x_T$\;
  \end{algorithm}
\end{frame}
```

Cookie loads `algorithm2e` with `ruled`, `vlined`, and `linesnumbered` when it
is available. Load `algorithm2e` before the theme if a deck needs different
package options.

A quote card is intended for short transitions or a single load-bearing idea:

```tex
\begin{cookiequote}[Donald Knuth]
  Science is what we understand well enough to explain to a computer.
\end{cookiequote}
```

The `wide` environment gives diagrams and tables extra horizontal room:

```tex
\begin{wide}
  % wide content
\end{wide}
```

Three-column slides use standard Beamer layout and inherit Cookie's spacing:

```tex
\begin{columns}[T,onlytextwidth]
  \column{.29\textwidth} ...
  \column{.36\textwidth} ...
  \column{.29\textwidth} ...
\end{columns}
```

## Agenda, overlays, and animations

A reusable agenda frame is available independently of `toc=aftertitle`:

```tex
\makeagenda
\makeagenda[currentsection]
```

A Metropolis-style emphasis frame is available:

```tex
\begin{frame}[standout,noframenumbering]
  One idea per slide.
\end{frame}
```

Useful TikZ styles are included:

```tex
cookie node
cookie accent node
cookie arrow
visible on=<2->
muted on=<3>
```

Cookie includes a foreground modal compatible with old awesome-beamer slides:

```tex
\begin{modal}<3>[Key detail]
  This card appears on overlay 3.
\end{modal}
```

The explicit name `cookiemodal` is equivalent. Standard Beamer commands such as
`\pause`, `\only`, `\uncover`, `\onslide`, `onlyenv`, and item overlays work
unchanged. Two compact helpers are available:

```tex
\cookiereveal<2->{content}  % like \uncover, preserving space
\cookiefocus<3>{content}    % muted except on overlay 3
```

Choose `covered=transparent` to make ordinary covered material faintly visible.
The full demo includes an animated, three-layer system diagram whose geometry
stays fixed while the visual focus changes.

## Speaker notes

Cookie uses native Beamer `\note{...}` commands and adds a styled note page.
Choose the output mode in the theme options:

```tex
\usetheme[notes=second]{cookie} % slide on the left, notes on the right
```

```tex
\begin{frame}{Main claim}
  The audience sees this.

  \note{
    \begin{itemize}
      \item Open with the motivating question.
      \item Spend 45 seconds here.
      \item Transition to the implementation diagram.
    \end{itemize}
  }
\end{frame}
```

`notes=show` emits note pages after slides, `notes=only` emits only note pages,
and `notes=hide` creates the ordinary audience deck.

## Citations and bibliography

Cookie does not replace the standard bibliography stack. The demo uses
BibLaTeX and Biber:

```tex
\usepackage[backend=biber,style=authoryear]{biblatex}
\addbibresource{refs.bib}

% later
A cited claim \parencite{my-source}.

\begin{frame}[allowframebreaks]{References}
  \printbibliography[heading=none]
\end{frame}
```

The theme styles bibliography colors and markers while leaving citation style
and data ownership to BibLaTeX.

## Blocks and old decks

Cookie uses standard Beamer block syntax:

```tex
\begin{block}{Standard Beamer title}
  ...
\end{block}
```

When porting an awesome-beamer deck, replace `\begin{block}[Title]` with
`\begin{block}{Title}`. The same standard syntax applies to `alertblock` and
`exampleblock`. Beamer theorem environments such as `definition`, `theorem`,
and `proof` use related but distinct palettes. Proofs end with Cookie's accent
smiley QED when `tikzsymbols` is available.

## Moving from awesome-beamer

1. Download or copy `beamerthemecookie.sty` into the project.
2. Remove the `awesome-beamer` and `smile` input-path/submodule setup.
3. Replace the theme line.

```tex
% Before
\usetheme[english,coloraccent=forest,secslide,subsecslide]{awesome}

% After
\usetheme[
  accent=forest,
  sectionpage=progressbar,
  subsectionpage=progressbar
]{cookie}
```

Compatibility aliases are retained for `english`, `german`, `color`, `notoc`,
`secslide`, `subsecslide`, and `nonumbersinframetitle`. Cookie does not recreate
every general-purpose macro from `smile.sty`; load specialized packages and
TikZ libraries explicitly when a deck uses them.

## Files

- `beamerthemecookie.sty` - the theme.
- `demo.tex` / `demo.pdf` - blocks, theorem/proof, math, code, overlays,
  system diagrams, quotes, notes source, citations, QR closing, three-column
  composition, and image backgrounds.
- `refs.bib` - bibliography data used by the demo.
- `assets/cookie-background.png` - demo image; replace it with your own.
- `.latexmkrc` - local builds with LuaLaTeX and Biber.
- `.github/workflows/build.yml` - CI build for the demo.

## License and credit

Cookie is released under the BSD 3-Clause License. Its visual direction and
migration interface are based in part on Lukas Pietzschmann's
`awesome-beamer`, also BSD-3-Clause. Metropolis inspired the option surface and
progress-bar approach. See `LICENSE` for notices.
