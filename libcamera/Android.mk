# Copyright (C) 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifeq ($(TARGET_BOOTLOADER_BOARD_NAME), universal7580)

LOCAL_PATH:= $(call my-dir)

# universal7580 (Exynos7580) uses the 75xx HAL sources + shared common/.
# gvwifi (Galaxy View SM-T670) has a SINGLE front-facing camera (SR261).
# SINGLE_FRONT_CAMERA swaps the CAMERA_ID enum (FRONT=0) and shrinks the
# static camera table to that one camera, so ID-keyed pipeline selection
# (SS1/3A1 nodes, GSC, sensor file) all resolve to the front sensor.
# gvwifi sensor/rotation defaults:
BOARD_BACK_CAMERA_ROTATION ?= 90
BOARD_FRONT_CAMERA_ROTATION ?= 270
BOARD_HAS_SINGLE_FRONT_CAMERA ?= true

#################
# libexynoscamera

include $(CLEAR_VARS)

LOCAL_SHARED_LIBRARIES:= libutils libcutils libbinder liblog libcamera_client libhardware
LOCAL_SHARED_LIBRARIES += libexynosutils libhwjpeg libexynosv4l2 libexynosgscaler libion libcsc
LOCAL_SHARED_LIBRARIES += libexpat libgui libui
# NOTE: libstlport (KitKat-era) and libpower removed: Oreo has no stlport
# module and nothing in 75xx/common references power APIs.

LOCAL_CFLAGS += -DGAIA_FW_BETA
LOCAL_CFLAGS += -DUSE_HAL3_2_METADATA_INTERFACE
LOCAL_CFLAGS += -DMAIN_CAMERA_SENSOR_NAME=$(BOARD_BACK_CAMERA_SENSOR)
LOCAL_CFLAGS += -DFRONT_CAMERA_SENSOR_NAME=$(BOARD_FRONT_CAMERA_SENSOR)
ifeq ($(BOARD_CAMERA_DISPLAY_WQHD), true)
	LOCAL_CFLAGS += -DCAMERA_DISPLAY_WQHD
endif
LOCAL_CFLAGS += -DUSE_CAMERA_ESD_RESET
LOCAL_CFLAGS += -DBACK_ROTATION=$(BOARD_BACK_CAMERA_ROTATION)
LOCAL_CFLAGS += -DFRONT_ROTATION=$(BOARD_FRONT_CAMERA_ROTATION)
LOCAL_CFLAGS += -Wno-date-time
LOCAL_CFLAGS += -DUSE_FRAME_REFERENCE_COUNT
LOCAL_CFLAGS += -DUSE_FRAMEMANAGER
LOCAL_CFLAGS += -DBURST_CAPTURE
LOCAL_CFLAGS += -DSAMSUNG_COMPANION
ifeq ($(BOARD_HAS_SINGLE_FRONT_CAMERA), true)
LOCAL_CFLAGS += -DSINGLE_FRONT_CAMERA
endif

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../include \
	$(LOCAL_PATH)/../libcamera \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/75xx \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/75xx/JpegEncoderForCamera \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common/Pipes2 \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common/MCPipes \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common/Activities \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common/Buffers \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common/Vendor \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common/SensorInfos \
	$(LOCAL_PATH)/../libcamera/Vendor \
	$(TOP)/hardware/samsung_slsi-cm/exynos/include \
	$(TOP)/hardware/samsung_slsi-cm/$(TARGET_SOC)/include \
	$(TOP)/hardware/samsung_slsi-cm/$(TARGET_BOARD_PLATFORM)/include \
	$(TOP)/hardware/samsung_slsi-cm/$(TARGET_BOARD_PLATFORM)/libcamera \
	$(TOP)/hardware/libhardware_legacy/include/hardware_legacy \
	$(TOP)/vendor/samsung/feature/CscFeature/libsecnativefeature \
	$(TOP)/bionic \
	$(TOP)/external/expat/lib \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \
	$(LOCAL_PATH)/v4l2-kernel

LOCAL_ADDITIONAL_DEPENDENCIES += \
	INSTALLED_KERNEL_HEADERS

LOCAL_SRC_FILES:= \
	ExynosCameraSensorInfo.cpp \
	../../exynos/libcamera/common/SensorInfos/ExynosCameraSensorInfoBase.cpp \
	../../exynos/libcamera/common/ExynosCameraFrame.cpp \
	../../exynos/libcamera/common/ExynosCameraFrameManager.cpp \
	../../exynos/libcamera/common/ExynosCameraMemory.cpp \
	../../exynos/libcamera/common/ExynosCameraUtils.cpp \
	../../exynos/libcamera/common/ExynosCameraNode.cpp \
	../../exynos/libcamera/common/ExynosCameraFrameSelector.cpp \
	../../exynos/libcamera/common/Pipes2/ExynosCameraPipe.cpp \
	../../exynos/libcamera/common/Pipes2/ExynosCameraPipeFlite.cpp \
	../../exynos/libcamera/common/Pipes2/ExynosCameraPipe3AA_ISP.cpp \
	../../exynos/libcamera/common/Pipes2/ExynosCameraPipeSCC.cpp \
	../../exynos/libcamera/common/Pipes2/ExynosCameraPipeSCP.cpp \
	../../exynos/libcamera/common/Pipes2/ExynosCameraPipeGSC.cpp \
	../../exynos/libcamera/common/Pipes2/ExynosCameraPipeJpeg.cpp \
	../../exynos/libcamera/common/Pipes2/ExynosCameraPipe3AA.cpp \
	../../exynos/libcamera/common/Pipes2/ExynosCameraPipe3AC.cpp \
	../../exynos/libcamera/common/Pipes2/ExynosCameraPipeISP.cpp \
	../../exynos/libcamera/common/Pipes2/ExynosCameraPipeISPC.cpp \
	../../exynos/libcamera/common/Pipes2/ExynosCameraPipeDIS.cpp \
	../../exynos/libcamera/common/MCPipes/ExynosCameraMCPipe.cpp \
	../../exynos/libcamera/common/Buffers/ExynosCameraBufferManager.cpp \
	../../exynos/libcamera/common/Buffers/ExynosCameraBufferLocker.cpp \
	../../exynos/libcamera/common/Activities/ExynosCameraActivityBase.cpp \
	../../exynos/libcamera/common/Activities/ExynosCameraActivityAutofocus.cpp \
	../../exynos/libcamera/common/Activities/ExynosCameraActivityFlash.cpp \
	../../exynos/libcamera/common/Activities/ExynosCameraActivitySpecialCapture.cpp \
	../../exynos/libcamera/common/Activities/ExynosCameraActivityUCTL.cpp \
	../../exynos/libcamera/common/Vendor/SecCameraVendorTags.cpp \
	../../exynos/libcamera/75xx/JpegEncoderForCamera/ExynosJpegEncoderForCamera.cpp \
	../../exynos/libcamera/75xx/ExynosCamera.cpp \
	../../exynos/libcamera/75xx/ExynosCameraParameters.cpp \
	../../exynos/libcamera/75xx/ExynosCameraFrameFactory.cpp \
	../../exynos/libcamera/75xx/ExynosCameraFrameFactory3aaIspM2M.cpp \
	../../exynos/libcamera/75xx/ExynosCameraFrameFactory3aaIspM2MTpu.cpp \
	../../exynos/libcamera/75xx/ExynosCameraFrameFactory3aaIspOtf.cpp \
	../../exynos/libcamera/75xx/ExynosCameraFrameFactory3aaIspOtfTpu.cpp \
	../../exynos/libcamera/75xx/ExynosCameraFrameFactoryPreview.cpp \
	../../exynos/libcamera/75xx/ExynosCameraFrameReprocessingFactory.cpp \
	../../exynos/libcamera/75xx/ExynosCameraFrameFactoryFront.cpp \
	../../exynos/libcamera/75xx/ExynosCameraFrameFactoryVision.cpp \
	../../exynos/libcamera/75xx/ExynosCameraActivityControl.cpp\
	../../exynos/libcamera/75xx/ExynosCameraUtilsModule.cpp \
	../../exynos/libcamera/75xx/ExynosCameraScalableSensor.cpp

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libexynoscamera
LOCAL_MULTILIB := 32
LOCAL_32_BIT_ONLY := true

include $(BUILD_SHARED_LIBRARY)

#################
# libcamera

include $(CLEAR_VARS)

# HAL module implemenation stored in
# hw/<COPYPIX_HARDWARE_MODULE_ID>.<ro.product.board>.so
LOCAL_MODULE_RELATIVE_PATH := hw

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../include \
	$(LOCAL_PATH)/../libcamera \
	$(LOCAL_PATH)/../libcamera/Vendor \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/75xx \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/75xx/JpegEncoderForCamera \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common/Pipes2 \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common/MCPipes \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common/Activities \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common/Buffers \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common/Vendor \
	$(TOP)/hardware/samsung_slsi-cm/exynos/libcamera/common/SensorInfos \
	$(TOP)/hardware/samsung_slsi-cm/exynos/include \
	$(TOP)/hardware/samsung_slsi-cm/$(TARGET_SOC)/include \
	$(TOP)/hardware/samsung_slsi-cm/$(TARGET_BOARD_PLATFORM)/include \
	$(TOP)/hardware/samsung_slsi-cm/$(TARGET_BOARD_PLATFORM)/libcamera \
	frameworks/native/include \
	system/media/camera/include \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \
	$(LOCAL_PATH)/v4l2-kernel

LOCAL_ADDITIONAL_DEPENDENCIES += \
	INSTALLED_KERNEL_HEADERS

LOCAL_SRC_FILES:= \
	../../exynos/libcamera/common/ExynosCameraInterface.cpp

LOCAL_CFLAGS += -DGAIA_FW_BETA
LOCAL_CFLAGS += -DUSE_HAL3_2_METADATA_INTERFACE
LOCAL_CFLAGS += -DBACK_ROTATION=$(BOARD_BACK_CAMERA_ROTATION)
LOCAL_CFLAGS += -DFRONT_ROTATION=$(BOARD_FRONT_CAMERA_ROTATION)
LOCAL_CFLAGS += -Wno-date-time
LOCAL_CFLAGS += -DUSE_FRAME_REFERENCE_COUNT
LOCAL_CFLAGS += -DUSE_FRAMEMANAGER
LOCAL_CFLAGS += -DBURST_CAPTURE
LOCAL_CFLAGS += -DSAMSUNG_COMPANION
ifeq ($(BOARD_HAS_SINGLE_FRONT_CAMERA), true)
LOCAL_CFLAGS += -DSINGLE_FRONT_CAMERA
endif

LOCAL_SHARED_LIBRARIES:= libutils libcutils libbinder liblog libcamera_client libhardware
LOCAL_SHARED_LIBRARIES += libexynosutils libhwjpeg libexynosv4l2 libcsc libion libexynoscamera
LOCAL_SHARED_LIBRARIES += libgui libui

LOCAL_MODULE := camera.$(TARGET_BOOTLOADER_BOARD_NAME)
LOCAL_MULTILIB := 32
LOCAL_32_BIT_ONLY := true

LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

endif
