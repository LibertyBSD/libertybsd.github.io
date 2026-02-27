#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_URL="https://github.com/LibertyBSD/libertybsd-website"

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
			<a href="download.html">$(ml header_download)</a>
		</td>
		<td>
			<a href="faq.html">$(ml header_faqs)</a>
		</td>
		<td>
			<a href="$REPO_URL">$(ml header_git)</a>
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

	{
		render_header "$lang" "$(ml title_downloads title_download)" "$asset_prefix/style.css"
		cat <<EOF2

<h2>$(ml download_downloads)</h2>

<h2>$(ml download_current_mirrors)</h2>

<center>
<table border="2">
	<tr>
		<td><b>$(ml download_host)</b></td>
		<td><b>$(ml download_type)</b></td>
		<td><b>$(ml download_location)</b></td>
		<td><b>$(ml download_protocols)</b></td>
	</tr>
	<tr>
		<td><a href="https://www.allbsd.org/">AllBSD</a></td>
		<td>$(ml download_full)</td>
		<td>$(ml location_chiba_japan)</td>
		<td><a href="https://pub.allbsd.org/LibertyBSD/">HTTP(S)</a>,
			<a href="ftp://ftp.allbsd.org/pub/LibertyBSD/">FTP</a>,
			<a href="rsync://rsync.allbsd.org">rsync</a></td>
	</tr>
	<tr>
		<td><a href="https://libertybsd.net/">LibertyBSD</a></td>
		<td>$(ml download_full)</td>
		<td>$(ml location_texas_usa)</td>
		<td><a href="https://ftp.libertybsd.net/pub/LibertyBSD">HTTP(S)</a>,
		<a href="ftp://ftp.libertybsd.net/pub/LibertyBSD">FTP</a></td>
	</tr>
</table>
</center>

<hr>

<h2>$(ml download_defunct_mirrors)</h2>
<p>$(ml download_defunct_mirrors_info)</p>

<center>
<table border="2">
	<tr>
		<td><b>$(ml download_host)</b></td>
		<td><b>$(ml download_last_version)</b></td>
		<td><b>$(ml download_location)</b></td>
		<td><b>$(ml download_protocols)</b></td>
	</tr>
	<tr>
		<td><a href="https://delwink.com/">Delwink Software</a></td>
		<td>$(ml download_install_only)</td>
		<td>$(ml location_usa)</td>
		<td>HTTP(S)</td>
	</tr>
</table>
</center>

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
