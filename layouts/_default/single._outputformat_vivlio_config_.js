{{- $pdfname := partial "functions/outputEditionParam" (dict "page" . "param" "pdfname" ) -}}
{{- $doctitle := partial "functions/outputEditionParam" (dict "page" . "param" "doctitle" ) -}}
module.exports = {
  title: '{{ $doctitle }}',
  {{ if .Params.author }}author: '{{ .Params.author }}',{{ end }}
  size: '{{ .Params.pagesize }}',
  {{- /* Vivliostyle CLI v9 以降は entry を workspaceDir へ複製してから配信するため、
       既定のままだと公開ルートの css / img がサーバのルート外に出て読めなくなる。
       '.' を指定してその場配信にし、static で公開ルート全体を配信させる。
       この設定ファイルは <公開先>/<言語>/ に集約されるので '..' が公開ルート。 */}}
  workspaceDir: '.',
  entry: [
    {{- if ne .Params.cover false }}
    '_pdf.vivlio.cover.html',
    {{- end }}
    {{- define "entry_hierarchy" }}
      {{- range .Pages.ByWeight }}
        {{- if partial "functions/isShow" . }}
          {{- $url := urls.Parse (.RelPermalink | urlize) }}
          {{- $path := $url.Path }}
          {{- $link := printf "..%s" $path }}
          {{- if .IsSection }}
            {{- if eq .Params.role "doc-part" }}
    '{{ $link }}',
            {{- else if ne $.Site.Params.inPageChapterPDF true }}
    '{{ $link }}',
            {{- end }}
            {{- template "entry_hierarchy" . }}
          {{- else }}
    '{{ $link }}',
          {{- end}}
        {{- end }}
      {{- end }}
    {{- end }}
    {{ template "entry_hierarchy" .CurrentSection }}
    {{- if .Params.colophon }}
    '_pdfcolophon.vivlio.colophon.html'
    {{- end }}
  ],
  static: { '/': ['..'] },
  output: [
    '{{ printf "%s.pdf" $pdfname }}'
  ]
}
