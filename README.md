# cudf-build-scripts"
- ✅OK run_build_libcudf_ubuntu24.04_cuda12.6_cmake3.30.8.sh
- ✅OK run_build_libcudf_ubuntu24.04_cuda12.9_cmake3.30.8.sh
- ✅OK run_build_libcudf_ubuntu24.04_cuda12.9_cmake4.0.2.sh

This warning occur.
```
[ 98%] Building CXX object CMakeFiles/cudf.dir/src/utilities/type_dispatcher.cpp.o
[ 98%] Linking CXX shared library libcudf.so
/usr/bin/ld: warning: /home/yaikeda/git/cudf/cpp/build/fatbin.ld contains output sections; did you forget -T?
[ 98%] Built target cudf
[ 98%] Building CXX object CMakeFiles/cudftest_default_stream.dir/tests/utilities/default_stream.cpp.o
```

# Reference
- [NVIDIA CUDA Toolkit](https://developer.nvidia.com/cuda-downloads)
- [CMAKE](https://cmake.org/files/)
  - This link is to direct download links.
