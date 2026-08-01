Into this folder copy the libopenxr_loader.so for each HMD required to support, suffixed with the headset type:

libopenxr_loader_meta.so
libopenxr_loader_pico.so
libopenxr_loader_samsung.so   (Samsung Galaxy XR / Android XR - build the generic Khronos
                               OpenXR-SDK loader from https://github.com/KhronosGroup/OpenXR-SDK-Source
                               for arm64-v8a; Android XR's system OpenXR runtime is discovered via the
                               standard org.khronos.openxr broker mechanism, not a vendor-specific SDK)

Also copy the same generic Khronos loader (unsuffixed) to
Projects/AndroidPrebuilt/jni/libopenxr_loader.so - this is the one actually linked into
the engine at build time; the per-manufacturer suffixed copies above are loaded at
runtime by GLES3JNIActivity based on Build.MANUFACTURER.
