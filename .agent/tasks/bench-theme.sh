#!/usr/bin/env bash
# hugo-theme-vivliocli: テーマ2版のビルド時間を比較する
#
# 使い方:
#   ./bench-theme.sh <サイトのディレクトリ> [実行回数] [比較元ref] [比較先ref]
# 例:
#   ./bench-theme.sh ~/mydocs 3
#
# 既定では「今回の変更の前(c958e55)」と「変更後(main)」を比べる。
#
# この計測で必ず守っていること:
#   1. テーマの切り替えは --themesDir フラグではなく hugo.toml の themesdir を書き換える
#      (--themesDir は設定ファイルの themesdir を上書きしないため)
#   2. 出力に識別子を埋め、どちらのテーマが実際に使われたかを毎回確認する
#   3. 同じ条件を複数回走らせる (単発の測定は外れることがある)
#   4. 両者の出力がバイト単位で一致することを確認する

set -u

SITE=${1:?サイトのディレクトリを指定してください}
RUNS=${2:-3}
REF_BEFORE=${3:-c958e55}
REF_AFTER=${4:-main}

THEME_REPO=https://github.com/mochimochiki/hugo-theme-vivliocli.git
WORK=$(mktemp -d)
HUGO=${HUGO:-hugo}

if [ ! -d "$SITE" ]; then echo "サイトが見つかりません: $SITE" >&2; exit 1; fi
SITE=$(cd "$SITE" && pwd)
if [ ! -f "$SITE/hugo.toml" ] && [ ! -f "$SITE/config.toml" ]; then
  echo "$SITE に hugo.toml / config.toml が見つかりません" >&2; exit 1
fi
CFG=hugo.toml; [ -f "$SITE/hugo.toml" ] || CFG=config.toml

echo "作業ディレクトリ: $WORK"
echo "Hugo: $($HUGO version)"
echo

# --- テーマを2版そろえる -------------------------------------------------
git clone -q "$THEME_REPO" "$WORK/theme-src" || { echo "clone に失敗しました" >&2; exit 1; }
for pair in "before:$REF_BEFORE" "after:$REF_AFTER"; do
  name=${pair%%:*}; ref=${pair#*:}
  mkdir -p "$WORK/T-$name"
  git -C "$WORK/theme-src" worktree add -q --detach "$WORK/T-$name/hugo-theme-vivliocli" "$ref" \
    || { echo "ref '$ref' を取り出せませんでした" >&2; exit 1; }
  # どのテーマが使われたか確認するための識別子
  printf '<span id="BENCHMARK-THEME">%s</span>\n' "$name" \
    >> "$WORK/T-$name/hugo-theme-vivliocli/layouts/partials/menu-footer-custom.html"
  echo "$name = $(git -C "$WORK/theme-src" rev-parse --short "$ref")"
done
echo

# --- サイトを2つ用意し、themesdir を差し替える ---------------------------
for name in before after; do
  cp -r "$SITE" "$WORK/S-$name"
  rm -rf "$WORK/S-$name/public" "$WORK/S-$name/resources"
  cfg="$WORK/S-$name/$CFG"
  if grep -q '^[[:space:]]*themesdir[[:space:]]*=' "$cfg"; then
    sed -i.bak "s|^[[:space:]]*themesdir[[:space:]]*=.*|themesdir = \"$WORK/T-$name\"|" "$cfg"
  else
    printf '\nthemesdir = "%s"\n' "$WORK/T-$name" >> "$cfg"
  fi
  grep -q '^[[:space:]]*theme[[:space:]]*=' "$cfg" || printf 'theme = "hugo-theme-vivliocli"\n' >> "$cfg"
done

# --- どちらのテーマが実際に使われたか確認 --------------------------------
echo "テーマ解決の確認:"
ok=1
for name in before after; do
  ( cd "$WORK/S-$name" && $HUGO --quiet --destination "$WORK/V-$name" >/dev/null 2>&1 )
  got=$(grep -rho 'id="BENCHMARK-THEME">[a-z]*' "$WORK/V-$name" 2>/dev/null | head -1 | cut -d'>' -f2)
  echo "  指定=$name -> 実際=${got:-(識別子が出力に見つかりません)}"
  [ "$got" = "$name" ] || ok=0
done
if [ "$ok" != 1 ]; then
  echo
  echo "テーマの切り替えが効いていません。この状態の計測値は信用できないので中止します。" >&2
  echo "サイトの $CFG に themesdir / theme の指定が別途ある可能性があります。" >&2
  exit 1
fi
echo

# --- 識別子を外して本計測 -------------------------------------------------
for name in before after; do
  f="$WORK/T-$name/hugo-theme-vivliocli/layouts/partials/menu-footer-custom.html"
  grep -v 'BENCHMARK-THEME' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
done

echo "ビルド時間 (各 $RUNS 回):"
for name in before after; do
  printf '  %-6s :' "$name"
  for i in $(seq 1 "$RUNS"); do
    rm -rf "$WORK/O-$name"
    s=$(date +%s%N)
    ( cd "$WORK/S-$name" && $HUGO --quiet --destination "$WORK/O-$name" >/dev/null 2>&1 )
    e=$(date +%s%N)
    printf ' %s秒' "$(awk "BEGIN{printf \"%.2f\", ($e-$s)/1000000000}")"
  done
  printf '\n'
done
echo

# --- 出力の一致確認 -------------------------------------------------------
echo "出力の比較 (before と after):"
if diff -rq "$WORK/O-before" "$WORK/O-after" > "$WORK/diff.txt" 2>&1; then
  echo "  完全一致"
else
  echo "  差分あり: $(wc -l < "$WORK/diff.txt") 件"
  echo "  (日時を出力する now ショートコードを使っていると差分が出ます)"
  head -10 "$WORK/diff.txt" | sed 's/^/    /'
  echo "  全件: $WORK/diff.txt"
fi
echo
echo "ページ数: $(find "$WORK/O-after" -name '*.html' | wc -l) ファイル"
echo "出力量  : $(du -sm "$WORK/O-after" | cut -f1) MB"
echo "1ページ : $(find "$WORK/O-after" -name '*.html' -exec stat -c%s {} \; 2>/dev/null | sort -rn | head -1) bytes (最大)"
echo
echo "作業ディレクトリを消す場合: rm -rf $WORK"
