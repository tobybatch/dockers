#!/bin/bash -x

/container/tool/run --copy-service --loglevel debug &

if [ ! -e /run-init ]; then 
    sleep 20
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    ldapadd -x -D cn=admin,$LDAP_BASE_DN -w $LDAP_ADMIN_PASSWORD -f /other-scripts/add_nodes.ldif
    ldapadd    -Q -Y EXTERNAL -H ldapi:/// -f /other-scripts/memberof_config.ldif
    ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f /other-scripts/refint1.ldif
    ldapadd    -Q -Y EXTERNAL -H ldapi:/// -f /other-scripts/refint2.ldif
    touch /run-init
fi
