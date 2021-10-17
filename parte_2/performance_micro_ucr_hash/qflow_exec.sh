#!/usr/bin/tcsh -f
#-------------------------------------------
# qflow exec script for project /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash
#-------------------------------------------

# /usr/lib/qflow/scripts/synthesize.sh /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash/source/micro_ucr_hash_mod.v || exit 1
# /usr/lib/qflow/scripts/placement.sh -d /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod || exit 1
# /usr/lib/qflow/scripts/opensta.sh  /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod || exit 1
/usr/lib/qflow/scripts/vesta.sh -a /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod || exit 1
# /usr/lib/qflow/scripts/router.sh /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod || exit 1
# /usr/lib/qflow/scripts/opensta.sh  -d /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod || exit 1
# /usr/lib/qflow/scripts/vesta.sh -a -d /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod || exit 1
# /usr/lib/qflow/scripts/migrate.sh /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod || exit 1
# /usr/lib/qflow/scripts/drc.sh /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod || exit 1
# /usr/lib/qflow/scripts/lvs.sh /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod || exit 1
# /usr/lib/qflow/scripts/gdsii.sh /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod || exit 1
# /usr/lib/qflow/scripts/cleanup.sh /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod || exit 1
# /usr/lib/qflow/scripts/display.sh /home/isaac/Desktop/Microelectrónica/Proyecto/Parte_2/performance_micro_ucr_hash micro_ucr_hash_mod || exit 1
