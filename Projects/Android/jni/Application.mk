APP_PLATFORM := android-24

APPLICATIONMK_PATH = $(call my-dir)
NDK_MODULE_PATH := $(APPLICATIONMK_PATH)/../..

XASH_SDL ?= 0

APP_CFLAGS += -Wl,--no-undefined

# Newer NDK toolchains default to a stricter C++ standard that rejects the
# (harmless, ignored) 'register' keyword used throughout the vintage HLSDK
# C++ code. Pin back to gnu++14 to match the standard the NDK this project
# originally targeted (25.x) used by default.
APP_CPPFLAGS += -std=gnu++14

# Newer Clang escalated implicit int<->pointer conversion (common in the
# vintage GoldSrc GL renderer's vertex-buffer offset code, e.g. glDrawElements
# with an integer byte offset instead of NULL+cast) from a warning to a hard
# error for C. Restore the older, non-fatal behavior.
APP_CFLAGS += -Wno-int-conversion -Wno-error=int-conversion

# Same story for loosely-typed C callback signatures (e.g. libmpg123's
# fread/fseek-shaped callbacks bound to file_t*-typed functions) - was a
# warning, newer Clang defaults it to a hard error.
APP_CFLAGS += -Wno-incompatible-function-pointer-types -Wno-error=incompatible-function-pointer-types

# if non-zero, works only if single ABI selected
XASH_THREAD_NUM ?= 0

TOP_DIR			:= $(APPLICATIONMK_PATH)/src
GL4ES_PATH := $(APPLICATIONMK_PATH)/src/gl4es/include
XASH3D_PATH := $(APPLICATIONMK_PATH)/src/Xash3D/xash3d
HLSDK_PATH  := $(APPLICATIONMK_PATH)/src/HLSDK/halflife/

# ndk-r14 introduced failure for missing dependencies. If 'false', the clean
# step will error as we currently remove prebuilt artifacts on clean.
APP_ALLOW_MISSING_DEPS=true

APP_MODULES := gl4es xash menu client server client_bshift server_bshift client_opfor server_opfor client_aomdc server_aomdc client_theyhunger server_theyhunger
APP_STL := c++_shared


