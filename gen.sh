#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
GITHUB_URL="https://github.com/euxaristia/libertybsd-scripts/"

# KEY [FALLBACK_KEY]
get_value() {
	local key="$1"
	local fallback="${2:-}"

	if [[ -n "${!key-}" ]]; then
		printf '%s' "${!key}"
		return
	fi

	if [[ -n "$fallback" && -n "${!fallback-}" ]]; then
		printf '%s' "${!fallback}"
	fi
}

normalize_links() {
	local text="$1"
	text="${text//errata.shtml/errata.html}"
	text="${text//download.shtml/download.html}"
	text="${text//faq.shtml/faq.html}"
	text="${text//index.shtml/index.html}"
	text="${text//<\/br>/<br />}"
	printf '%s' "$text"
}

# KEY [FALLBACK_KEY]
ml() {
	local value
	value="$(get_value "$1" "${2:-}")"
	normalize_links "$value"
}

asset_prefix_for() {
	local lang="$1"
	if [[ "$lang" == "en" ]]; then
		printf '%s' "res"
	else
		printf '%s' "../res"
	fi
}

out_dir_for() {
	local lang="$1"
	if [[ "$lang" == "en" ]]; then
		printf '%s' "$ROOT_DIR"
	else
		printf '%s' "$ROOT_DIR/$lang"
	fi
}

lang_page_link() {
	local current_lang="$1"
	local target_lang="$2"
	local page="$3"

	case "$current_lang:$target_lang" in
		en:en)
			printf '%s.html' "$page"
			;;
		en:es)
			printf 'es/%s.html' "$page"
			;;
		en:eo)
			printf 'eo/%s.html' "$page"
			;;
		es:en|eo:en)
			printf '../%s.html' "$page"
			;;
		es:es|eo:eo)
			printf '%s.html' "$page"
			;;
		es:eo)
			printf '../eo/%s.html' "$page"
			;;
		eo:es)
			printf '../es/%s.html' "$page"
			;;
	esac
}

render_header() {
	local lang="$1"
	local title="$2"
	local css_path="$3"

	cat <<EOF2
<!DOCTYPE html>
<html lang="$lang">

<!--
 ________________________________________
( q-quick, think of something clever...! )
 ----------------------------------------
        o   ^__^
         o  (oo)\\_______
            (__)\\       )\\/\\
         /      ||----w |
        /       ||     ||
 __________________________________
< U-uhm... hello, world! /(;~:)\\   >
 ----------------------------------

-->

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="$css_path">
	<meta charset="UTF-8">
	<title>$title</title>
</head>

<body>

<center>
<table border="2">
	<tr>
		<td>
			<a href="index.html">$(ml header_index)</a>
		</td>
		<td>
			<a href="faq.html">$(ml header_faqs)</a>
		</td>
		<td>
			<a href="$GITHUB_URL">GitHub</a>
		</td>
	</tr>
</table>
</center>
EOF2
}

render_footer() {
	local current_lang="$1"
	local page="$2"
	local en_link
	local es_link
	local eo_link

	en_link="$(lang_page_link "$current_lang" "en" "$page")"
	es_link="$(lang_page_link "$current_lang" "es" "$page")"
	eo_link="$(lang_page_link "$current_lang" "eo" "$page")"

	cat <<EOF2
<footer>
<hr />

<center>
<table border="2">
	<tr>
		<td><a href="$en_link">English</a></td>
		<td><a href="$es_link">Español</a></td>
		<td><a href="$eo_link">Esperanto</a></td>
	</tr>
</table>
</center>
</footer>

</body>
</html>
EOF2
}

render_index() {
	local lang="$1"
	local out_file="$2"
	local asset_prefix="$3"
	local logo_alt
	local xdm_alt
	local x11_alt

	case "$lang" in
		en)
			logo_alt="LibertyBSD logo"
			xdm_alt="XDM screenshot"
			x11_alt="X11 screenshot"
			;;
		es)
			logo_alt="Logotipo de LibertyBSD"
			xdm_alt="Captura de XDM"
			x11_alt="Captura de X11"
			;;
		eo)
			logo_alt="LibertyBSD emblemo"
			xdm_alt="Ekrankopio de XDM"
			x11_alt="Ekrankopio de X11"
			;;
	esac

	{
		render_header "$lang" "$(ml title_index)" "$asset_prefix/style.css"
		cat <<EOF2

<a id="logo" href="$asset_prefix/img/art/logo.png">
	<img src="$asset_prefix/img/art/logo.png"
	width="400" alt="$logo_alt">
</a>


<div id="screens">
	<a href="$asset_prefix/img/screens/xdm.png">
		<img src="$asset_prefix/img/screens/xdm.png"
		width="300" alt="$xdm_alt">
	</a>
	<a href="$asset_prefix/img/screens/x11.png">
		<img src="$asset_prefix/img/screens/x11.png"
		width="300" alt="$x11_alt">
	</a>
</div>

<p id="contact">
	$(ml index_raddle) <br />
	$(ml index_reddit) <br />
	$(ml index_freenode)
</p>


<div id="description">
<p>
$(ml index_p1)
</p>

<p>
$(ml index_p2)
</p>

<p>
$(ml index_p3)
</p>

<p>
$(ml index_p4)
</p>
</div>

EOF2
		render_footer "$lang" "index"
	} > "$out_file"
}

render_download() {
	local lang="$1"
	local out_file="$2"
	local asset_prefix="$3"
	local title
	local heading
	local message
	local click_here
	local home_label

	case "$lang" in
		en)
			title="LBSD - Redirect"
			heading="Redirecting to GitHub..."
			message="The old downloads page has moved."
			click_here="Click here if you are not redirected automatically."
			home_label="Return to index"
			;;
		es)
			title="LBSD - Redirección"
			heading="Redirigiendo a GitHub..."
			message="La antigua página de descargas se ha movido."
			click_here="Haz clic aquí si no se redirige automáticamente."
			home_label="Volver al índice"
			;;
		eo)
			title="LBSD - Alidirekto"
			heading="Alidirektado al GitHub..."
			message="La malnova elŝuta paĝo translokiĝis."
			click_here="Klaku ĉi tie se vi ne aŭtomate alidirektiĝas."
			home_label="Reiri al indekso"
			;;
	esac

	{
		render_header "$lang" "$title" "$asset_prefix/style.css"
		cat <<EOF2

<meta http-equiv="refresh" content="0; url=$GITHUB_URL">

<h2>$heading</h2>
<p>$message</p>
<p><a href="$GITHUB_URL">$click_here</a></p>
<p><a href="index.html">$home_label</a></p>
<script>
window.location.replace("$GITHUB_URL");
</script>

EOF2
		render_footer "$lang" "download"
	} > "$out_file"
}

render_faq() {
	local lang="$1"
	local out_file="$2"
	local asset_prefix="$3"

	{
		render_header "$lang" "$(ml title_faq)" "$asset_prefix/style.css"
		cat <<EOF2

<h1>$(ml faq_faq)</h1>

<ul id="faq">
	<li class="question" id="arch">$(ml faq_qarch)</li>
	<li class="answer">$(ml faq_aarch)</li>

	<li class="question" id="fsf">$(ml faq_qfsf)</li>
	<li class="answer">$(ml faq_afsf)</li>

	<li class="question" id="errata">$(ml faq_qerrata)</li>
	<li class="answer">$(ml faq_aerrata faq_aerrate)</li>

	<li class="question" id="man">$(ml faq_qman)</li>
	<li class="answer">$(ml faq_aman)</li>

	<li class="question" id="contact">$(ml faq_qcontact)</li>
	<li class="answer" id="contact-answer">$(ml faq_acontact)</li>

	<li class="question" id="sources">$(ml faq_qsources)</li>
	<li class="answer">$(ml faq_asources)</li>

	<li class="question" id="non-free">$(ml faq_qnonfree)</li>
	<li class="answer">$(ml faq_anonfree)</li>

	<li class="question" id="problems">$(ml faq_qproblems)</li>
	<li class="answer">$(ml faq_aproblems)</li>

	<li class="question" id="ports">$(ml faq_qports)</li>
	<li class="answer">$(ml faq_aports)</li>
</ul>

EOF2
		render_footer "$lang" "faq"
	} > "$out_file"
}

render_errata() {
	local lang="$1"
	local out_file="$2"
	local asset_prefix="$3"
	local title
	local heading
	local summary

	case "$lang" in
		en)
			title="LBSD - Errata"
			heading="Errata"
			summary="No errata page content is currently tracked in this repository."
			;;
		es)
			title="LBSD - Erratas"
			heading="Erratas"
			summary="Actualmente no hay contenido de erratas en este repositorio."
			;;
		eo)
			title="LBSD - Errata"
			heading="Errata"
			summary="Nun ne estas errata enhavo en ĉi tiu deponejo."
			;;
	esac

	{
		render_header "$lang" "$title" "$asset_prefix/style.css"
		cat <<EOF2

<h1>$heading</h1>
<p>$summary</p>

EOF2
		render_footer "$lang" "errata"
	} > "$out_file"
}

render_lang() {
	local lang="$1"
	local out_dir
	local asset_prefix

	out_dir="$(out_dir_for "$lang")"
	asset_prefix="$(asset_prefix_for "$lang")"
	mkdir -p "$out_dir"

	(
		# shellcheck disable=SC1090
		. "$ROOT_DIR/res/lang/$lang.sh"

		render_index "$lang" "$out_dir/index.html" "$asset_prefix"
		render_download "$lang" "$out_dir/download.html" "$asset_prefix"
		render_faq "$lang" "$out_dir/faq.html" "$asset_prefix"
		render_errata "$lang" "$out_dir/errata.html" "$asset_prefix"
	)
}

main() {
	render_lang "en"
	render_lang "es"
	render_lang "eo"
	touch "$ROOT_DIR/.nojekyll"
	echo "Static pages generated for en/es/eo."
}

main "$@"
