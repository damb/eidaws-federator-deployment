#!/bin/bash
#
# Purpose: Systematically crawl fdsnws-station metadata from EIDA data centers
# in order to keep eidaws-federator caches hot.
# ----------------------------------------------------------------------------


BIN=/var/www/eidaws-federator/venv/bin/eida-crawl-fdsnws-station

PATH_PIDFILE_TEMPLATE=/var/tmp/eida-crawl-fdsnws-station-DC.pid
path_pid_file() {
  echo ${PATH_PIDFILE_TEMPLATE/DC/${1}}
}

DC_ARGS=()
# NIEP
DC_ARGS[0]="-P $(eval path_pid_file niep) --domain eida-sc3.infp.ro"
# KOERI
DC_ARGS[1]="-P $(eval path_pid_file koeri) --domain eida-service.koeri.boun.edu.tr"
# BGR
DC_ARGS[2]="-P $(eval path_pid_file bgr) --domain eida.bgr.de"
# ETHZ
DC_ARGS[3]="-P $(eval path_pid_file ethz) --domain eida.ethz.ch"
# NOA
DC_ARGS[4]="-P $(eval path_pid_file noa) --domain eida.gein.noa.gr"
# UIB-NORSAR
DC_ARGS[5]="-P $(eval path_pid_file uib) --domain eida.geo.uib.no"
# LMU
DC_ARGS[6]="-P $(eval path_pid_file lmu) --domain erde.geophysik.uni-muenchen.de"
# GFZ
DC_ARGS[7]="-P $(eval path_pid_file gfz) --domain geofon.gfz-potsdam.de"
# INGV
DC_ARGS[8]="-P $(eval path_pid_file ingv) --domain webservices.ingv.it -w 4 --timeout 12"
# ICGC
DC_ARGS[9]="-P $(eval path_pid_file icgc) --domain ws.icgc.cat"
# RESIF
DC_ARGS[10]="-P $(eval path_pid_file resif) --domain ws.resif.fr"
# ODC
DC_ARGS[11]="-P $(eval path_pid_file odc) --domain www.orfeus-eu.org --timeout 12"

for dc_args in "${DC_ARGS[@]}"
do
  ${BIN} ${dc_args} &
done

wait

exit 0
