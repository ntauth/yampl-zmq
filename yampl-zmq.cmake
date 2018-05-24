##
# YAMPL-ZMQ
##
include(ExternalProject)

if (WITH_ZMQ_PLUGIN)	    
    # Pull ZeroMQ
    set(ZEROMQ_ROOT ${CMAKE_BINARY_DIR}/zeromq)
    set(ZEROMQ_LIB_DIR ${ZEROMQ_ROOT}/bin/lib)
    set(ZEROMQ_INCLUDE_DIR ${ZEROMQ_ROOT}/bin/include)
    
    ExternalProject_Add(ZeroMQ
        GIT_REPOSITORY "https://github.com/zeromq/libzmq"
        PREFIX ${ZEROMQ_ROOT}
        GIT_TAG "d062edd8c142384792955796329baf1e5a3377cd"
        UPDATE_COMMAND ""
        PATCH_COMMAND ""
        INSTALL_DIR ${ZEROMQ_ROOT}/bin
        CMAKE_ARGS -DZMQ_BUILD_TESTS=OFF -DWITH_PERF_TOOL=OFF -DENABLE_CPACK=OFF -DCMAKE_INSTALL_PREFIX=${ZEROMQ_ROOT}/bin
        BUILD_COMMAND make
        TEST_COMMAND ""
    )

    add_library(yampl-zmq SHARED
	    ${CMAKE_CURRENT_LIST_DIR}/src/ClientSocket.cpp
            ${CMAKE_CURRENT_LIST_DIR}/src/ServerSocket.cpp
            ${CMAKE_CURRENT_LIST_DIR}/src/SocketBase.cpp
            ${CMAKE_CURRENT_LIST_DIR}/src/SocketFactory.cpp
            ${YAMPL_PLUGIN_COMMON_SRCS}
    )
    
    add_dependencies(yampl-zmq ZeroMQ)
    target_include_directories(yampl-zmq PRIVATE ${CMAKE_CURRENT_LIST_DIR}/include/ ${ZEROMQ_INCLUDE_DIR})
    target_link_libraries(yampl-zmq ${ZEROMQ_LIB_DIR}/libzmq.a)

    set_target_properties(yampl-zmq
            PROPERTIES
            LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/plugins/yampl-zmq"
    )

    install(TARGETS yampl-zmq
            LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/yampl/plugins/yampl-zmq
    )
endif()
