##
# YAMPL-ZMQ
##
include(ExternalProject)

if (WITH_ZMQ_PLUGIN)	    
    # Pull ZeroMQ  
    ExternalProject_Add(ZeroMQ
        GIT_REPOSITORY "https://github.com/zeromq/libzmq"
        GIT_TAG "4.2.5"
        UPDATE_COMMAND ""
        PATCH_COMMAND ""

        SOURCE_DIR "zeromq"
        CMAKE_ARGS -DZMQ_BUILD_TESTS=OFF -DWITH_PERF_TOOL=OFF -DENABLE_CPACK=OFF
        TEST_COMMAND ""
    )

    add_library(yampl-zmq SHARED
	    plugins/yampl-zmq/src/ClientSocket.cpp
            plugins/yampl-zmq/src/ServerSocket.cpp
            plugins/yampl-zmq/src/SocketBase.cpp
            plugins/yampl-zmq/src/SocketFactory.cpp
            ${YAMPL_PLUGIN_COMMON_SRCS}
    )
    
    add_dependencies(yampl-zmq ZeroMQ)

    target_include_directories(yampl-zmq PRIVATE plugins/yampl-zmq/include)

    set_target_properties(yampl-zmq
            PROPERTIES
            LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/plugins/yampl-zmq"
    )

    install(TARGETS yampl-zmq
            LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/yampl/plugins/yampl-zmq
    )
endif()
