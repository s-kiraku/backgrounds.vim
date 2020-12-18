# backgrounds.vim

数多あるカラースキーム切り替えプラグインの再発明にして自分専用のものが欲しく
なったので作った。端末のプロファイルを明るいものと暗いものを気分で使い分けてい
るとカラースキーム切り替えがストレスフルだったので。なおビルトイン乱数およびオ
プショナル引数を使っているため Vim 8.1以上でしか動かない。

## 提供コマンド

- ShiftColorScheme

  引数の整数分だけカラースキームのリストをシフトする。引数を
  与えない場合はシフト先はランダムになる。選択されるカラースキームのリストは
  現在の背景色('background')に合わせてフィルタリングされる。例えば ``bg=dark``
  の時はリストにpeachpuff は現れない。逆に ``bg=light`` だと default が選ばれる
  ことはない。

  この対応は人力で設定しているので、カラースキームを追加したときは、
  autoload/backgrounds.vim の辞書 `s:t` を更新すること。さもないと辞書に存在し
  ないカラースキームは常に dark と light 両方に対応しているものとみなされるため、
  うげっとなる切り替えが発生することになる。

- ShiftColorSchemeForce

  ShiftColorScheme とほぼ同じだが、背景色を考慮せずに全
  てのカラースキームから切り替え先を選択する。

- ChangeBG

  背景色の light -- dark を ``syntax reset`` した上で切り替える。もし
  切り替えたバックグラウンドに現在のカラースキームに対応できない場合は、dark は
  `default`、light は `g:default_light_colors_name` (初期値は peachpuff)に切
  り替わる。対応可能か否かの判別は autoload/backgrounds.vim の辞書 `s:t` による。
  地味にこれが欲しかった機能。

## キーマッピング例

こんな感じ。F6で一つ前のカラースキーム、F8で次のカラースキーム、そしてF7でラン
ダムなカラースキーム。

```vim
    nnoremap <silent> <F5> :ChangeBG<CR>
    nnoremap <silent> <F6> :ShiftColorScheme -1<CR>
    nnoremap <silent> <F7> :ShiftColorScheme<CR>
    nnoremap <silent> <F8> :ShiftColorScheme 1<CR>
```
