#!/bin/sh


# index
# --------------------------------------
title_index="LibertyBSD"

index_raddle="/f/libertybsd on <a href='https://raddle.me'>raddle</a> &#x1f44d;"
index_reddit="/r/libertybsd on <a href='https://reddit.com'>reddit</a> &#x1f44e;"
index_freenode="#libertybsd on <a href='https://freenode.net'>Freenode</a> &#x2605;"


index_p1="<a href='https://openbsd.org'>OpenBSD</a> es universalmente conocido
como un sistema operativo diseñado con la seguridad en mente, que
orgullosamente puede decir que ha tenido “Solo dos agujeros remotos en la
instalación por defecto en un montón de tiempo”."

index_p2="Sin embargo, OpenBSD se distribuye con
<a href='https://cvsweb.openbsd.org/cgi-bin/cvsweb/src/distrib/miniroot/install.sub.diff?r1=1.653&r2=1.654&f=h'>
varias partes de firmware binario</a> no libre en el sistema base, y
dependiendo del hardware detectado, por defecto un script descargará más en el
primer arranque, sin informar a la usuaria de esto."

index_p3="Con una instalación por defecto, podrías acabar usando alguno de este
firmware privativo sin siquiera saberlo, y (si tratas de instalar software
adicional) podrías terminar instalando inconscientemente programas no libres."

index_p4="LibertyBSD es una variante de OpenBSD sin “blobs”. Puedes obtener
todos los beneficios de OpenBSD, mientras te aseguras que no hay nada no libre
escondido en las profundidades de tu sistema."


# descargar
# ---------------------------------------
title_download="LBSD - Descargar"
download_downloads="Descargar"

download_host="Host"
download_type="Tipo"
download_location="Ubicación"
download_protocols="Protocolos"
download_current_mirrors="Espejos Actuales"
download_old_mirrors="Espejos Viejos"
download_last_version="Versión"
download_full="Completar"
download_install_only="Sólo Instalación"
download_defunct_mirrors="Espejos Difuntos"
download_defunct_mirrors_info="These are sites that once mirrored LibertyBSD,
but don't anymore for one reason or another."


location_chiba_japan="Chiba, Japan"
location_usa="USA"
location_texas_usa="Texas, USA"


# FAQ
# --------------------------------------
title_faq="LBSD - Preguntas Frecuentes"
faq_faq="Preguntas Frecuentes"

faq_qarch="¿Qué arquitecturas mantendréis?"
faq_aarch="En la versión 5.9+, <code>amd64</code> y <code>i386</code> están
soportadas. En la 5.6 y la 5.8, solo <code>amd64</code> está soportada."
faq_qfsf="¿Es LibertyBSD una distribución «aprobada por la FSF»?"
faq_afsf="No. Pero estamos intentando que sea aprobada."
faq_qerrata="¿Qué hay acerca de las actualizaciones de seguridad?"
faq_aerrata="You can find patches <a href='errata.shtml'>here</a>.
You can manually compile and apply the patches yourself, if you want.<br />
Or you could use <code>syspatch</code>. Whatever floats your boat."
faq_qman="¿Dónde están las páginas de manual?"
faq_aman="En la 5.6, todas las páginas de manual excepto las de xenocara
fueron eliminadas por preocupación respecto a las directrices de la FSF para
distribuciones de sistema libres. De la 5.8 en adelante, hemos hecho un
esfuerzo por mantener la mayoría de las páginas de manual. No deberías echar
en falta ninguna."
faq_qcontact="¿Cómo puedo contactar con vosotros?/¡Tengo una pregunta que no
está resuelta aquí!"
faq_acontact="Si prefieres IRC, puedes encontrarnos en #libertybsd de freenode.
Si eso falla, prueba el <a href='https://raddle.me/f/libertybsd'>
/f/libertybsd</a>/<a href='https://reddit.com/r/libertybsd'>/r/libertybsd</a>.
Finalmente, si eso también falla, envíame un correo electrónico: &lt;jadedctrl @
teknik.io&gt;"
faq_qsources="¿Dónde está el código fuente?"
faq_asources="Lo encontrarás en ‘src.tar.gz’, ‘sys.tar.gz’ y ‘xenocara.tar.gz’.
Otras fuentes se pueden encontrar
<a href='https://git.eunichx.us/libertybsd-scritps'>aquí</a>."
faq_qnonfree="¡Aja! ¡He encontrado un elemento no libre en LibertyBSD!"
faq_anonfree="¡Por favor, comunícanoslo inmediatamente! Rellena un informe de
error aquí y cueantánoslo en IRC en #libertybsd! Gracias :)"
faq_qproblems="Tengo un problema con LibretyBSD.
¿Puedo ir a la lista de correo de OpenBSD?"
faq_aproblems="No, tío. LibertyBSD and OpenBSD son dos proyectos diferentes; a
no ser que puedas reproducir el fallo en OpenBSD, ¡por favor, por favor, por
favor, no les molestes! Molestanos a nosotros en su lugar. :p"
faq_qports="¿Qué hay del árbol de los puertos y el repositorio de paquetes?"
faq_aports="They're in your mirror's directory for your version-- under
'packages' for the repo, and 'ports.tar.gz' for the ports tree. (The ports
tree and repo are pure and squeaky-clean, by the way~)"



# --------------------------------------
# ---------------------------------------
# header
header_index="Índice"
header_download="Descargar"
header_faqs="Preguntas Frecuentes"
header_install="Install Guide"
header_git="Git"


# ---------------------------------------
# footer
footer_license="The HTML & CSS used to generate this webpage is hereby released
into the public domain. This applies worldwide. In case this is not legally
possible, any entity is granted the right to use this work for any purpose,
without any conditions, unless such conditions are required by law."
