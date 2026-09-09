/*
** Copyright 2013, Samsung Electronics Co. LTD
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
**     http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
*/

#define LOG_TAG "ExynosCameraUtils"
#include <cutils/log.h>

#include "ExynosCameraSensorInfo.h"

namespace android {

// g_rearSensorId and g_frontSensorId are defined in ExynosCameraSensorInfoBase.cpp

ExynosSensorInfo *createSensorInfo(int camId)
{
    ExynosSensorInfo *sensorInfo = NULL;
    int sensorName = getSensorId(camId);
    if (sensorName < 0) {
        ALOGE("ERR(%s[%d]): Inavalid camId, sensor name is nothing", __FUNCTION__, __LINE__);
        sensorName = SENSOR_NAME_NOTHING;
    }

    switch (sensorName) {
    case SENSOR_NAME_S5K6B2:
        sensorInfo = new ExynosSensorS5K6B2();
        break;
    case SENSOR_NAME_S5K3L2:
        sensorInfo = new ExynosSensorS5K3L2();
        break;
    #if 0
    case SENSOR_NAME_S5K2P2:
        sensorInfo = new ExynosSensorS5K2P2();
        break;
#endif
    case SENSOR_NAME_IMX135:
        sensorInfo = new ExynosSensorIMX135();
        break;
    case SENSOR_NAME_IMX134:
        sensorInfo = new ExynosSensorIMX134();
        break;
    case SENSOR_NAME_S5K6A3:
        sensorInfo = new ExynosSensorS5K6A3();
        break;
    case SENSOR_NAME_S5K3H5:
        sensorInfo = new ExynosSensorS5K3H5();
        break;
    case SENSOR_NAME_S5K4H5:
        sensorInfo = new ExynosSensorS5K4H5();
        break;
    case SENSOR_NAME_S5K3H7:
    case SENSOR_NAME_S5K3H7_SUNNY:
        sensorInfo = new ExynosSensorS5K3H7();
        break;
    case SENSOR_NAME_IMX175:
        sensorInfo = new ExynosSensorIMX175();
        break;
    case SENSOR_NAME_S5K8B1:
        sensorInfo = new ExynosSensorS5K8B1();
        break;
    case SENSOR_NAME_SR261:
        sensorInfo = new ExynosSensorSR261();
        break;
    default:
        ALOGW("WRN(%s[%d]): Unknown sensor, create default sensor", __FUNCTION__, __LINE__);
        sensorInfo = new ExynosSensorInfo();
        break;
    }

    return sensorInfo;
}

bool needGSCForCapture(int camId)
{
    return (camId == CAMERA_ID_BACK) ? USE_GSC_FOR_CAPTURE_BACK : USE_GSC_FOR_CAPTURE_FRONT;
}

// getSensorId is defined in ExynosCameraSensorInfoBase.cpp

}; /* namespace android */
