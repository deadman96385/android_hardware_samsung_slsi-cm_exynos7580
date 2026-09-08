# Copyright (C) 2013 The Android Open Source Project
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


LOCAL_PATH := $(call my-dir)

# HAL module implemenation stored in
# hw/<OVERLAY_HARDWARE_MODULE_ID>.<ro.product.board>.so
include $(CLEAR_VARS)

LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_PROPRIETARY_MODULE := true
LOCAL_SHARED_LIBRARIES := liblog libcutils libion libutils libGLESv1_CM

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/../include \
	$(TOP)/hardware/samsung_slsi-cm/exynos/include \
	$(TOP)/hardware/samsung_slsi-cm/exynos5/include

LOCAL_SRC_FILES := 	\
	gralloc.cpp 	\
	gralloc_vsync.cpp \
	framebuffer.cpp \
	mapper.cpp

LOCAL_HEADER_LIBRARIES := libhardware_headers

LOCAL_CFLAGS := -DLOG_TAG=\"gralloc\"

ifeq ($(BOARD_USE_BGRA_8888_FB),true)
LOCAL_CFLAGS += -DUSE_BGRA_8888
endif

LOCAL_MODULE := gralloc.exynos5

# gralloc is a HAL module dlopen()ed by both 64-bit processes (surfaceflinger,
# the 64-bit mapper) and the remaining 32-bit Samsung blobs (OMX, camera,
# hwcomposer), so it must exist for both ABIs.
#
# This is safe because private_handle_t in ../include/gralloc_priv.h unions
# every pointer with a uint64_t, so the handle layout is byte-identical for
# 32-bit and 64-bit builds.
LOCAL_MULTILIB := both

include $(BUILD_SHARED_LIBRARY)
