#!/usr/bin/env bash
# ----------------------------------------------------------------------------
#
# Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
#
# WSO2 Inc. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# ----------------------------------------------------------------------------

set -e

readonly WUM_USERNAME=$2
readonly WUM_PASSWORD=$4

WORKING_DIRECTORY=/home/ubuntu
WSO2_SERVER_PACK=wso2am-2.1.0.zip
WSO2_SERVER_UPDATED_PACK=wso2am-2.1.0.*.zip
WUM_HOME=/usr/local/
WUM_ARCHIVE=wum-1.0-linux-x64.tar.gz
WUM_PATH='PATH=$PATH:/usr/local/wum/bin'
WUM_PRODUCT_LOCATION=/root/.wum-wso2/products/${WSO2_SERVER_PACK}

tar -xf /home/ubuntu/${WUM_ARCHIVE} -C ${WUM_HOME} --strip-components=1
chown -R ubuntu wum/

export WUM_PATH

sudo -u ubuntu /usr/local/wum/bin/wum init -u ${WUM_USERNAME} -p ${WUM_PASSWORD}

wum add --file ${WORKING_DIRECTORY}/${WSO2_SERVER_PACK}

wum update

if [ ! - f ${WUM_PRODUCT_LOCATION}/${WSO2_SERVER_UPDATED_PACK} ]; then
  :
else
  mv ${WUM_PRODUCT_LOCATION}/${WSO2_SERVER_UPDATED_PACK} /etc/puppet/modules/wso2am_runtime/files
fi


