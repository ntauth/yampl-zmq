##
# YAMPL-ZMQ
##
if (WITH_ZMQ_PLUGIN)	    
    add_library(yampl-zmq SHARED
	    plugins/yampl-zmq/src/ClientSocket.cpp
            plugins/yampl-zmq/src/ServerSocket.cpp
            plugins/yampl-zmq/src/SocketBase.cpp
            plugins/yampl-zmq/src/SocketFactory.cpp
            ${YAMPL_PLUGIN_COMMON_SRCS}
    )

    target_include_directories(yampl-zmq PRIVATE plugins/yampl-zmq/include)

    set_target_properties(yampl-zmq
            PROPERTIES
            LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/plugins/yampl-zmq"
    )

    install(TARGETS yampl-zmq
            LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/yampl/plugins/yampl-zmq
    )
endif()
