mkdir /tmp/abseil-20260817.0
cd /tmp/abseil-20260817.0
git clone --branch 20260817.0 https://github.com/abseil/abseil-cpp.git
cd abseil-cpp
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
sudo cmake --install .

mkdir /tmp/re2-2025-11-05
cd /tmp/re2-2025-11-05
git clone --branch 2025-11-05 https://github.com/google/re2.git
cd re2
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
sudo cmake --install .
