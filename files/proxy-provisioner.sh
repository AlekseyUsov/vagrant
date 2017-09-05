#!/bin/bash

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
  echo -e "\nexport http_proxy=http://${PROXY}" >> /etc/profile
  echo -e "export https_proxy=https://${PROXY}\n" >> /etc/profile
fi
