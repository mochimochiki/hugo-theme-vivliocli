{{- $pdfname := partial "functions/outputEditionParam" (dict "page" . "param" "pdfname" ) -}}
{{- $doctitle := partial "functions/outputEditionParam" (dict "page" . "param" "doctitle" ) -}}
module.exports = {
  title: '{{ $doctitle }}',
  {{ if .Params.author }}author: '{{ .Params.author }}',{{ end }}
  size: '{{ .Params.pagesize }}',
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
  output: [
    '{{ printf "%s.pdf" $pdfname }}'
  ]
}
