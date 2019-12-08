cmake_minimum_required(VERSION 3.0)
project(ThirdParty)

include(ExternalProject)

ExternalProject_Add( double-conversion
	GIT_REPOSITORY https://github.com/google/double-conversion.git
	GIT_TAG v3.1.5
)

ExternalProject_Add( zstd
	GIT_REPOSITORY https://github.com/facebook/zstd.git
	GIT_TAG v1.4.4
	SOURCE_SUBDIR build/cmake
)

ExternalProject_Add( fmt
	GIT_REPOSITORY https://github.com/fmtlib/fmt.git
	GIT_TAG 6.1.1
)

ExternalProject_Add( gflags
	GIT_REPOSITORY https://github.com/gflags/gflags.git
	GIT_TAG v2.2.2
	CMAKE_CACHE_ARGS
		-DCMAKE_CXX_FLAGS:STRING=-fPIC
)

ExternalProject_Add( glog
	GIT_REPOSITORY https://github.com/google/glog.git
	GIT_TAG v0.4.0
	DEPENDS gflags
)

ExternalProject_Add( folly
	GIT_REPOSITORY https://github.com/facebook/folly.git
	GIT_TAG v2019.12.06.00
	DEPENDS fmt gflags glog double-conversion zstd
)

ExternalProject_Add( fizz
	GIT_REPOSITORY https://github.com/facebookincubator/fizz.git
	GIT_TAG v2019.12.06.00
	SOURCE_SUBDIR fizz
	DEPENDS fmt folly
)

ExternalProject_Add( rsocket
	GIT_REPOSITORY https://github.com/rsocket/rsocket-cpp.git
	GIT_TAG master
	DEPENDS folly fizz
	CMAKE_CACHE_ARGS
		-DCMAKE_CXX_FLAGS:STRING=-Wno-pessimizing-move
)

ExternalProject_Add( wangle
	GIT_REPOSITORY https://github.com/facebook/wangle.git
	GIT_TAG v2019.12.06.00
	SOURCE_SUBDIR wangle
	DEPENDS fmt folly rsocket
)

ExternalProject_Add( thrift
	GIT_REPOSITORY https://github.com/facebook/fbthrift.git
	GIT_TAG v2019.12.06.00
	DEPENDS fizz fmt folly gflags glog rsocket wangle zstd
)

ExternalProject_Add( rocksdb
	GIT_REPOSITORY https://github.com/facebook/rocksdb.git
	GIT_TAG v6.4.6
	DEPENDS gflags zstd
	CMAKE_ARGS 
		-DWITH_ZSTD=ON
)
