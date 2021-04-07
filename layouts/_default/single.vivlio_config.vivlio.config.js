{{- $pdfname := partial "functions/outputEditionParam" (dict "page" . "param" "pdfname" ) -}}
{{- $doctitle := partial "functions/outputEditionParam" (dict "page" . "param" "doctitle" ) -}}
module.exports = {
  title: '{{ $doctitle }}',
  {{ if .Params.author }}author: '{{ .Params.author }}',{{ end }}
  size: '{{ .Params.pagesize }}',
  entry: [
    '_pdf.vivlio.cover.html',
    {{- define "entry_hierarchy" }}
      {{- range .Pages.ByWeight }}
        {{- if partial "functions/isShow" . }}
          {{- $url := urls.Parse (.RelPermalink | urlize) }}
          {{- $path := $url.Path }}
          {{- $link := printf "..%s" $path }}
    '{{ $link }}',
          {{- if .IsSection }}{{ template "entry_hierarchy" . }}{{ end }}
        {{- end }}
      {{- end }}
    {{- end }}
    {{ template "entry_hierarchy" .CurrentSection }}
    {{- if .Params.colophon }}
    '_pdfcolophon.vivlio.colophon.html'
    {{- end }}
  ],
  output: [
    '{{ printf "%s.pdf" $pdfname }}'
  ]
}
