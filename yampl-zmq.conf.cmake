# YAMPL-ZMQ
include(ExternalProject)

if (WITH_ZMQ_PLUGIN)	    
    # Pull ZeroMQ
    set(ZEROMQ_ROOT_DIR ${CMAKE_BINARY_DIR}/zeromq)
    set(ZEROMQ_LIB_DIR ${ZEROMQ_ROOT_DIR}/bin/lib)
    set(ZEROMQ_LIB64_DIR ${ZEROMQ_ROOT_DIR}/bin/lib64)
    set(ZEROMQ_INCLUDE_DIR ${ZEROMQ_ROOT_DIR}/bin/include)

    ExternalProject_Add(ZeroMQ
        GIT_REPOSITORY "https://github.com/zeromq/libzmq"
        PREFIX ${ZEROMQ_ROOT_DIR}
        GIT_TAG "d062edd8c142384792955796329baf1e5a3377cd"
        UPDATE_COMMAND ""
        PATCH_COMMAND ""
        INSTALL_DIR ${ZEROMQ_ROOT_DIR}/bin
        CMAKE_ARGS -DZMQ_BUILD_TESTS=OFF -DWITH_PERF_TOOL=OFF -DENABLE_CPACK=OFF -DCMAKE_INSTALL_PREFIX=${ZEROMQ_ROOT_DIR}/bin
        BUILD_COMMAND make
        TEST_COMMAND ""
    )
    
    # Pull CppZMQ
    set(CPPZMQ_ROOT ${CMAKE_BINARY_DIR}/cppzmq)
    set(CPPZMQ_INCLUDE_DIR ${CPPZMQ_ROOT}/src/CppZMQ)

    ExternalProject_Add(CppZMQ
        GIT_REPOSITORY "https://github.com/zeromq/cppzmq"
        PREFIX ${CPPZMQ_ROOT}
        GIT_TAG "6aa3ab686e916cb0e62df7fa7d12e0b13ae9fae6"
        CONFIGURE_COMMAND ""
        UPDATE_COMMAND ""
        PATCH_COMMAND ""
        CMAKE_ARGS ""
        BUILD_COMMAND ""
        TEST_COMMAND ""
        INSTALL_COMMAND ""
    )

    add_library(yampl-zmq SHARED
	    ${CMAKE_CURRENT_LIST_DIR}/src/ClientSocket.cpp
            ${CMAKE_CURRENT_LIST_DIR}/src/ServerSocket.cpp
            ${CMAKE_CURRENT_LIST_DIR}/src/SocketBase.cpp
            ${CMAKE_CURRENT_LIST_DIR}/src/SocketFactory.cpp
            ${CMAKE_CURRENT_LIST_DIR}/src/PluginMain.cpp
            ${YAMPL_PLUGIN_COMMON_SRCS}
    )
        
    target_include_directories(yampl-zmq PRIVATE ${CMAKE_CURRENT_LIST_DIR}/include ${ZEROMQ_INCLUDE_DIR} ${CPPZMQ_INCLUDE_DIR})
    
    file(GLOB ZEROMQ_LINK_LIBRARIES ${ZEROMQ_LIB_DIR}/libzmq.a ${ZEROMQ_LIB64_DIR}/libzmq.a)
    message(STATUS "[+] Linking ${ZEROMQ_LINK_LIBRARIES}")
    target_link_libraries(yampl-zmq ${ZEROMQ_LINK_LIBRARIES})

    add_dependencies(yampl-zmq CppZMQ)
    add_dependencies(CppZMQ ZeroMQ)

    set_target_properties(yampl-zmq
            PROPERTIES
            LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/plugins/yampl-zmq"
    )

    install(TARGETS yampl-zmq
            LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/plugins/yampl-zmq
    )
endif()
