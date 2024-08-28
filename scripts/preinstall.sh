# Create celery group
CELERY_GRP="celery"
getent group "${CELERY_GRP}" > /dev/null || groupadd -r "${CELERY_GRP}" 2> /dev/null || :

# Create celery user
CELERY_USR="celery"
DEFAULT_SHELL="/sbin/nologin"
getent passwd "${CELERY_USR}" > /dev/null || useradd -r -m -c "Celery user" -g "${CELERY_GRP}" -s ${DEFAULT_SHELL} "${CELERY_USR}" 2> /dev/null || :


# Upgrade
if [ $1 -ge 2 ]; then
  if [ "$(getent passwd ${CELERY_USR} | awk -F: '{print $NF}')" != ${DEFAULT_SHELL} ] ; then
    logger -t "CELERY" -p user.info " preinstall.sh: Updating ${CELERY_USR} shell to ${DEFAULT_SHELL}"
    usermod -s ${DEFAULT_SHELL} ${CELERY_USR}
  fi
fi