#!/bin/bash

PROFILE=/etc/profile

while getopts :h:p: opt; do
  case $opt in
    h) if [[ ${OPTARG} = -* ]]; then
         ((OPTIND--))
         PROXY=""
         break
       else
         PROXY=${OPTARG}
         echo ${OPTARG}
       fi
       ;;
    p) if [[ ${OPTARG} = -* ]]; then
         ((OPTIND--))
         continue
       else
         PROXY=${PROXY}:${OPTARG}
         echo ${OPTARG}
       fi
       ;;
  esac
done

echo ${PROXY}

if [ ! -z "${PROXY}" ]; then
  echo -e proxy="http://${PROXY}\n" >> /etc/yum.conf
  echo -e "\nexport http_proxy=http://${PROXY}" >> ${PROFILE}
  echo -e "export https_proxy=https://${PROXY}\n" >> ${PROFILE}
  echo -e "export no_proxy=127.0.0.1,localhost\n" >> ${PROFILE}
fi
