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

#ifndef EXYNOS_CAMERA_SENSOR_INFO_H
#define EXYNOS_CAMERA_SENSOR_INFO_H

#include <videodev2.h>
#include <videodev2_exynos_camera.h>
#include "ExynosCameraConfig.h"
#include "ExynosCameraSizeTable.h"
#include "fimc-is-metadata.h"
#include "SensorInfos/ExynosCameraSensorInfoBase.h"

namespace android {

#ifdef SENSOR_NAME_GET_FROM_FILE
int getSensorIdFromFile(int camId);
#endif

typedef struct ExynosSensorInfoBase ExynosSensorInfo;
typedef struct ExynosSensorS5K6B2Base ExynosSensorS5K6B2;
typedef struct ExynosSensorS5K3L2Base ExynosSensorS5K3L2;
typedef struct ExynosSensorS5K2P2Base ExynosSensorS5K2P2;
typedef struct ExynosSensorIMX135Base ExynosSensorIMX135;
typedef struct ExynosSensorIMX134Base ExynosSensorIMX134;
typedef struct ExynosSensorS5K6A3Base ExynosSensorS5K6A3;
typedef struct ExynosSensorS5K3H5Base ExynosSensorS5K3H5;
typedef struct ExynosSensorS5K4H5Base ExynosSensorS5K4H5;
typedef struct ExynosSensorS5K3H7Base ExynosSensorS5K3H7;
typedef struct ExynosSensorIMX175Base ExynosSensorIMX175;
typedef struct ExynosSensorS5K8B1Base ExynosSensorS5K8B1;
typedef struct ExynosSensorSR261Base ExynosSensorSR261;

/* Helper functions */
ExynosSensorInfo *createSensorInfo(int sensorName);
int getSensorId(int camId);
bool needGSCForCapture(int camId);

}; /* namespace android */

#endif
